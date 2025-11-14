# Phonics Reference

Systematic phonics instruction patterns and interactive activities.

## Phonemic Awareness (Pre-Reading)

### Sound Recognition
```javascript
const letterSounds = {
  // Consonants
  'B': 'buh', 'C': 'kuh', 'D': 'duh', 'F': 'fuh', 'G': 'guh',
  'H': 'huh', 'J': 'juh', 'K': 'kuh', 'L': 'luh', 'M': 'muh',
  'N': 'nuh', 'P': 'puh', 'Q': 'kwuh', 'R': 'ruh', 'S': 'sss',
  'T': 'tuh', 'V': 'vuh', 'W': 'wuh', 'X': 'ks', 'Y': 'yuh', 'Z': 'zzz',

  // Vowels (short sounds)
  'A': 'ah (like apple)', 'E': 'eh (like egg)',
  'I': 'ih (like igloo)', 'O': 'ah (like octopus)',
  'U': 'uh (like umbrella)'
};
```

### Rhyming Words
```javascript
const rhymePatterns = {
  'at': {
    words: ['cat', 'bat', 'rat', 'hat', 'mat', 'sat', 'fat', 'pat'],
    emoji: '🐱',
    color: '#FF6B9D'
  },
  'an': {
    words: ['can', 'man', 'pan', 'ran', 'van', 'fan', 'tan', 'ban'],
    emoji: '👨',
    color: '#4ECDC4'
  },
  'ig': {
    words: ['big', 'dig', 'fig', 'pig', 'wig', 'jig'],
    emoji: '🐷',
    color: '#FFE66D'
  },
  'op': {
    words: ['hop', 'mop', 'pop', 'top', 'stop', 'shop', 'drop'],
    emoji: '🛑',
    color: '#A8E6CF'
  },
  'ug': {
    words: ['bug', 'hug', 'mug', 'rug', 'tug', 'jug', 'dug'],
    emoji: '🐛',
    color: '#FF8B94'
  }
};

function createRhymeGame(pattern) {
  const { words, emoji, color } = rhymePatterns[pattern];

  return {
    pattern: pattern,
    words: words,
    display: words.map(w => `${emoji} ${w}`),
    checkRhyme: (word) => word.endsWith(pattern)
  };
}
```

## CVC Words (Consonant-Vowel-Consonant)

### Short Vowel Sounds
```javascript
const cvcWords = {
  'a': [
    'cat', 'bat', 'rat', 'hat', 'mat', 'sat', 'pat', 'fat',
    'can', 'man', 'pan', 'ran', 'van', 'fan', 'tan', 'ban',
    'bag', 'rag', 'tag', 'wag', 'sag', 'lag',
    'cap', 'map', 'tap', 'nap', 'gap', 'lap', 'rap',
    'dad', 'mad', 'sad', 'bad', 'had', 'pad'
  ],

  'e': [
    'bed', 'red', 'led', 'fed', 'wed',
    'hen', 'pen', 'ten', 'den', 'men',
    'pet', 'net', 'set', 'wet', 'get', 'let', 'met', 'vet',
    'leg', 'peg', 'beg'
  ],

  'i': [
    'big', 'dig', 'fig', 'pig', 'wig', 'jig',
    'bin', 'fin', 'pin', 'tin', 'win', 'din',
    'bit', 'fit', 'hit', 'kit', 'pit', 'sit', 'lit',
    'dip', 'hip', 'lip', 'rip', 'sip', 'tip', 'zip'
  ],

  'o': [
    'dog', 'fog', 'log', 'hog', 'jog',
    'dot', 'hot', 'lot', 'not', 'pot', 'cot', 'got',
    'hop', 'mop', 'pop', 'top', 'stop',
    'box', 'fox', 'ox'
  ],

  'u': [
    'bug', 'hug', 'mug', 'rug', 'tug', 'jug', 'dug',
    'bun', 'fun', 'run', 'sun', 'gun',
    'bus', 'pus', 'us',
    'but', 'cut', 'hut', 'nut', 'put'
  ]
};

function generateCVCPractice(vowel, count = 5) {
  const words = cvcWords[vowel];
  const selected = shuffle(words).slice(0, count);

  return selected.map(word => ({
    word: word,
    letters: word.split(''),
    vowel: vowel,
    consonants: word.split('').filter(l => l !== vowel),
    image: getWordImage(word)
  }));
}
```

