"""
Run once to generate page illustrations for all stories via Hugging Face Inference API.
Usage: HF_TOKEN=hf_xxx uv run python generate_page_images.py
       HF_TOKEN=hf_xxx uv run python generate_page_images.py --story three_little_pigs
       Generated images are saved locally AND uploaded to GCS automatically.
"""
import json
import os
import sys
import time
from pathlib import Path
from huggingface_hub import InferenceClient
from gcs_upload import upload_to_gcs

DATA_DIR = Path(__file__).parent / "data"
PAGES_DIR = DATA_DIR / "pages"
PAGE_IMAGES_DIR = Path(__file__).parent / "images" / "pages"

# One prompt per page, keyed by story_id -> list of prompts (index = page number)
PAGE_PROMPTS = {
    "three_little_pigs": [
        "three cute pig brothers hugging their mother outside a cozy cottage, warm sunny meadow",
        "lazy pig happily building a wobbly straw house, golden straw flying everywhere",
        "pig carefully tying sticks together to build a stick house by a river, afternoon light",
        "hardworking pig laying red bricks one by one, tired but proud, sunset glow",
        "big bad wolf with yellow eyes approaching a straw house, dark forest behind",
        "wolf huffing and puffing blowing down a straw house, pigs running in panic",
        "wolf blowing with all his might at a strong brick house that does not move, frustrated wolf",
        "wolf sliding down a chimney into roaring fire below, surprised expression",
        "three pig brothers hugging happily inside a cozy brick house, warm firelight",
    ],
    "tortoise_hare": [
        "boastful brown hare racing past animals in a sunny forest, dust trail behind",
        "calm tortoise smiling up at laughing hare on a forest path, peaceful morning",
        "animals gathered at the starting line with a fox holding a flag, festive atmosphere",
        "hare shooting ahead like a rocket leaving tortoise far behind, motion blur",
        "hare napping under a shady apple tree, sun overhead, snoring peacefully",
        "determined tortoise walking steadily step by step along the winding path",
        "hare waking up horrified as sun sets, leaping to his feet in panic",
        "tortoise crossing the finish line to cheering animals, confetti and celebration",
    ],
    "goldilocks": [
        "golden-haired girl skipping happily into a sunlit forest, curious expression",
        "girl knocking on a cozy red-doored cottage, nobody answering, bears gone for walk",
        "girl tasting three bowls of porridge at a kitchen table, making faces at each one",
        "girl sitting in a tiny chair that cracks and breaks beneath her, startled expression",
        "girl sleeping peacefully in a small cozy bed upstairs, golden curls on pillow",
        "three bears arriving home discovering disturbed bowls, shocked expressions",
        "three bears finding goldilocks asleep, girl waking up screaming and jumping out window",
        "girl running home through the forest, guilty but safe, learning her lesson",
    ],
    "red_riding_hood": [
        "sweet girl in bright red hooded cape receiving a basket from her mother, cozy cottage",
        "girl skipping through dark enchanted forest, red cape bright as a poppy",
        "sly wolf appearing from behind a tree talking to the girl, forest shadows",
        "girl picking wildflowers while wolf races ahead unseen through the trees",
        "wolf in disguise hiding in grandma's bed wearing her cap and glasses, dim room",
        "girl at bedside noticing something strange about grandma, big eyes and teeth revealed",
        "brave woodcutter bursting through the door chasing the wolf away, dramatic rescue",
        "girl hugging grandmother tightly sharing goodies from the basket, warm cozy room",
    ],
    "ugly_duckling": [
        "mother duck with five yellow ducklings and one large grey awkward bird hatching",
        "grey duckling alone crying by a pond while yellow ducklings laugh and point",
        "grey duckling wandering alone through fields and marshes in cold rain",
        "duckling shivering under a hollow log in deep snow, dreaming of spring",
        "duckling stretching enormous wings in spring sunshine and flying for the first time",
        "beautiful white swan looking at its reflection in a shimmering lake, amazed",
        "elegant swans welcoming the new swan warmly, children pointing in delight from bank",
    ],
    "lion_mouse": [
        "mighty lion napping in golden savanna sunshine, paws rising and falling",
        "tiny mouse accidentally running across lion's paw, lion waking up with a roar",
        "small mouse trembling but speaking bravely in lion's giant claws, pleading",
        "lion caught in thick rope net thrashing and unable to escape, desperate",
        "tiny mouse gnawing through ropes with sharp teeth, focused and determined",
        "lion and mouse shaking hands in friendship, grateful lion kneeling down",
    ],
    "ant_grasshopper": [
        "cheerful green grasshopper playing tiny violin on a leaf in sunny summer meadow",
        "tiny ant marching with heavy seeds while grasshopper dances nearby laughing",
        "ant puffing with effort carrying food, warning grasshopper about winter",
        "meadow frozen and bare under deep snow, howling winter winds",
        "shivering grasshopper knocking weakly on ant's cozy underground door in snow",
        "kind ant sharing food with grasshopper while gently giving wise advice, warm den",
    ],
    "boy_cried_wolf": [
        "young shepherd boy on green hill watching fluffy sheep graze, bored expression",
        "boy cupping hands shouting wolf with mischievous grin, farmers below",
        "farmers racing up hill with tools only to find laughing boy and no wolf",
        "boy shouting wolf again laughing while even angrier farmers climb hill",
        "real wolf with yellow gleaming eyes creeping from dark forest toward flock",
        "boy screaming for help on hillside, wolf scattering sheep, no one coming",
        "village elder sitting kindly beside crying boy at sunset, teaching lesson",
    ],
    "jack_beanstalk": [
        "boy leading old cow down country road to market, poor cottage behind",
        "mysterious old man offering glowing magic beans for the cow, twinkling eyes",
        "enormous magical beanstalk growing overnight reaching into clouds, boy staring up",
        "massive stone castle in clouds, boy knocking on giant door, giant woman answering",
        "boy hiding behind furniture while giant commands singing golden harp at dinner",
        "boy grabbing golden harp and sprinting for beanstalk, giant waking and roaring",
        "boy chopping beanstalk with axe, giant falling with enormous crash",
        "boy and mother celebrating with golden harp singing in cozy cottage, joy and gold",
    ],
    "frog_prince": [
        "princess tossing golden ball by forest well, beautiful garden setting",
        "small green frog popping up from dark well while princess cries beside it",
        "frog diving deep into well to retrieve the golden ball, underwater bubbles",
        "frog knocking at grand palace door, king opening it with surprised expression",
        "princess reluctantly letting frog eat from her golden plate at royal dinner",
        "golden light surrounding frog transforming into handsome prince, magical shimmer",
        "princess and prince together in royal garden, happy and smiling",
    ],
    "cinderella": [
        "kind girl sweeping floors in ragged dress while stepsisters lounge, firelight",
        "royal invitation arriving, stepmother sneering, stepsisters in fine gowns leaving",
        "sparkling fairy godmother appearing in golden light, warm and magical",
        "magnificent blue ball gown and sparkling glass slippers, magical transformation",
        "cinderella dancing with the prince under glittering chandeliers, magical ballroom",
        "clock striking midnight, cinderella fleeing down marble steps losing glass slipper",
        "prince searching kingdom with glass slipper, stepsisters failing to fit it",
        "cinderella's foot fitting slipper perfectly, prince taking her hand smiling",
    ],
    "snow_white": [
        "snow white princess with black hair red lips and snow white skin, castle window",
        "evil queen asking magic mirror who is fairest, mirror glowing ominously",
        "kind huntsman secretly letting snow white escape into dark whispering woods",
        "snow white discovering tiny cozy cottage with seven little beds and chairs",
        "seven cheerful dwarfs going to work singing, snow white keeping cottage tidy",
        "evil queen disguised as old woman offering shiny red poisoned apple",
        "dwarfs placing snow white in crystal coffin in forest, prince riding past",
        "snow white waking as spell breaks, prince offering hand, joyful reunion",
    ],
    "sleeping_beauty": [
        "joyful king and queen celebrating baby daughter with twelve good fairies, grand feast",
        "dark fairy sweeping in furiously cursing the baby princess, horrified royals",
        "twelfth good fairy softening the curse with gentle magic, hopeful glow",
        "princess on sixteenth birthday pricking finger on spinning wheel in tower",
        "entire castle falling into enchanted sleep covered in thick thorns and ivy",
        "brave prince hacking through thorns with sword, magical forest parting",
        "prince kissing sleeping princess softly, golden light breaking the spell",
        "princess and prince together as entire castle joyfully wakes up, celebration",
    ],
    "rapunzel": [
        "couple longing for baby, witch demanding payment from her magical garden",
        "rapunzel alone in tall stone tower with impossibly long golden hair, sunset",
        "witch climbing up rapunzel's golden braid like a rope, daily ritual",
        "prince hidden in trees listening to rapunzel's beautiful singing, enchanted",
        "prince climbing up golden braid, rapunzel surprised and shy at their first meeting",
        "angry witch cutting off rapunzel's braid, prince falling into thorns losing sight",
        "blind wandering prince hearing rapunzel's voice, her tears restoring his sight",
        "rapunzel and prince returning to kingdom together seeing the beautiful world",
    ],
    "beauty_beast": [
        "belle reading books in small town while father invents things, warm cottage",
        "terrifying beast imprisoning belle's father in enchanted castle, dark and dramatic",
        "brave belle offering herself in father's place, determined and unafraid",
        "enchanted castle full of wonders talking furniture dancing candles huge library",
        "belle and beast having dinner together talking and laughing, candlelight",
        "beast letting belle go home to sick father, selfless and heartbroken",
        "belle rushing back declaring love, golden light transforming beast into prince",
        "belle and prince together as enchanted castle comes to life around them",
    ],
    "aladdin": [
        "clever street boy aladdin with monkey abu in bustling glowing arabian city",
        "aladdin inside magical cave full of treasure reaching for old lamp, mystical",
        "enormous shimmering blue genie appearing from lamp in thunderous explosion",
        "aladdin disguised as prince riding horse through city gates to meet jasmine",
        "aladdin and jasmine riding magic carpet through starry night sky over the world",
        "evil sorcerer holding the lamp commanding the genie, dark and menacing",
        "clever aladdin tricking sorcerer, using final wish to free the genie forever",
        "jasmine choosing real aladdin over a prince, sultan welcoming him warmly",
    ],
    "little_mermaid": [
        "marina the mermaid with blue shimmering tail gazing up through sparkling ocean",
        "ship sailing in stormy night sea, prince falling overboard, marina diving to save him",
        "marina carrying unconscious prince to moonlit shore, singing softly to him",
        "marina visiting dark sea witch ursula trading her voice for legs, ominous cave",
        "marina walking on land for first time with wonder, prince finding her on beach",
        "prince marrying another girl, marina's heart breaking at dawn, bittersweet",
        "marina rising into golden morning sky as a spirit of air, beautiful and free",
    ],
    "hansel_gretel": [
        "hansel and gretel sleeping while wicked stepmother convinces father to abandon them",
        "clever hansel dropping white pebbles one by one in the dark forest to mark the way",
        "children dropping bread crumbs which birds immediately eat, deeper in dark forest",
        "children discovering magical gingerbread cottage with candy walls, amazed and hungry",
        "old witch locking hansel in cage, making gretel her servant, sinister smile",
        "brave gretel shoving witch into roaring oven and slamming the door, dramatic",
        "gretel freeing hansel grabbing jewels, white duck carrying them across the river",
        "father crying with joy reuniting with children, witch gone, jewels glittering",
    ],
    "thumbelina": [
        "tiny perfect girl born inside a blooming tulip flower, woman watching with love",
        "bumpy toad stealing sleeping thumbelina, fish nibbling lily pad to set her free",
        "thumbelina floating on a leaf eating honey befriending a pretty butterfly in meadow",
        "kind field mouse offering thumbelina shelter from winter in cozy underground home",
        "thumbelina secretly nursing injured swallow back to health in dark tunnel, tender",
        "grateful swallow carrying thumbelina on his back soaring into the blue sky",
        "tiny flower fairy prince placing crown of flowers on thumbelina's head, magical land",
    ],
    "puss_in_boots": [
        "poor young man receiving only an old cat while brothers get mill and donkey",
        "cat speaking clearly asking for boots and a bag, master astonished but agreeing",
        "puss in boots presenting rabbit to king with a dignified bow at royal palace",
        "puss crying for help as master swims in river while royal carriage stops",
        "puss running ahead threatening farmers to claim land for marquis of carabas",
        "puss challenging ogre to transform into a lion, watching with hidden smile",
        "puss pouncing on tiny mouse the ogre transformed into, victorious grin",
        "king offering princess hand to master, puss celebrated as kingdom's cleverest cat",
    ],
}


