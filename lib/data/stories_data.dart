import 'package:flutter/material.dart';
import '../models/story.dart';

final List<Story> kAllStories = [
  // ─────────────────────────────── FREE STORIES ────────────────────────────
  Story(
    id: 'three_little_pigs',
    title: 'The Three Little Pigs',
    description: 'Three pig brothers learn why working hard is the best way to stay safe.',
    category: StoryCategory.classic,
    ageRange: '4–8 yrs',
    readingTimeMinutes: 5,
    isPremium: false,
    starsReward: 3,
    themeColor: const Color(0xFFFF6B35),
    coverEmoji: '🐷',
    moral: 'Hard work and preparation keep you safe.',
    pages: const [
      StoryPage(
        emoji: '🐷🐷🐷',
        text:
            'Once upon a time, three little pig brothers named Max, Sam, and Ben lived happily with their mother in a cozy cottage at the edge of a meadow. One bright morning, their mother called them together with a warm hug.\n\n"My dear little ones, you are big enough to build your very own homes now! Go out and make me proud!"',
        backgroundColor: Color(0xFFFFF3EE),
      ),
      StoryPage(
        emoji: '🌾',
        text:
            'Lazy Max skipped along the path until he spotted a big pile of golden straw. "This is perfect!" he cheered. In less than an hour, Max had thrown together a wobbly straw house.\n\n"Done! Now I can play ALL day!" He tossed his tools aside and danced in the meadow.',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '🪵',
        text:
            'Sam found a bundle of sticks by the river. He worked through the afternoon, tying and stacking them carefully. By sunset, Sam had a stick house that he was quite proud of.\n\n"Good enough for me!" he said, doing a little dance inside his new home.',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '🧱',
        text:
            'Hard-working Ben chose heavy red bricks. He worked from sunrise to sunset, carefully placing each brick one by one. His back ached and his hooves were tired, but when he finished, his house was SOLID as a rock.\n\n"This will last forever!" Ben smiled proudly.',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '🐺',
        text:
            'Then came the Big Bad Wolf, with his big yellow eyes and enormous jaw!\n\n"I\'m SO hungry," he growled, licking his lips. He trotted up to Max\'s straw house. "Little pig, little pig — let me come IN!"\n\n"Not by the hair of my chinny chin chin!" squeaked Max.',
        backgroundColor: Color(0xFFF3F0FF),
      ),
      StoryPage(
        emoji: '💨🌪️',
        text:
            'The wolf took a huge breath. He HUFFED… and he PUFFED… and he BLEW the straw house down!\n\nMax squealed and sprinted to Sam\'s stick house. They slammed the door. But the wolf came again! He huffed and puffed and blew the stick house DOWN too!',
        backgroundColor: Color(0xFFE8F4FF),
      ),
      StoryPage(
        emoji: '🏰🧱',
        text:
            'The two frightened pigs raced to Ben\'s brick house. SLAM went the door! The wolf arrived, angrier than ever. He huffed and he puffed… and HUFFED and PUFFED with all his might.\n\nBut the brick house stood STRONG! Not one brick moved. The wolf huffed until he turned blue!',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '🔥😤',
        text:
            'Furious, the wolf scrambled up onto the roof and squeezed down the chimney! But the clever pigs had lit a roaring fire below.\n\n"YEOOOW!" The wolf shot back out like a rocket, singed and steaming. He ran far, far away and never troubled the three little pigs ever again!',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '🤗⭐',
        text:
            'Max and Sam hugged their brother Ben tightly. "We\'re so sorry for being lazy!" they said. "Thank YOU for your strong house!"\n\nFrom that day on, the three brothers all lived together in the wonderful brick house, safe, warm, and happy.\n\n🌟 THE END 🌟\n\n💡 Moral: It\'s always worth working hard and being prepared!',
        backgroundColor: Color(0xFFFFF9F0),
      ),
    ],
  ),

  Story(
    id: 'tortoise_hare',
    title: 'The Tortoise and the Hare',
    description: 'A speedy hare learns a big lesson when he races a slow but steady tortoise.',
    category: StoryCategory.fable,
    ageRange: '4–7 yrs',
    readingTimeMinutes: 4,
    isPremium: false,
    starsReward: 2,
    themeColor: const Color(0xFF4ECDC4),
    coverEmoji: '🐢',
    moral: 'Slow and steady wins the race. Never give up!',
    pages: const [
      StoryPage(
        emoji: '🐇🐢',
        text:
            'In a sunny green forest, there lived a super-fast brown Hare who loved to brag. Every single day he would zoom past the other animals shouting, "I am the FASTEST creature alive! No one can beat me!"\n\nThe other animals grew tired of his boasting.',
        backgroundColor: Color(0xFFEEFFFD),
      ),
      StoryPage(
        emoji: '😤💨',
        text:
            'One morning, Hare spotted old Tortoise shuffling slowly along the path. Hare burst out laughing. "Ha ha ha! You\'re so SLOW! A snail could lap you twice!"\n\nTortoise looked up calmly with a kind smile. "Would you care for a race, then?"',
        backgroundColor: Color(0xFFF0FFEA),
      ),
      StoryPage(
        emoji: '🏁🎉',
        text:
            'News spread through the entire forest! The big race was set for Saturday morning. Every animal gathered along the route.\n\nFox held the starting flag high. The finish line was the great oak tree on the far hill. "Ready… Set… GO!" Fox waved the flag!',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '🚀💨',
        text:
            'ZOOM! Hare shot ahead like a rocket! In the blink of an eye, he was halfway to the finish. He glanced back and Tortoise was just a tiny dot far behind.\n\n"HA! This is too easy!" laughed Hare, doing flips on the path. "I have all the time in the world!"',
        backgroundColor: Color(0xFFEEFFFD),
      ),
      StoryPage(
        emoji: '😴💤',
        text:
            '"I\'ll take a little nap," yawned Hare, flopping down under a shady apple tree. "I\'ll still win with PLENTY of time to spare."\n\nSoon he was snoring loudly. Zzzzzzz… The warm sun and buzzing bees made him sleep deeper and deeper.',
        backgroundColor: Color(0xFFF3F0FF),
      ),
      StoryPage(
        emoji: '🚶‍♂️🌿',
        text:
            'Meanwhile, Tortoise kept walking. Step… step… step. He didn\'t rush. He didn\'t rest. He just kept going, one steady foot after another, breathing slowly and smiling.\n\n"Slow and steady," Tortoise whispered to himself. "Slow and steady wins the race."',
        backgroundColor: Color(0xFFF0FFEA),
      ),
      StoryPage(
        emoji: '😱🏃',
        text:
            'When Hare finally opened his eyes, the sun was low in the sky! Birds were chirping the evening song. "Oh NO!" he gasped, leaping to his feet.\n\nHare sprinted faster than he had ever run before — faster than the wind! But it was too late…',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '🏆🎊',
        text:
            'Tortoise crossed the finish line to a HUGE roar from all the animals! Confetti flew everywhere! Tortoise beamed with joy.\n\nHare arrived seconds later, panting hard. "But… but… I\'m FASTER than you!" he gasped.\n\n"You are," smiled Tortoise kindly. "But I never stopped. Never give up!"\n\n🌟 THE END 🌟\n\n💡 Moral: Slow and steady wins the race!',
        backgroundColor: Color(0xFFFFFBEA),
      ),
    ],
  ),

  Story(
    id: 'goldilocks',
    title: 'Goldilocks and the Three Bears',
    description: 'Curious Goldilocks wanders into a bears' cottage and learns about respecting others.',
    category: StoryCategory.classic,
    ageRange: '3–7 yrs',
    readingTimeMinutes: 5,
    isPremium: false,
    starsReward: 3,
    themeColor: const Color(0xFFFFE66D),
    coverEmoji: '🐻',
    moral: 'Always respect other people\'s belongings.',
    pages: const [
      StoryPage(
        emoji: '👧🌲',
        text:
            'Deep in a beautiful forest lived a little girl with curly golden hair — everyone called her Goldilocks! One morning, she skipped into the forest to explore, even though her mother had told her not to wander too far.',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '🏡🐻',
        text:
            'Soon Goldilocks came upon a cozy little cottage with a bright red door. She knocked — no answer! The three bears who lived there had just gone for a walk while their porridge cooled.\n\nGoldilocks pushed the door open and stepped inside. "Hello?" she called.',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '🥣🥄',
        text:
            'On the kitchen table were three bowls of porridge. Goldilocks was hungry!\n\nShe tried the biggest bowl — "Too HOT!" Then the middle bowl — "Too COLD!" Finally the tiny little bowl — "MMM! Just right!" She ate every single spoonful.',
        backgroundColor: Color(0xFFFFF9F0),
      ),
      StoryPage(
        emoji: '🪑💥',
        text:
            'In the living room were three chairs. She tried the big chair — "Too hard!" The medium chair — "Too soft!" Then the teeny tiny chair — "Just right!"\n\nBut she rocked too hard and… CRACK! The little chair broke into pieces! Goldilocks jumped up with a squeak.',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '🛏️😴',
        text:
            'Upstairs were three beds. Goldilocks yawned sleepily. She tried the big bed — "Too hard!" The medium bed — "Too lumpy!" Then the tiny little bed — "Ohhh, just perfect!"\n\nShe snuggled in and fell fast asleep, her golden curls spread over the pillow.',
        backgroundColor: Color(0xFFEEFFFD),
      ),
      StoryPage(
        emoji: '🐻🐻🐻',
        text:
            'Just then, the three bears came home — big Papa Bear, medium Mama Bear, and tiny Baby Bear. Papa Bear growled, "Someone\'s been eating MY porridge!" Mama Bear gasped, "Someone\'s been eating MINE!" Baby Bear wailed, "Someone ate ALL of mine!"',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '😱🏃‍♀️',
        text:
            'They searched the house and found their chairs disturbed and Baby Bear\'s chair in pieces! Then they tiptoed upstairs — and there was Goldilocks, fast asleep in Baby Bear\'s bed!\n\nBaby Bear squeaked, "Someone\'s sleeping in MY bed!" Goldilocks woke with a gasp and scrambled out the window!',
        backgroundColor: Color(0xFFF3F0FF),
      ),
      StoryPage(
        emoji: '🤔💛',
        text:
            'Goldilocks ran home as fast as her legs could carry her. She was safe, but very, very sorry. She told her mother everything and promised never to enter someone\'s home without permission again.\n\n🌟 THE END 🌟\n\n💡 Moral: Always respect other people\'s belongings!',
        backgroundColor: Color(0xFFFFFBEA),
      ),
    ],
  ),

  Story(
    id: 'red_riding_hood',
    title: 'Little Red Riding Hood',
    description: 'A brave little girl outwits a sneaky wolf on her way to grandma\'s house.',
    category: StoryCategory.classic,
    ageRange: '4–8 yrs',
    readingTimeMinutes: 5,
    isPremium: false,
    starsReward: 3,
    themeColor: const Color(0xFFFF6B9D),
    coverEmoji: '🧺',
    moral: 'Be careful with strangers and always keep your promises.',
    pages: const [
      StoryPage(
        emoji: '👧🔴',
        text:
            'Once upon a time there was a sweet little girl who wore a bright red cloak with a hood every day. Everyone in the village called her Little Red Riding Hood.\n\nOne morning, her mother packed a basket of fresh goodies. "Please take these to Grandma — she\'s feeling poorly today!"',
        backgroundColor: Color(0xFFFFF0F5),
      ),
      StoryPage(
        emoji: '🌲🌲🌲',
        text:
            '"Remember," said her mother, "go straight through the forest. Don\'t talk to strangers and don\'t leave the path!"\n\n"I promise, Mama!" said Red Riding Hood, and off she skipped into the dark green forest, her red cloak bright as a poppy.',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '🐺😈',
        text:
            'Deep in the forest, a sly Big Bad Wolf appeared from behind a tree. "Hello, little girl! Where are you going?" he asked sweetly.\n\nRed Riding Hood forgot her mother\'s warning. "To Grandma\'s cottage through the forest!"\n\nThe wolf grinned a big toothy grin.',
        backgroundColor: Color(0xFFF3F0FF),
      ),
      StoryPage(
        emoji: '🌸🏃',
        text:
            '"Why not pick some flowers for your grandmother?" said the wolf with a sly wink. While Red Riding Hood stopped to gather a beautiful bunch of wildflowers, the wolf raced ahead to Grandma\'s cottage on the other side of the forest.',
        backgroundColor: Color(0xFFFFF9F0),
      ),
      StoryPage(
        emoji: '🏠😨',
        text:
            'The wolf knocked on Grandma\'s door and pretended to be Red Riding Hood. Poor Grandma let him in! The wolf quickly locked Grandma safely in the closet and disguised himself in her bed, wearing her cap and glasses.',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '🛏️👀',
        text:
            'Red Riding Hood arrived and knocked. "Come in, my dear!" called the wolf in a squeaky voice. She stepped inside and noticed something strange.\n\n"What big EYES you have, Grandma!" "All the better to see you with!"\n"What big EARS!" "All the better to hear you!" "What big TEETH—" "ALL THE BETTER TO EAT YOU!"',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '🪓🦸',
        text:
            'Red Riding Hood screamed! Luckily, a brave woodcutter was walking nearby and heard the scream. He burst through the door and chased the wolf far away into the dark forest!\n\nThen he opened the closet and out tumbled Grandma — safe and sound!',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '🤗🧺',
        text:
            'Red Riding Hood hugged her grandmother tightly. They sat together and shared all the goodies from the basket. From that day on, Red Riding Hood always kept her mother\'s advice and never spoke to strangers in the forest.\n\n🌟 THE END 🌟\n\n💡 Moral: Always be careful with strangers!',
        backgroundColor: Color(0xFFFFF9F0),
      ),
    ],
  ),

  Story(
    id: 'ugly_duckling',
    title: 'The Ugly Duckling',
    description: 'A little duckling who feels different discovers something wonderful about himself.',
    category: StoryCategory.classic,
    ageRange: '4–8 yrs',
    readingTimeMinutes: 5,
    isPremium: false,
    starsReward: 3,
    themeColor: const Color(0xFF95D5B2),
    coverEmoji: '🦢',
    moral: 'Everyone is beautiful in their own way.',
    pages: const [
      StoryPage(
        emoji: '🥚🐣',
        text:
            'On a lovely farm beside a sparkling pond, a mother duck sat patiently on her nest. One by one, the eggs cracked open — pop, pop, pop! Out tumbled five fluffy yellow ducklings.\n\nBut the biggest egg was still hatching. When it finally opened, out came a large, grey, awkward little bird.',
        backgroundColor: Color(0xFFF0FFFA),
      ),
      StoryPage(
        emoji: '😢💧',
        text:
            'The other ducklings laughed at him. "You\'re so UGLY!" they quacked. "You don\'t look like us at all!" Even the farm animals teased him. Only his mother was kind.\n\nThe little grey duckling felt very sad and very lonely. "Why am I so different?" he wondered.',
        backgroundColor: Color(0xFFEEFFFD),
      ),
      StoryPage(
        emoji: '🏃💨',
        text:
            'Unable to bear the teasing any longer, the duckling ran away from the farm. He wandered through fields and marshes, looking for somewhere he belonged. Everywhere he went, birds and animals turned away and called him ugly.\n\nHe was cold, hungry, and very, very alone.',
        backgroundColor: Color(0xFFF3F0FF),
      ),
      StoryPage(
        emoji: '❄️🥶',
        text:
            'Winter came and the pond froze over. The poor duckling shivered beneath a hollow log, barely surviving the bitter cold. He dreamed of spring and of finding friends who would love him just as he was.\n\n"Will anyone ever care for me?" he asked the silent snowflakes.',
        backgroundColor: Color(0xFFE8F4FF),
      ),
      StoryPage(
        emoji: '🌸☀️',
        text:
            'At last, spring arrived! The ice melted, flowers bloomed, and warm sunshine filled the world. The duckling stretched his wings — they felt enormous and powerful!\n\nHe flapped them once… twice… and to his amazement, he FLEW up into the clear blue sky!',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '🦢🌊',
        text:
            'He glided down to a beautiful lake and landed on the shimmering water. He peered at his reflection and could not believe his eyes.\n\nThe ugly grey duckling was gone. Instead, a magnificent white swan gazed back at him — graceful, beautiful, and perfect!',
        backgroundColor: Color(0xFFF0FFFA),
      ),
      StoryPage(
        emoji: '🤗🦢🦢',
        text:
            'A group of elegant swans swam over and welcomed him warmly. "You\'re one of us!" they said joyfully.\n\nChildren on the bank pointed and gasped, "Look at that beautiful swan!" For the first time in his life, the swan felt happy, loved, and exactly where he belonged.\n\n🌟 THE END 🌟\n\n💡 Moral: Everyone is beautiful in their own special way!',
        backgroundColor: Color(0xFFFFF9F0),
      ),
    ],
  ),

  Story(
    id: 'lion_mouse',
    title: 'The Lion and the Mouse',
    description: 'A tiny mouse proves that even the smallest friend can save the day.',
    category: StoryCategory.fable,
    ageRange: '4–7 yrs',
    readingTimeMinutes: 4,
    isPremium: false,
    starsReward: 2,
    themeColor: const Color(0xFFF4A261),
    coverEmoji: '🦁',
    moral: 'Even small friends can make a big difference.',
    pages: const [
      StoryPage(
        emoji: '🦁😴',
        text:
            'In the heart of a great jungle, the mighty Lion — King of all animals — was having a long, peaceful nap in the warm afternoon sunshine. His golden mane shone like sunlight and his big paws rose and fell with each snore.',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '🐭💨',
        text:
            'A tiny Mouse was scurrying through the jungle, not looking where she was going. She ran right across the Lion\'s giant paw! Lion woke up with a roar and grabbed the tiny mouse in his enormous claws.\n\n"How DARE you wake the King!" he growled.',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '🙏🐭',
        text:
            'The Mouse trembled but bravely spoke up. "Please, great King! Let me go! I promise that someday I will repay your kindness!"\n\nThe Lion burst out laughing. "Ha! What could a tiny thing like YOU ever do for ME?" But feeling amused, he opened his paw and let her go.',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '🕸️😰',
        text:
            'Days later, the Mouse heard a terrible roar echoing through the jungle. She raced toward the sound and found the mighty Lion tangled in a hunter\'s thick rope net! He thrashed and pulled but could not break free.',
        backgroundColor: Color(0xFFF3F0FF),
      ),
      StoryPage(
        emoji: '🐭✂️',
        text:
            '"Do not worry, great King! I\'ll help you!" squeaked the Mouse. She began gnawing at the ropes with her tiny sharp teeth — nibble, nibble, nibble — faster and faster!\n\nOne by one, the thick ropes snapped. The Lion was FREE!',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '🦁🤝🐭',
        text:
            'The great Lion looked at the tiny Mouse with astonishment and deep gratitude. "Little friend, I laughed at you before," he said softly. "I was wrong. You have saved my life. We will always be the best of friends."\n\n🌟 THE END 🌟\n\n💡 Moral: Even small friends can make a huge difference!',
        backgroundColor: Color(0xFFFFF9F0),
      ),
    ],
  ),

  Story(
    id: 'ant_grasshopper',
    title: 'The Ant and the Grasshopper',
    description: 'A grasshopper who plays all summer learns an important lesson about working ahead.',
    category: StoryCategory.fable,
    ageRange: '4–7 yrs',
    readingTimeMinutes: 4,
    isPremium: false,
    starsReward: 2,
    themeColor: const Color(0xFF52B788),
    coverEmoji: '🐜',
    moral: 'Work hard in good times to prepare for hard times.',
    pages: const [
      StoryPage(
        emoji: '☀️🌻',
        text:
            'It was a glorious summer! The meadow was full of flowers, the air smelled sweet, and the sun shone warm and bright. A cheerful green Grasshopper sat on a leaf, playing his tiny violin all day long.\n\nHe sang, danced, and leaped from flower to flower without a care.',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '🐜🌾',
        text:
            'Nearby, a little Ant was working very hard — marching back and forth, back and forth, carrying seeds and crumbs ten times her own weight to store in her underground home.\n\n"Why work so hard?" laughed Grasshopper. "Come and play with me! Summer is for fun!"',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '🐜💪',
        text:
            '"Winter is coming," said Ant, puffing with effort. "I must prepare. There will be no food then."\n\nGrasshopper waved his leg dismissively. "Winter is AGES away! Worry about that later!" And he went right back to singing and dancing in the warm sunshine.',
        backgroundColor: Color(0xFFF3F0FF),
      ),
      StoryPage(
        emoji: '❄️🌨️',
        text:
            'But autumn came quickly, and then — WHOOSH — winter arrived with howling winds and deep, deep snow. The meadow was frozen and bare. Every flower and leaf had vanished.\n\nGrasshopper had nothing to eat. He was cold, hungry, and very, very sorry.',
        backgroundColor: Color(0xFFE8F4FF),
      ),
      StoryPage(
        emoji: '🐜🏠',
        text:
            'He trudged through the snow to Ant\'s cozy underground home and knocked weakly. Ant opened the door, warm and well-fed from her stores of summer food.\n\n"Please," shivered Grasshopper, "do you have any food to share? I worked so hard on my music..."',
        backgroundColor: Color(0xFFFFF9F0),
      ),
      StoryPage(
        emoji: '❤️🌟',
        text:
            'Kind Ant shared some of her food, but she said gently, "I will help you this time. But next summer, please remember to work AND play. Music is lovely, but a full belly matters too!"\n\nGrasshopper nodded gratefully. He never forgot that lesson.\n\n🌟 THE END 🌟\n\n💡 Moral: Work hard today to be ready for tomorrow!',
        backgroundColor: Color(0xFFF0FFF4),
      ),
    ],
  ),

  Story(
    id: 'boy_cried_wolf',
    title: 'The Boy Who Cried Wolf',
    description: 'A shepherd boy learns the hard way that dishonesty has serious consequences.',
    category: StoryCategory.fable,
    ageRange: '5–9 yrs',
    readingTimeMinutes: 4,
    isPremium: false,
    starsReward: 2,
    themeColor: const Color(0xFFC77DFF),
    coverEmoji: '🐑',
    moral: 'Always tell the truth — no one believes a liar.',
    pages: const [
      StoryPage(
        emoji: '👦🐑',
        text:
            'In a small village on the edge of rolling green hills, a young shepherd boy looked after a large flock of fluffy white sheep every day. His job was to keep them safe from wolves while the village farmers worked the fields below.',
        backgroundColor: Color(0xFFF5F0FF),
      ),
      StoryPage(
        emoji: '😴😒',
        text:
            'Day after day, nothing exciting ever happened. The boy grew terribly bored watching the sheep munch grass. "I know how to have some fun!" he said with a mischievous grin.\n\nHe cupped his hands and screamed: "WOLF! WOLF! There\'s a wolf attacking the sheep!"',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '🏃🏃🏃',
        text:
            'The farmers dropped their tools and came racing up the hill, panting and worried. But when they arrived, there was no wolf — just the boy laughing hysterically.\n\n"Ha ha ha! I was just joking!" The farmers shook their heads and went back to work, grumbling.',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '😈😄',
        text:
            'The next week, bored again, the boy cried wolf a second time. "WOLF! WOLF! Help! It\'s real this time!"\n\nAgain the farmers ran up the hill. Again there was no wolf. This time they were much angrier. "Stop lying!" they warned. "We won\'t come again!"',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '🐺👀',
        text:
            'Then one grey afternoon, a REAL wolf crept out of the dark forest, his yellow eyes gleaming. He snarled and lunged at the flock! The terrified boy screamed at the top of his lungs.\n\n"WOLF! WOLF! PLEASE HELP ME! IT\'S REAL! IT\'S REAL!"',
        backgroundColor: Color(0xFFF3F0FF),
      ),
      StoryPage(
        emoji: '😔💧',
        text:
            'But the farmers heard him and said, "That boy is lying again." No one came. The wolf scattered the sheep across the hills, and the boy sat alone on the hillside, crying real tears.\n\nThat evening, the village elder sat beside him and said softly, "Now you understand."',
        backgroundColor: Color(0xFFF5F0FF),
      ),
      StoryPage(
        emoji: '❤️📖',
        text:
            '"Nobody believes a liar, even when they tell the truth," said the elder gently. "Honesty is the most important gift you can give to others — and to yourself."\n\nThe boy never lied again.\n\n🌟 THE END 🌟\n\n💡 Moral: Always tell the truth. A liar is never believed!',
        backgroundColor: Color(0xFFFFF9F0),
      ),
    ],
  ),

  Story(
    id: 'jack_beanstalk',
    title: 'Jack and the Beanstalk',
    description: 'Jack trades their cow for magic beans and discovers a giant\'s world in the clouds.',
    category: StoryCategory.adventure,
    ageRange: '5–9 yrs',
    readingTimeMinutes: 6,
    isPremium: false,
    starsReward: 4,
    themeColor: const Color(0xFF4ADE80),
    coverEmoji: '🌱',
    moral: 'Be brave, be clever, and always protect your family.',
    pages: const [
      StoryPage(
        emoji: '👦🐄',
        text:
            'Once upon a time, a boy named Jack lived with his poor mother in a tiny cottage. They had only one possession — an old cow named Daisy. One day, when they had no food left, his mother sighed, "Jack, take Daisy to the market and sell her."',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '🫘✨',
        text:
            'On the way to market, Jack met a mysterious old man. "I\'ll trade you these magic beans for your cow!" said the man with twinkling eyes. Jack was enchanted and agreed.\n\nBut when he got home, his mother wept and threw the beans out the window in anger.',
        backgroundColor: Color(0xFFFFF9F0),
      ),
      StoryPage(
        emoji: '🌱🌲☁️',
        text:
            'That night, the magic beans sprouted! By morning, an enormous beanstalk had grown so tall it disappeared into the clouds. Jack looked up with wonder and excitement — and began to CLIMB!\n\nUp, up, up he went, higher than the birds, all the way into the clouds.',
        backgroundColor: Color(0xFFEEFFFD),
      ),
      StoryPage(
        emoji: '🏰👣',
        text:
            'At the top lived a massive stone castle! Jack knocked and a giant woman opened the door. "Please, may I have some breakfast?" he asked. She was kind and let him in — but suddenly the whole castle SHOOK!\n\n"FEE-FI-FO-FUM! I smell a boy!" roared a terrifying GIANT!',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '🏃💨🎵',
        text:
            'Jack hid quickly while the giant sat down for his meal. Then the giant commanded, "Sing, harp! Sing!" A beautiful golden harp began to play magical music all by itself. Jack\'s eyes went wide — he remembered stories of his father\'s stolen treasures!',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '🪙⚡',
        text:
            'While the giant dozed, Jack grabbed the golden harp and raced for the beanstalk! But the harp cried out, "Master! Master!" The giant woke with a roar and thundered after Jack!\n\nJack flew down the beanstalk as fast as lightning — SWISH SWISH SWISH!',
        backgroundColor: Color(0xFFF3F0FF),
      ),
      StoryPage(
        emoji: '🪓🌱💥',
        text:
            '"Mama! The axe! QUICKLY!" Jack called. His mother ran out with the axe. CHOP CHOP CHOP! The great beanstalk cracked and swayed — CRASH! The giant fell with an enormous BOOM and was never seen again.',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '🎉💰',
        text:
            'The golden harp sang beautiful songs, filling the cottage with joy. They were never poor or hungry again. Jack\'s bravery had given them the life they deserved.\n\n🌟 THE END 🌟\n\n💡 Moral: Courage and cleverness can overcome even the biggest giants!',
        backgroundColor: Color(0xFFFFF9F0),
      ),
    ],
  ),

  Story(
    id: 'frog_prince',
    title: 'The Frog Prince',
    description: 'A princess learns the value of keeping promises when a frog asks for her friendship.',
    category: StoryCategory.classic,
    ageRange: '4–8 yrs',
    readingTimeMinutes: 5,
    isPremium: false,
    starsReward: 3,
    themeColor: const Color(0xFF6DBE45),
    coverEmoji: '🐸',
    moral: 'Always keep your promises, no matter what.',
    pages: const [
      StoryPage(
        emoji: '👸⚽',
        text:
            'A beautiful princess loved to play in the cool garden beside a deep forest well. Her most precious treasure was a golden ball that gleamed in the sunlight.\n\nOne afternoon, she tossed it too high — and it slipped from her fingers and fell — SPLASH! — into the dark well below.',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '🐸💬',
        text:
            'The princess began to cry. Suddenly a small green frog popped up from the water. "Why do you cry, Princess?" he croaked.\n\n"My golden ball!" she sobbed. The frog said, "I will get it back for you — if you promise to be my friend, let me eat from your plate, and sleep on your pillow!"',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '⚽✨',
        text:
            '"Yes, yes, of course!" the princess agreed quickly. The frog dove deep into the well and came back up with the golden ball gleaming in his tiny mouth.\n\nThe princess grabbed it and RAN back to the palace — completely forgetting about her promise!',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '🐸🚪',
        text:
            'That evening at dinner, there was a knock at the palace door. The King himself opened it — and there sat a small green frog! "Your daughter promised to be my friend," he said.\n\nThe King looked at his daughter. "A princess ALWAYS keeps her promises," he said firmly.',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '🍽️🐸',
        text:
            'Unhappily, the princess let the frog eat from her golden plate. Then she let him sit beside her at dinner, even though she found it very difficult. The King watched with quiet approval.\n\n"A true princess," he said, "is known by her word."',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '🤴✨',
        text:
            'When the princess finally carried the frog to her room as promised, something magical happened! A shimmer of golden light surrounded him — and suddenly, a handsome prince stood before her!\n\n"A wicked witch turned me into a frog," he explained. "Only true friendship could break the spell!"',
        backgroundColor: Color(0xFFF3F0FF),
      ),
      StoryPage(
        emoji: '👸🤴👑',
        text:
            'The princess and the prince became the very best of friends, and in time they ruled the kingdom together with kindness and wisdom.\n\n🌟 THE END 🌟\n\n💡 Moral: Always keep your promises — they matter more than you think!',
        backgroundColor: Color(0xFFFFF9F0),
      ),
    ],
  ),

  // ─────────────────────────────── PREMIUM STORIES ─────────────────────────
  Story(
    id: 'cinderella',
    title: 'Cinderella',
    description: 'A kind-hearted girl finds her destiny with a little help from a magical fairy godmother.',
    category: StoryCategory.fairyTale,
    ageRange: '5–10 yrs',
    readingTimeMinutes: 8,
    isPremium: true,
    starsReward: 5,
    themeColor: const Color(0xFF60B8FF),
    coverEmoji: '👠',
    moral: 'Kindness and goodness will always be rewarded.',
    pages: const [
      StoryPage(
        emoji: '👧💙',
        text:
            'Once upon a time, a gentle and kind girl named Ella lived with her stepmother and two stepsisters. Though they made her sweep, cook, and clean from sunrise to sunset, Ella\'s heart was always full of hope and kindness.\n\nThe other servants called her Cinderella because of the cinders on her dress.',
        backgroundColor: Color(0xFFEEF6FF),
      ),
      StoryPage(
        emoji: '📜👑',
        text:
            'One day, a royal invitation arrived — the Prince was holding a grand ball and invited every maiden in the kingdom!\n\n"You CANNOT go," sneered the stepmother. "You have nothing to wear!" The stepsisters laughed and left in their finest gowns. Cinderella sat by the fireplace and wept.',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '🧚‍♀️✨',
        text:
            'Suddenly — POOF! — a warm golden light filled the room. A small, sparkling fairy godmother appeared! "Dry your tears, dear child," she said warmly. "You SHALL go to the ball!"\n\nWith a wave of her wand, a beautiful silver coach appeared from a pumpkin, and horses from mice!',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '👗💎',
        text:
            'Another wave of the wand — and Cinderella\'s rags became the most magnificent blue ball gown! Her feet were dressed in tiny glass slippers that sparkled like diamonds.\n\n"But remember," warned the fairy godmother, "the magic ends at midnight. You must leave before the clock strikes twelve!"',
        backgroundColor: Color(0xFFEEF6FF),
      ),
      StoryPage(
        emoji: '🏰💃',
        text:
            'At the palace, everyone gasped at the mysterious beautiful girl. The Prince himself walked straight over and asked her to dance. They danced all evening under the glittering chandeliers, talking and laughing, feeling as if they had known each other forever.',
        backgroundColor: Color(0xFFF5F0FF),
      ),
      StoryPage(
        emoji: '🕛⏰',
        text:
            'BONG! The clock began to strike midnight! Cinderella gasped and ran, leaving the Prince reaching out for her hand. She flew down the marble steps — and in her hurry, one glass slipper fell off!\n\nShe vanished into the night, leaving only the tiny, sparkling slipper behind.',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '👠🔍',
        text:
            'The Prince could think of no one else. He traveled the entire kingdom with the glass slipper, searching for its owner. Every girl tried it on, but it fit no one.\n\nAt last they came to Cinderella\'s home. The stepsisters pushed and shoved but their feet were far too big!',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '👸💍',
        text:
            'Then Cinderella stepped forward quietly. The slipper slid onto her foot perfectly — a flawless fit!\n\nThe Prince took her hand with a radiant smile. Cinderella\'s kindness and grace had won his heart completely. They were married and lived in joy and happiness forever after.\n\n🌟 THE END 🌟\n\n💡 Moral: Kindness and goodness are always rewarded!',
        backgroundColor: Color(0xFFFFF9F0),
      ),
    ],
  ),

  Story(
    id: 'snow_white',
    title: 'Snow White',
    description: 'A princess with a heart of gold hides from a jealous queen with seven little dwarfs.',
    category: StoryCategory.fairyTale,
    ageRange: '5–10 yrs',
    readingTimeMinutes: 8,
    isPremium: true,
    starsReward: 5,
    themeColor: const Color(0xFFFF6B6B),
    coverEmoji: '🍎',
    moral: 'Beauty is in the heart, not in the mirror.',
    pages: const [
      StoryPage(
        emoji: '👸❄️',
        text:
            'Once there was a princess named Snow White, with skin as white as snow, lips as red as roses, and hair as black as ebony. Her mother had died, and her father remarried a vain queen who had a magic mirror on the wall.',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '🪞😡',
        text:
            '"Mirror, mirror on the wall, who is the fairest of them all?" the Queen asked every morning. For years the mirror answered, "You, my Queen."\n\nBut one morning it replied, "Snow White is the fairest!" The Queen\'s face twisted with jealous rage.',
        backgroundColor: Color(0xFFF5F0FF),
      ),
      StoryPage(
        emoji: '🌲🐇',
        text:
            'The Queen ordered a huntsman to take Snow White into the forest and never let her return. But kind-hearted huntsman could not harm the sweet princess.\n\n"Run, child! Hide deep in the forest and never come back!" he urged. Snow White ran deep into the dark, whispering woods.',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '🏡🌟',
        text:
            'Tired and frightened, Snow White stumbled upon a tiny, cozy cottage. Inside were seven little beds, seven little chairs, and seven little bowls. She curled up on the beds and fell fast asleep.\n\nWhen she woke, seven little dwarfs were watching her with curious, friendly faces!',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '⛏️🎵',
        text:
            '"We are miners!" said the eldest dwarf. "You may live with us if you cook and keep our home tidy." Snow White happily agreed. Every day, the seven dwarfs went to work singing, and Snow White kept their cottage bright and cheerful.',
        backgroundColor: Color(0xFFEEFFFD),
      ),
      StoryPage(
        emoji: '🍎😵',
        text:
            'But the Queen\'s mirror told her that Snow White still lived! She disguised herself as an old woman and brought a poisoned apple to the cottage. "Try this beautiful red apple!" she coaxed.\n\nSnow White took one bite and fell into a deep, unbreakable sleep.',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '💎⚰️',
        text:
            'The heartbroken dwarfs placed Snow White in a crystal coffin in the forest, watching over her with tears in their eyes. Time passed, and one day a handsome Prince rode past. He was so moved by her beauty that he gently kissed her hand.',
        backgroundColor: Color(0xFFE8F4FF),
      ),
      StoryPage(
        emoji: '👸💞',
        text:
            'The spell broke! Snow White opened her beautiful eyes. The Prince had undone the Queen\'s evil magic with true love.\n\nThey rode away together to his kingdom, where Snow White lived in joy for the rest of her days, always remembering her seven loyal dwarf friends.\n\n🌟 THE END 🌟\n\n💡 Moral: A kind heart will always shine through!',
        backgroundColor: Color(0xFFFFF9F0),
      ),
    ],
  ),

  Story(
    id: 'sleeping_beauty',
    title: 'Sleeping Beauty',
    description: 'A princess falls under a witch\'s spell and must wait for true love\'s courage to wake her.',
    category: StoryCategory.fairyTale,
    ageRange: '5–10 yrs',
    readingTimeMinutes: 7,
    isPremium: true,
    starsReward: 5,
    themeColor: const Color(0xFFFF8FB1),
    coverEmoji: '🌹',
    moral: 'True courage and love can break any curse.',
    pages: const [
      StoryPage(
        emoji: '👸🎉',
        text:
            'A joyful king and queen celebrated the birth of their baby daughter with a great feast. Twelve good fairies were invited to bless the child with gifts — beauty, kindness, wisdom, laughter, and more.\n\nBut they forgot to invite the thirteenth, dark fairy.',
        backgroundColor: Color(0xFFFFF0F5),
      ),
      StoryPage(
        emoji: '🧙‍♀️💀',
        text:
            'The dark fairy swept in uninvited, her eyes blazing with fury. "My gift," she hissed, "is THIS — on her sixteenth birthday, the princess shall prick her finger on a spindle… and DIE!"\n\nThe king and queen wept in horror. But the twelfth fairy stepped forward.',
        backgroundColor: Color(0xFFF3F0FF),
      ),
      StoryPage(
        emoji: '✨💤',
        text:
            '"I cannot undo the curse," said the twelfth fairy gently, "but I can soften it. She will not die — instead she will fall into a deep sleep, and only true love\'s kiss shall wake her."\n\nThe king ordered every spindle in the kingdom burned. But fate is stubborn.',
        backgroundColor: Color(0xFFEEF6FF),
      ),
      StoryPage(
        emoji: '🎂🌀',
        text:
            'On her sixteenth birthday, the princess wandered into a tower and found an old woman spinning. Curious, she reached out to touch the spindle.\n\nPRICK! One tiny drop of blood fell. The princess\'s eyes fluttered closed. She fell into a deep, enchanted sleep.',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '🌿🏰',
        text:
            'The good fairy cast a sleeping spell on the whole castle to keep the princess company. Thick thorns and ivy grew over the walls, hiding the palace from the world.\n\nFor one hundred years the castle slept, silent as a dream, hidden deep in the enchanted forest.',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '🤴⚔️',
        text:
            'One day, a brave young prince heard the legend of the sleeping princess. Without hesitation, he rode into the forest and hacked through the thorns with his sword. The brambles parted before him as if by magic!\n\nHe found the silent castle and climbed to the tower.',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '💋✨',
        text:
            'There lay the princess, peacefully sleeping. Moved by her gentle face, the Prince bent down and kissed her softly on the cheek.\n\nAt once her eyes opened, and she smiled as if waking from the most beautiful dream. The whole castle stirred — everyone woke at the same moment!',
        backgroundColor: Color(0xFFFFF0F5),
      ),
      StoryPage(
        emoji: '💑🌟',
        text:
            'The princess and prince looked at each other and knew they were meant to be together. They were married in a beautiful ceremony, and the kingdom celebrated with music, dancing, and joy for seven days and nights.\n\n🌟 THE END 🌟\n\n💡 Moral: True courage and love can break any curse!',
        backgroundColor: Color(0xFFFFF9F0),
      ),
    ],
  ),

  Story(
    id: 'rapunzel',
    title: 'Rapunzel',
    description: 'A girl with magical golden hair finds freedom and courage in an unexpected friendship.',
    category: StoryCategory.fairyTale,
    ageRange: '5–10 yrs',
    readingTimeMinutes: 7,
    isPremium: true,
    starsReward: 5,
    themeColor: const Color(0xFFB5A9F5),
    coverEmoji: '👸',
    moral: 'True freedom comes from within — never give up hope.',
    pages: const [
      StoryPage(
        emoji: '🏠💛',
        text:
            'A couple longed for a baby for many years. When their wish finally came true, a greedy witch demanded the baby as payment for herbs the couple had stolen from her garden.\n\nThe tiny girl was named Rapunzel, and the witch took her away at birth.',
        backgroundColor: Color(0xFFF5F0FF),
      ),
      StoryPage(
        emoji: '🗼🌿',
        text:
            'The witch locked Rapunzel in a tall stone tower in the middle of a forest. There were no stairs and no door — only one high window. Rapunzel grew up alone, singing songs and watching the world far below.\n\nShe had one extraordinary gift: golden hair that grew incredibly long.',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '👩‍🦱🧙‍♀️',
        text:
            'Every day the witch called up: "Rapunzel, Rapunzel — let down your golden hair!" And Rapunzel would unroll her braid out the window like a rope for the witch to climb.\n\nRapunzel had never seen anyone else in her whole life.',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '🤴🎵',
        text:
            'One day, a young prince rode through the forest and heard the most beautiful singing drifting from the tower. He circled the tower for days, wondering how to get in. Then one morning he hid and watched as the witch called up to the tower...',
        backgroundColor: Color(0xFFEEF6FF),
      ),
      StoryPage(
        emoji: '💛🧗',
        text:
            'The next day, the Prince called out in the witch\'s voice: "Rapunzel, Rapunzel — let down your hair!" The golden braid tumbled down, and up he climbed.\n\nRapunzel had never seen a young man before. They were shy at first, but soon became dear friends.',
        backgroundColor: Color(0xFFF5F0FF),
      ),
      StoryPage(
        emoji: '😡✂️',
        text:
            'The witch discovered their friendship and flew into a rage! She cut off Rapunzel\'s braid and banished her to a distant desert. Then she waited for the Prince.\n\nWhen he climbed up, the witch let the braid drop. He fell from the tower into thorns below, and lost his sight.',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '💧👁️',
        text:
            'Blind and heartbroken, the Prince wandered for years. One day he heard a familiar voice singing. It was Rapunzel!\n\nShe ran to him and wept tears of joy that fell onto his eyes. When she wiped them away, his sight was RESTORED. Love had healed him completely.',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '🌟🏰',
        text:
            'Rapunzel and the Prince returned to his kingdom together. She finally saw the world she had only dreamed of from her tower window — and found it even more wonderful than she had imagined.\n\n🌟 THE END 🌟\n\n💡 Moral: Hope and love can set you free!',
        backgroundColor: Color(0xFFFFF9F0),
      ),
    ],
  ),

  Story(
    id: 'beauty_beast',
    title: 'Beauty and the Beast',
    description: 'A kind girl looks past a frightening appearance and discovers a gentle heart within.',
    category: StoryCategory.fairyTale,
    ageRange: '6–10 yrs',
    readingTimeMinutes: 8,
    isPremium: true,
    starsReward: 5,
    themeColor: const Color(0xFFF9C74F),
    coverEmoji: '🌹',
    moral: 'True beauty is found inside — in kindness and love.',
    pages: const [
      StoryPage(
        emoji: '👧📚',
        text:
            'In a small town lived a kind and bookish girl named Belle. She loved reading more than anything in the world. Her father, a clever inventor, was her very best friend.\n\nOne winter, her father got lost in a snowstorm and took shelter in a mysterious, enchanted castle.',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '🐾😨',
        text:
            'The castle belonged to a terrifying Beast — a creature as large as a bear, with tusks and claws, who had once been a selfish prince. A sorceress had cursed him until someone could love him truly.\n\nThe Beast imprisoned Belle\'s father for trespassing.',
        backgroundColor: Color(0xFFF3F0FF),
      ),
      StoryPage(
        emoji: '💛🔒',
        text:
            'When Belle found out, she bravely offered herself in her father\'s place. The Beast accepted and her father was set free. Belle was frightened at first, but determined to be strong and to find goodness in this strange new world.',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '📚🕯️',
        text:
            'The enchanted castle was full of wonders — furniture that talked, candles that danced, and a library bigger than any she had ever dreamed of! The Beast gave it all to her. He was gruff at first, but Belle saw glimpses of kindness beneath his frightening form.',
        backgroundColor: Color(0xFFEEF6FF),
      ),
      StoryPage(
        emoji: '🍽️🎶',
        text:
            'Every evening they had dinner together and talked for hours. Belle realized the Beast was thoughtful and gentle underneath his terrifying appearance. She began to look forward to their conversations.\n\nAnd the Beast — who had never known real kindness — began to change.',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '💔🏃',
        text:
            'When Belle\'s magic mirror showed her father was ill, the Beast let her go home — even knowing she might never return. "Go," he said quietly. "I want you to be happy."\n\nHis selfless love was the first act of true kindness he had ever shown.',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '💛⚡',
        text:
            'Belle rushed back when she heard the Beast was dying of a broken heart. She knelt beside him and said, "I love you." Those three words broke the sorceress\'s curse in an instant!\n\nA brilliant golden light filled the castle — and the Beast was transformed into a handsome young prince!',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '💑🌹',
        text:
            'The whole enchanted castle came to life as its curse lifted. Belle and the Prince stood together, laughing and marveling at the miracle that love had brought.\n\n🌟 THE END 🌟\n\n💡 Moral: True beauty lives inside every heart — look for kindness, not appearance!',
        backgroundColor: Color(0xFFFFF9F0),
      ),
    ],
  ),

  Story(
    id: 'aladdin',
    title: 'Aladdin',
    description: 'A clever street boy discovers a magic lamp and learns that true wishes come from the heart.',
    category: StoryCategory.adventure,
    ageRange: '5–10 yrs',
    readingTimeMinutes: 8,
    isPremium: true,
    starsReward: 5,
    themeColor: const Color(0xFF8338EC),
    coverEmoji: '🪔',
    moral: 'Honesty and courage are worth more than any magic.',
    pages: const [
      StoryPage(
        emoji: '👦🌆',
        text:
            'In the dazzling city of Agrabah, a quick-witted street boy named Aladdin lived by his wits. He had no home or family, but he had a good heart, a clever mind, and his loyal monkey companion Abu.\n\nEvery day, Aladdin dreamed of a better life.',
        backgroundColor: Color(0xFFF5F0FF),
      ),
      StoryPage(
        emoji: '🧙‍♂️🕳️',
        text:
            'One day, a mysterious sorcerer gave Aladdin a mission: enter a magic cave and retrieve an old oil lamp. Aladdin ventured inside and found dazzling treasures — but he grabbed only the lamp as instructed.\n\nWhen he tried to leave, the sorcerer betrayed him and sealed the cave!',
        backgroundColor: Color(0xFFF3F0FF),
      ),
      StoryPage(
        emoji: '🪔✨',
        text:
            'Trapped in the dark, Aladdin accidentally rubbed the old lamp. With a thunderous BOOM, an enormous, shimmering blue Genie appeared!\n\n"GREETINGS, Master! I am the Genie of the Lamp! You have THREE wishes. Choose wisely!"',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '🏰👑',
        text:
            '"I wish to be free from this cave!" Aladdin cried. WHOOSH — he was out instantly! Then Aladdin used another wish to disguise himself as a prince to meet Princess Jasmine, who was tired of suitors interested only in her royal title.',
        backgroundColor: Color(0xFFEEF6FF),
      ),
      StoryPage(
        emoji: '🌙🦅',
        text:
            'Riding a magnificent magic carpet through the starry night sky, Aladdin showed Princess Jasmine the whole world. She laughed freely for the first time, and both their hearts soared.\n\nBut Aladdin was afraid — if she knew he was just a street boy, would she still care for him?',
        backgroundColor: Color(0xFFF5F0FF),
      ),
      StoryPage(
        emoji: '😈🪔',
        text:
            'The evil sorcerer stole the lamp and used it to take control of the kingdom! "Genie, make me the most powerful ruler alive!" Aladdin had to act fast — without the lamp and with only one wish remaining.',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '💡🎯',
        text:
            'Clever Aladdin tricked the sorcerer into overreaching his own wish — and used his final wish to free the Genie from the lamp forever! The sorcerer\'s power was broken.\n\nAladdin then told Jasmine the truth about who he really was.',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '💞🌟',
        text:
            '"I don\'t want a prince," smiled Jasmine. "I want YOU — the real you." The Sultan, seeing Aladdin\'s courage and honest heart, welcomed him with open arms.\n\n🌟 THE END 🌟\n\n💡 Moral: An honest heart and brave spirit are worth more than any wish!',
        backgroundColor: Color(0xFFFFF9F0),
      ),
    ],
  ),

  Story(
    id: 'little_mermaid',
    title: 'The Little Mermaid',
    description: 'A mermaid princess dreams of the world above the waves and discovers the meaning of true love.',
    category: StoryCategory.fairyTale,
    ageRange: '5–10 yrs',
    readingTimeMinutes: 7,
    isPremium: true,
    starsReward: 5,
    themeColor: const Color(0xFF06D6A0),
    coverEmoji: '🧜',
    moral: 'Love means wishing happiness for others, even at a cost.',
    pages: const [
      StoryPage(
        emoji: '🧜🌊',
        text:
            'Deep beneath the sparkling sea lived a curious little mermaid princess named Marina. She had a shimmering blue tail and the most beautiful singing voice in the ocean.\n\nBut more than anything, Marina was fascinated by the world above the waves — the world of humans.',
        backgroundColor: Color(0xFFEEFFFD),
      ),
      StoryPage(
        emoji: '⚓🚢',
        text:
            'On her fifteenth birthday, Marina swam to the surface for the first time. She watched a beautiful ship sailing through the night, lit up with lights and music. Then a storm struck! A handsome young prince fell overboard.\n\nMarina dived down and saved his life.',
        backgroundColor: Color(0xFFE8F4FF),
      ),
      StoryPage(
        emoji: '💙🏖️',
        text:
            'She carried the unconscious prince to shore and sang softly to him until he was safe. When he opened his eyes, Marina was gone — afraid and shy. But her heart was captured completely.\n\nShe returned to the sea, but could think of nothing but the prince.',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '🐙😈',
        text:
            'Desperate, Marina visited the sea witch, Ursula. "I can give you legs," she hissed, "in exchange for your beautiful voice!" She warned that if the prince married another, Marina would dissolve into sea foam.\n\nMarina agreed. Her voice was taken, and she was given legs.',
        backgroundColor: Color(0xFFF3F0FF),
      ),
      StoryPage(
        emoji: '🚶‍♀️🌸',
        text:
            'Marina walked on land — painfully, but with wonder at every step. The Prince found her on the beach and brought her to the palace. Unable to speak, she communicated only through her beautiful eyes and graceful dancing.\n\nThe Prince grew very fond of her.',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '💔👰',
        text:
            'But the Prince believed another girl had saved him that night, and married her. Marina\'s heart broke. As dawn approached, she faced dissolution into sea foam.\n\nBut Marina\'s sisters and the love of her family transformed her into a spirit of the air — free to do good forever.',
        backgroundColor: Color(0xFFEEFFFD),
      ),
      StoryPage(
        emoji: '🌅💫',
        text:
            'Marina rose into the golden morning sky, light as a breath of wind, tears turning to shimmering droplets of dew. She had lost her love, but gained something greater — a soul, courage, and the freedom of a spirit who chose love over bitterness.\n\n🌟 THE END 🌟\n\n💡 Moral: True love means wanting the best for others!',
        backgroundColor: Color(0xFFFFF9F0),
      ),
    ],
  ),

  Story(
    id: 'hansel_gretel',
    title: 'Hansel and Gretel',
    description: 'Two brave children outsmart a cunning witch deep in an enchanted forest.',
    category: StoryCategory.adventure,
    ageRange: '5–10 yrs',
    readingTimeMinutes: 7,
    isPremium: true,
    starsReward: 5,
    themeColor: const Color(0xFFFB5607),
    coverEmoji: '🍬',
    moral: 'Courage and quick thinking can get you out of any trouble.',
    pages: const [
      StoryPage(
        emoji: '👫🌲',
        text:
            'Hansel and Gretel lived with their father and wicked stepmother near a dark forest. Times were so hard that there was barely any food. While the children slept, their stepmother convinced their father to abandon them in the forest.',
        backgroundColor: Color(0xFFFFF3EE),
      ),
      StoryPage(
        emoji: '🪨✨',
        text:
            'Sharp Hansel had heard the plan! He secretly filled his pockets with white pebbles. The next morning, as they walked into the forest, he dropped them one by one to mark the trail home.\n\nThat night, he and Gretel followed the moonlit pebbles safely back.',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '🍞🐦',
        text:
            'The stepmother tried again, locking the door so Hansel couldn\'t get pebbles. This time he left a trail of bread crumbs. But hungry forest birds ate every single one.\n\nThe children were well and truly lost. They walked deeper and deeper into the dark, unfamiliar forest.',
        backgroundColor: Color(0xFFF3F0FF),
      ),
      StoryPage(
        emoji: '🍭🏠',
        text:
            'Then they spotted something incredible — a cottage built entirely of gingerbread, candy, and chocolate! Starving, they began nibbling at the walls.\n\n"Nibble, nibble, like a mouse — who is eating at my house?" called a sweet voice. An old woman appeared at the door with a warm smile.',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '🧙‍♀️🔒',
        text:
            'The old woman was a WITCH! She locked Hansel in a cage to fatten him up for eating and made Gretel her servant. Every day the witch inspected Hansel\'s finger to see if he was plump enough — but clever Hansel always held out a chicken bone instead!',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '🔥💡',
        text:
            'One day the witch ran out of patience and ordered Gretel to check if the oven was hot. Brave Gretel pretended not to understand. "Show me how!" she said.\n\nAs the witch leaned into the oven to demonstrate — SHOVE! Gretel pushed her in and slammed the door!',
        backgroundColor: Color(0xFFFFF3EE),
      ),
      StoryPage(
        emoji: '💎🏃',
        text:
            'Gretel freed Hansel and together they grabbed the witch\'s treasure — jewels and gold that had been stolen from the forest animals. A kind white duck carried them across a wide river, and they followed the forest path home.',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '🏠👨‍👧‍👦',
        text:
            'Their father wept with joy when he saw them — the wicked stepmother had gone! The jewels meant their family would never be hungry again. From that day on, they lived together in warmth and happiness.\n\n🌟 THE END 🌟\n\n💡 Moral: Courage and quick thinking can overcome any danger!',
        backgroundColor: Color(0xFFFFF9F0),
      ),
    ],
  ),

  Story(
    id: 'thumbelina',
    title: 'Thumbelina',
    description: 'A tiny girl smaller than a thumb goes on a big adventure to find where she truly belongs.',
    category: StoryCategory.fairyTale,
    ageRange: '4–9 yrs',
    readingTimeMinutes: 7,
    isPremium: true,
    starsReward: 5,
    themeColor: const Color(0xFFFF9EF2),
    coverEmoji: '🌸',
    moral: 'You will always find where you truly belong.',
    pages: const [
      StoryPage(
        emoji: '🌷🌱',
        text:
            'A kind woman who longed for a child was given a magical barleycorn by a fairy. She planted it, and it bloomed into a tulip. When the petals opened — inside sat a tiny, perfect little girl no bigger than a thumb!\n\nThe woman named her Thumbelina and loved her dearly.',
        backgroundColor: Color(0xFFFFF0FD),
      ),
      StoryPage(
        emoji: '🐸😱',
        text:
            'One night, a large bumpy toad crept in and took sleeping Thumbelina away — she wanted her as a bride for her son! Thumbelina woke on a lily pad in the middle of a stream, crying and terrified.\n\nKind fish took pity and nibbled through the lily pad\'s stem to set her free.',
        backgroundColor: Color(0xFFF3F0FF),
      ),
      StoryPage(
        emoji: '🦋🌻',
        text:
            'Thumbelina drifted down the stream and spent the summer living in the meadow — sleeping in a flower, eating honey, and singing to the birds. She befriended a pretty butterfly who helped her float from flower to flower.\n\nShe was small, but she was free and happy.',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '🐭🏠',
        text:
            'But winter came and Thumbelina shivered in the cold. A kind field mouse took her in and offered warm shelter through winter. But the mouse\'s neighbor — a wealthy old mole — wanted to marry Thumbelina, even though she found the underground dark and gloomy.',
        backgroundColor: Color(0xFFE8F4FF),
      ),
      StoryPage(
        emoji: '🐦❤️',
        text:
            'Deep in the mole\'s tunnel, Thumbelina found a swallow who seemed to be dead. She secretly cared for him all winter, keeping him warm with leaves and singing to him.\n\nAnd slowly — miraculously — the swallow recovered! He was alive!',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '🌍🕊️',
        text:
            'When spring came, the grateful swallow offered to carry Thumbelina away to avoid her unhappy marriage to the mole. She climbed onto his back and they soared up into the blue sky together, away from the cold dark tunnel.',
        backgroundColor: Color(0xFFFFF0FD),
      ),
      StoryPage(
        emoji: '🌸🤴',
        text:
            'The swallow carried her to a land of warmth and flowers, where tiny flower fairies lived. Their handsome prince looked at Thumbelina with wonder. He had been searching for her kind forever. He placed a crown of flowers on her head and asked her to be his queen.\n\nAt last, Thumbelina was exactly where she belonged — surrounded by love and her own kind.\n\n🌟 THE END 🌟\n\n💡 Moral: You will always find where you truly belong!',
        backgroundColor: Color(0xFFFFF9F0),
      ),
    ],
  ),

  Story(
    id: 'puss_in_boots',
    title: 'Puss in Boots',
    description: 'A clever cat uses his wits and boots to make his poor master\'s fortune.',
    category: StoryCategory.adventure,
    ageRange: '5–9 yrs',
    readingTimeMinutes: 6,
    isPremium: true,
    starsReward: 4,
    themeColor: const Color(0xFFF77F00),
    coverEmoji: '🐱',
    moral: 'Cleverness and loyalty can change your fortune.',
    pages: const [
      StoryPage(
        emoji: '😿👢',
        text:
            'When an old miller died, his three sons received his estate. The eldest got the mill, the middle son got the donkey — and poor youngest son Jack got nothing but the family\'s old CAT.\n\n"What use is a cat?" he sighed. But this was no ordinary cat.',
        backgroundColor: Color(0xFFFFF3EE),
      ),
      StoryPage(
        emoji: '🐱👢',
        text:
            '"Give me a pair of boots and a bag," said the cat in a surprisingly clear voice, "and I will make your fortune!" Jack was astonished — but he had nothing to lose. He found the boots and bag, and Puss put them on with a dignified air.',
        backgroundColor: Color(0xFFFFF9F0),
      ),
      StoryPage(
        emoji: '🐇👑',
        text:
            'Puss in Boots went to the forest, set a trap, and caught a fine rabbit. He marched to the royal palace and presented it to the King with a bow.\n\n"A gift from my master, the Marquis of Carabas!" he announced grandly. He said this every time he brought game to the palace.',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '🚗💦',
        text:
            'One day, Puss heard the King would drive past the river. He told Jack to swim in the river, then hid his clothes! When the royal carriage passed, Puss cried, "Help! The Marquis of Carabas is drowning!"\n\nThe King stopped and gave Jack fine new clothes from the carriage.',
        backgroundColor: Color(0xFFE8F4FF),
      ),
      StoryPage(
        emoji: '🏰🌾',
        text:
            'Puss ran ahead and told all the farmers along the road: "Tell the King these fields belong to the Marquis of Carabas — or an ogre will punish you!"\n\nFrightened, the farmers all agreed. When the King drove past, everyone declared the beautiful land belonged to Jack!',
        backgroundColor: Color(0xFFF0FFF4),
      ),
      StoryPage(
        emoji: '🦁🐱',
        text:
            'The biggest challenge was the ogre\'s castle ahead. Puss walked straight in and announced, "I\'ve heard you can transform into any animal! Can you REALLY become a lion?" The ogre roared and turned into a giant lion. Puss pretended to be terrified but secretly smiled.',
        backgroundColor: Color(0xFFFFF0F0),
      ),
      StoryPage(
        emoji: '🐭😸',
        text:
            '"Very impressive," said Puss. "But surely you CANNOT become something tiny — like a mouse?" The vain ogre immediately shrank into a tiny mouse.\n\nPOUNCE! Puss caught it in a flash. No more ogre! The castle belonged to his master.',
        backgroundColor: Color(0xFFFFFBEA),
      ),
      StoryPage(
        emoji: '👑🎉',
        text:
            'The King was delighted with the "Marquis of Carabas" and his magnificent estate. He offered Jack his daughter\'s hand in marriage. Jack and the Princess were married, and Puss in Boots became the most celebrated cat in the kingdom — never hunting mice again, except for fun!\n\n🌟 THE END 🌟\n\n💡 Moral: Cleverness and loyalty can change everything!',
        backgroundColor: Color(0xFFFFF9F0),
      ),
    ],
  ),
];