### Word Building Activity
```javascript
function createWordBuilder(targetWord) {
  const letters = targetWord.split('');
  const allLetters = 'abcdefghijklmnopqrstuvwxyz'.split('');

  // Create letter bank with correct letters plus distractors
  const distractors = shuffle(allLetters.filter(l => !letters.includes(l))).slice(0, 3);
  const letterBank = shuffle([...letters, ...distractors]);

  return {
    target: targetWord,
    letters: letterBank,
    positions: Array(letters.length).fill(''),

    checkWord: function(builtWord) {
      return builtWord === targetWord;
    },

    givHint: function() {
      const firstLetter = letters[0];
      return `The word starts with "${firstLetter}"`;
    }
  };
}
```

## Consonant Blends

### Beginning Blends (2-letter)
```javascript
const beginningBlends = {
  'bl': ['blue', 'black', 'block', 'blend', 'bless', 'bleed'],
  'cl': ['clap', 'clam', 'class', 'climb', 'clock', 'close'],
  'fl': ['flag', 'flap', 'flat', 'flip', 'flock', 'flow'],
  'gl': ['glad', 'glass', 'glow', 'glue', 'globe'],
  'pl': ['plan', 'plant', 'play', 'please', 'plug', 'plum'],
  'sl': ['slam', 'slap', 'slip', 'slow', 'slug'],

  'br': ['brain', 'branch', 'brave', 'bread', 'brick', 'bring'],
  'cr': ['crab', 'crack', 'crash', 'crib', 'crop', 'cross'],
  'dr': ['drag', 'drain', 'draw', 'dream', 'dress', 'drill'],
  'fr': ['frame', 'fresh', 'friend', 'frog', 'front', 'fruit'],
  'gr': ['grab', 'grade', 'grain', 'grass', 'green', 'grow'],
  'pr': ['pray', 'press', 'pretty', 'price', 'print', 'prize'],
  'tr': ['track', 'train', 'trash', 'tree', 'trick', 'truck'],

  'sc': ['scale', 'scare', 'school', 'score', 'scout'],
  'sk': ['skate', 'sketch', 'ski', 'skill', 'skip', 'sky'],
  'sm': ['small', 'smart', 'smell', 'smile', 'smoke'],
  'sn': ['snack', 'snail', 'snake', 'snap', 'snow'],
  'sp': ['space', 'spark', 'speak', 'spell', 'spend', 'spin'],
  'st': ['stack', 'stamp', 'stand', 'star', 'start', 'stop'],
  'sw': ['swam', 'swap', 'sweep', 'sweet', 'swim', 'swing']
};
```

### Ending Blends
```javascript
const endingBlends = {
  'nd': ['and', 'band', 'hand', 'land', 'sand', 'stand', 'wind'],
  'ng': ['bang', 'king', 'long', 'ring', 'sing', 'song', 'wing'],
  'nk': ['bank', 'drink', 'pink', 'sink', 'tank', 'think', 'wink'],
  'nt': ['ant', 'bent', 'went', 'hunt', 'plant', 'sent', 'want'],
  'mp': ['camp', 'jump', 'lamp', 'pump', 'stamp'],
  'sk': ['ask', 'desk', 'mask', 'risk', 'task'],
  'st': ['best', 'fast', 'just', 'last', 'must', 'rest', 'test']
};
```

### Blend Practice Game
```javascript
function createBlendGame(blendType, blend) {
  const words = beginningBlends[blend] || endingBlends[blend];

  return {
    blend: blend,
    words: words,
    sound: `"${blend}"`,

    displayWord: function(word) {
      const parts = word.split(blend);
      return {
        before: parts[0],
        blend: blend,
        after: parts[1] || parts[0],
        highlight: blend
      };
    },

    createChallenge: function() {
      const correctWord = words[Math.floor(Math.random() * words.length)];
      const otherBlends = Object.keys(beginningBlends).filter(b => b !== blend);
      const wrongBlend = otherBlends[Math.floor(Math.random() * otherBlends.length)];
      const wrongWord = beginningBlends[wrongBlend][0];

      return {
        question: `Which word has the "${blend}" sound?`,
        options: shuffle([correctWord, wrongWord]),
        answer: correctWord
      };
    }
  };
}
```

## Digraphs