def generate_page(client: InferenceClient, story_id: str, page_idx: int, prompt: str) -> bool:
    out_dir = PAGE_IMAGES_DIR / story_id
    out_dir.mkdir(parents=True, exist_ok=True)
    out_path = out_dir / f"page_{page_idx}.png"

    if out_path.exists():
        print(f"  skip {story_id}/page_{page_idx} (already exists)")
        return True

    full_prompt = f"{prompt}, children's book illustration, vibrant colors, soft art style, high quality"
    print(f"  generating {story_id}/page_{page_idx}...")
    try:
        image = client.text_to_image(full_prompt, model="black-forest-labs/FLUX.1-schnell")
        image.save(str(out_path))
        print(f"  ✓ saved page_{page_idx}.png ({out_path.stat().st_size // 1024}KB)")
        upload_to_gcs(out_path, f"pages/{story_id}/page_{page_idx}.png")
        return True
    except Exception as e:
        print(f"  ✗ failed {story_id}/page_{page_idx}: {e}")
        return False


if __name__ == "__main__":
    hf_token = os.environ.get("HF_TOKEN", "")
    if not hf_token:
        print("Set HF_TOKEN environment variable first.")
        sys.exit(1)

    # Optional: only generate for one story
    only_story = None
    for arg in sys.argv[1:]:
        if arg.startswith("--story="):
            only_story = arg.split("=", 1)[1]
        elif arg == "--story" and sys.argv.index(arg) + 1 < len(sys.argv):
            only_story = sys.argv[sys.argv.index(arg) + 1]

    PAGE_IMAGES_DIR.mkdir(parents=True, exist_ok=True)
    client = InferenceClient(token=hf_token)

    stories = list(PAGE_PROMPTS.keys())
    if only_story:
        stories = [only_story]

    total = sum(len(PAGE_PROMPTS[s]) for s in stories)
    print(f"Generating page images for {len(stories)} stories ({total} pages total)...\n")

    for story_id in stories:
        prompts = PAGE_PROMPTS[story_id]
        print(f"\n[{story_id}] — {len(prompts)} pages")
        for i, prompt in enumerate(prompts):
            ok = generate_page(client, story_id, i, prompt)
            if ok:
                time.sleep(2)

    print("\nDone! Images saved to server/images/pages/")
