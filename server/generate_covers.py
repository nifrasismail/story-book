"""
Run once to generate cover images for all stories via Hugging Face Inference API.
Usage: HF_TOKEN=hf_xxx uv run python generate_covers.py
       Generated images are saved locally AND uploaded to GCS automatically.
"""
import json
import os
import time
from pathlib import Path
from huggingface_hub import InferenceClient
from gcs_upload import upload_to_gcs

IMAGES_DIR = Path(__file__).parent / "images"
STORIES_FILE = Path(__file__).parent / "stories.json"

PROMPTS = {
    "three_little_pigs":  "three cute cartoon pig brothers building houses of straw sticks and bricks, warm sunny day",
    "tortoise_hare":      "friendly tortoise and hare racing on a winding path through a sunny meadow, bright colors",
    "goldilocks":         "golden-haired girl peeking into a cozy cottage in the woods with three bears, soft warm colors",
    "red_riding_hood":    "little girl in red cape walking through enchanted forest carrying a basket, magical atmosphere",
    "ugly_duckling":      "small grey duckling alone by a pond surrounded by white swans, soft watercolor style",
    "lion_mouse":         "majestic lion gently holding a tiny mouse in its paw, golden savanna background",
    "ant_grasshopper":    "hardworking ant carrying food while grasshopper plays guitar in summer meadow, bright greens",
    "boy_cried_wolf":     "young shepherd boy on a hill with fluffy sheep and a mischievous grin, rolling green hills",
    "jack_beanstalk":     "boy climbing a giant magical beanstalk reaching into clouds with a castle above, lush greens",
    "frog_prince":        "golden crown wearing frog sitting on a lily pad next to a princess by a sparkling pond",
    "cinderella":         "Cinderella in sparkling blue ball gown with glass slipper and magical fairy godmother, starry night",
    "snow_white":         "kind princess Snow White with seven small dwarfs in a cozy forest cottage, warm glowing light",
    "sleeping_beauty":    "beautiful princess sleeping surrounded by enchanted roses and vines, soft purple tones",
    "rapunzel":           "princess with extremely long golden hair hanging from tall tower window, sunset sky",
    "beauty_beast":       "kind girl and large gentle beast sharing a book in an enchanted castle library, golden candlelight",
    "aladdin":            "boy on flying magic carpet over glowing Arabian city at night with magic lamp, deep blue and gold",
    "little_mermaid":     "young mermaid with red hair gazing up through sparkling ocean water at the surface, ocean blues",
    "hansel_gretel":      "two children discovering a magical candy house in a dark forest, colorful sweets everywhere",
    "thumbelina":         "tiny girl the size of a thumb sitting inside a tulip flower in a garden, soft pink and green",
    "puss_in_boots":      "clever cat wearing boots and a hat striking a confident pose, storybook adventure style",
}


def generate(client: InferenceClient, story_id: str, prompt: str) -> bool:
    out_path = IMAGES_DIR / f"{story_id}.png"
    if out_path.exists():
        print(f"  skip {story_id} (already exists)")
        return True

    full_prompt = f"{prompt}, children's book illustration, vibrant colors, soft art style, high quality"
    print(f"  generating {story_id}...")
    try:
        image = client.text_to_image(full_prompt, model="black-forest-labs/FLUX.1-schnell")
        image.save(str(out_path))
        print(f"  ✓ saved {story_id}.png ({out_path.stat().st_size // 1024}KB)")
        upload_to_gcs(out_path, f"covers/{story_id}.png")
        return True
    except Exception as e:
        print(f"  ✗ failed {story_id}: {e}")
        return False


if __name__ == "__main__":
    hf_token = os.environ.get("HF_TOKEN", "")
    if not hf_token:
        print("Set HF_TOKEN environment variable first.")
        exit(1)

    IMAGES_DIR.mkdir(exist_ok=True)
    client = InferenceClient(token=hf_token)
    stories = json.loads(STORIES_FILE.read_text())
    print(f"Generating covers for {len(stories)} stories...\n")

    for story in stories:
        sid = story["id"]
        prompt = PROMPTS.get(sid, f"illustration for {story['title']}, colorful, magical")
        ok = generate(client, sid, prompt)
        if ok:
            time.sleep(2)

    print("\nDone! Images saved to server/images/")