### Consonant Digraphs
```javascript
const digraphs = {
  'ch': {
    sound: 'ch (as in cheese)',
    words: ['chain', 'chair', 'chalk', 'chap', 'chat', 'check', 'cheese',
            'chess', 'chest', 'chick', 'child', 'chill', 'chip', 'chop'],
    emoji: '🧀'
  },

  'sh': {
    sound: 'sh (as in ship)',
    words: ['shade', 'shake', 'shame', 'shape', 'share', 'shark', 'sharp',
            'sheep', 'shelf', 'shell', 'shine', 'ship', 'shirt', 'shop'],
    emoji: '🚢'
  },

  'th': {
    sound: 'th (as in think)',
    words: ['thank', 'that', 'them', 'then', 'there', 'these', 'thick',
            'thin', 'thing', 'think', 'third', 'this', 'thorn', 'three'],
    emoji: '🤔'
  },

  'wh': {
    sound: 'wh (as in whale)',
    words: ['whale', 'what', 'wheat', 'wheel', 'when', 'where',
            'which', 'while', 'whip', 'white', 'why'],
    emoji: '🐋'
  },

  'ph': {
    sound: 'f (as in phone)',
    words: ['phone', 'photo', 'phrase', 'physical'],
    emoji: '📞'
  }
};
```

### Vowel Digraphs
```javascript
const vowelDigraphs = {
  'ai': {
    sound: 'long a (as in rain)',
    words: ['brain', 'chain', 'gain', 'mail', 'main', 'nail', 'pain',
            'rail', 'rain', 'sail', 'tail', 'train', 'wait'],
    emoji: '🌧️'
  },

  'ay': {
    sound: 'long a (as in play)',
    words: ['day', 'hay', 'jay', 'lay', 'may', 'pay', 'play',
            'ray', 'say', 'stay', 'tray', 'way'],
    emoji: '🎮'
  },

  'ea': {
    sound: 'long e (as in eat)',
    words: ['beach', 'bean', 'clean', 'dream', 'eat', 'leaf', 'mean',
            'meat', 'peas', 'read', 'seal', 'steam', 'teach', 'team'],
    emoji: '🍃'
  },

  'ee': {
    sound: 'long e (as in tree)',
    words: ['bee', 'feed', 'feel', 'free', 'green', 'knee', 'need',
            'seed', 'see', 'sleep', 'street', 'tree', 'three', 'wheel'],
    emoji: '🌳'
  },

  'oa': {
    sound: 'long o (as in boat)',
    words: ['boat', 'coat', 'float', 'goat', 'load', 'road',
            'soap', 'soak', 'toad', 'toast'],
    emoji: '🚤'
  },

  'ow': {
    sound: 'long o (as in snow)',
    words: ['blow', 'bow', 'flow', 'glow', 'grow', 'know',
            'low', 'mow', 'row', 'show', 'slow', 'snow'],
    emoji: '❄️'
  },

  'oo': {
    sound: 'oo (as in moon)',
    words: ['boom', 'boo', 'cool', 'food', 'moon', 'noon',
            'pool', 'room', 'soon', 'spoon', 'zoo'],
    emoji: '🌙'
  }
};
```

## Silent Letters

### Silent E (Magic E)
```javascript
const magicE = {
  'a_e': {
    pattern: 'a + consonant + e',
    sound: 'long a',
    pairs: [
      { short: 'cap', long: 'cape' },
      { short: 'hat', long: 'hate' },
      { short: 'mad', long: 'made' },
      { short: 'tap', long: 'tape' },
      { short: 'can', long: 'cane' },
      { short: 'pan', long: 'pane' },
      { short: 'plan', long: 'plane' }
    ]
  },

  'i_e': {
    pattern: 'i + consonant + e',
    sound: 'long i',
    pairs: [
      { short: 'bit', long: 'bite' },
      { short: 'kit', long: 'kite' },
      { short: 'pin', long: 'pine' },
      { short: 'rip', long: 'ripe' },
      { short: 'dim', long: 'dime' },
      { short: 'slid', long: 'slide' }
    ]
  },

  'o_e': {
    pattern: 'o + consonant + e',
    sound: 'long o',
    pairs: [
      { short: 'hop', long: 'hope' },
      { short: 'not', long: 'note' },
      { short: 'rob', long: 'robe' },
      { short: 'rod', long: 'rode' },
      { short: 'con', long: 'cone' }
    ]
  },

  'u_e': {
    pattern: 'u + consonant + e',
    sound: 'long u',
    pairs: [
      { short: 'cub', long: 'cube' },
      { short: 'cut', long: 'cute' },
      { short: 'tub', long: 'tube' },
      { short: 'us', long: 'use' }
    ]
  }
};

function createMagicEGame(vowel) {
  const pattern = `${vowel}_e`;
  const pairs = magicE[pattern].pairs;

  return {
    pattern: pattern,
    explanation: `Adding 'e' makes the ${vowel} say its name!`,

    showTransformation: function(pair) {
      return {
        before: `${pair.short} (short ${vowel})`,
        after: `${pair.long} (long ${vowel})`,
        animation: `${pair.short} → ${pair.long}`
      };
    },

    quiz: function() {
      const pair = pairs[Math.floor(Math.random() * pairs.length)];
      return {
        question: `Add magic 'e' to "${pair.short}"`,
        answer: pair.long
      };
    }
  };
}
```

### Other Silent Letters
```javascript
const silentLetters = {
  'silent k': {
    words: ['knee', 'knife', 'knight', 'knit', 'knock', 'know'],
    rule: 'K is silent before N'
  },
  'silent w': {
    words: ['wrap', 'wrist', 'write', 'wrong', 'wreck'],
    rule: 'W is silent before R'
  },
  'silent b': {
    words: ['bomb', 'climb', 'comb', 'crumb', 'lamb', 'thumb'],
    rule: 'B is silent after M'
  },
  'silent h': {
    words: ['honest', 'honor', 'hour'],
    rule: 'H is silent in some words'
  },
  'silent gh': {
    words: ['high', 'light', 'night', 'right', 'fight', 'sight'],
    rule: 'GH is silent in -ight words'
  }
};
```

## Interactive Phonics Activities

### Sound Sorting Game
```javascript
function createSoundSortingGame(targetSound) {
  const withSound = getWordsWithSound(targetSound);
  const withoutSound = getRandomWords(5);

  return {
    targetSound: targetSound,
    allWords: shuffle([...withSound, ...withoutSound]),

    checkWord: function(word) {
      return word.includes(targetSound);
    },

    feedback: function(word, userChoice) {
      const correct = this.checkWord(word);
      if (userChoice === correct) {
        return { correct: true, message: `✓ Yes! "${word}" has "${targetSound}"` };
      } else {
        return { correct: false, message: `Try again! Listen for "${targetSound}"` };
      }
    }
  };
}
```

### Word Family Builder
```javascript
function buildWordFamily(ending) {
  const consonants = 'bcdfghjklmnpqrstvwxyz'.split('');

  const words = consonants
    .map(c => c + ending)
    .filter(word => isRealWord(word));

  return {
    family: `-${ending}`,
    words: words,
    pattern: `_${ending}`,

    display: function() {
      return words.map(word => ({
        word: word,
        highlight: ending,
        display: `${word[0]} + ${ending} = ${word}`
      }));
    },

    createPractice: function() {
      const target = words[Math.floor(Math.random() * words.length)];
      const missing = target[0];

      return {
        question: `_${ending} = ${target}`,
        answer: missing,
        word: target
      };
    }
  };
}
```

## Pronunciation Guides

### Visual Phonics Symbols
```javascript
const phonicsSymbols = {
  shortA: { symbol: 'ă', example: 'apple', mouth: '😮' },
  longA: { symbol: 'ā', example: 'ape', mouth: '😁' },
  shortE: { symbol: 'ĕ', example: 'egg', mouth: '😐' },
  longE: { symbol: 'ē', example: 'eat', mouth: '😊' },
  shortI: { symbol: 'ĭ', example: 'igloo', mouth: '🙂' },
  longI: { symbol: 'ī', example: 'ice', mouth: '😲' },
  shortO: { symbol: 'ŏ', example: 'octopus', mouth: '😯' },
  longO: { symbol: 'ō', example: 'open', mouth: '😮' },
  shortU: { symbol: 'ŭ', example: 'umbrella', mouth: '😐' },
  longU: { symbol: 'ū', example: 'use', mouth: '😗' }
};
```

## Summary

Phonics patterns provide:
- Systematic sound-letter correspondence
- Progressive skill building
- Interactive practice activities
- Visual and auditory learning
- Game-based engagement
- Clear pronunciation guides

Use these patterns to create effective phonics playgrounds!
