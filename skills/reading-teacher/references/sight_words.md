# Sight Words Reference

Comprehensive sight word lists organized by level (Dolch and Fry lists).

## What Are Sight Words?

Sight words are high-frequency words that appear often in text. Many don't follow regular phonics patterns, so children learn to recognize them instantly "by sight."

**Why They Matter:**
- 50-75% of all text consists of these words
- Essential for reading fluency
- Enable focus on content, not decoding
- Build reading confidence

## Dolch Sight Words

### Pre-Kindergarten (40 words)

```javascript
const dolchPreK = [
  'a', 'and', 'away', 'big', 'blue', 'can', 'come', 'down',
  'find', 'for', 'funny', 'go', 'help', 'here', 'I', 'in',
  'is', 'it', 'jump', 'little', 'look', 'make', 'me', 'my',
  'not', 'one', 'play', 'red', 'run', 'said', 'see', 'the',
  'three', 'to', 'two', 'up', 'we', 'where', 'yellow', 'you'
];

const preKByCategory = {
  colors: ['blue', 'red', 'yellow'],
  numbers: ['one', 'two', 'three'],
  actions: ['come', 'down', 'find', 'go', 'help', 'jump', 'look', 'make', 'play', 'run', 'see'],
  descriptive: ['big', 'funny', 'little'],
  pronouns: ['I', 'it', 'me', 'my', 'we', 'you'],
  prepositions: ['in', 'to', 'up'],
  other: ['a', 'and', 'away', 'can', 'for', 'here', 'is', 'not', 'said', 'the', 'where']
};
```

### Kindergarten (52 words)

```javascript
const dolchKindergarten = [
  'all', 'am', 'are', 'at', 'ate', 'be', 'black', 'brown',
  'but', 'came', 'did', 'do', 'eat', 'four', 'get', 'good',
  'have', 'he', 'into', 'like', 'must', 'new', 'no', 'now',
  'on', 'our', 'out', 'please', 'pretty', 'ran', 'ride', 'saw',
  'say', 'she', 'so', 'soon', 'that', 'there', 'they', 'this',
  'too', 'under', 'want', 'was', 'well', 'went', 'what', 'white',
  'who', 'will', 'with', 'yes'
];
```

### First Grade (41 words)

```javascript
const dolchFirstGrade = [
  'after', 'again', 'an', 'any', 'as', 'ask', 'by', 'could',
  'every', 'fly', 'from', 'give', 'giving', 'had', 'has', 'her',
  'him', 'his', 'how', 'just', 'know', 'let', 'live', 'may',
  'of', 'old', 'once', 'open', 'over', 'put', 'round', 'some',
  'stop', 'take', 'thank', 'them', 'then', 'think', 'walk', 'were',
  'when'
];
```

### Second Grade (46 words)

```javascript
const dolchSecondGrade = [
  'always', 'around', 'because', 'been', 'before', 'best', 'both',
  'buy', 'call', 'cold', 'does', 'don\'t', 'fast', 'first', 'five',
  'found', 'gave', 'goes', 'green', 'its', 'made', 'many', 'off',
  'or', 'pull', 'read', 'right', 'sing', 'sit', 'sleep', 'tell',
  'their', 'these', 'those', 'upon', 'us', 'use', 'very', 'wash',
  'which', 'why', 'wish', 'work', 'would', 'write', 'your'
];
```

### Third Grade (41 words)

```javascript
const dolchThirdGrade = [
  'about', 'better', 'bring', 'carry', 'clean', 'cut', 'done',
  'draw', 'drink', 'eight', 'fall', 'far', 'full', 'got', 'grow',
  'hold', 'hot', 'hurt', 'if', 'keep', 'kind', 'laugh', 'light',
  'long', 'much', 'myself', 'never', 'only', 'own', 'pick', 'seven',
  'shall', 'show', 'six', 'small', 'start', 'ten', 'today', 'together',
  'try', 'warm'
];
```

### Dolch Nouns (95 words)

```javascript
const dolchNouns = [
  'apple', 'baby', 'back', 'ball', 'bear', 'bed', 'bell', 'bird',
  'birthday', 'boat', 'box', 'boy', 'bread', 'brother', 'cake', 'car',
  'cat', 'chair', 'chicken', 'children', 'Christmas', 'coat', 'corn',
  'cow', 'day', 'dog', 'doll', 'door', 'duck', 'egg', 'eye', 'farm',
  'farmer', 'father', 'feet', 'fire', 'fish', 'floor', 'flower', 'game',
  'garden', 'girl', 'goodbye', 'grass', 'ground', 'hand', 'head', 'hill',
  'home', 'horse', 'house', 'kitty', 'leg', 'letter', 'man', 'men',
  'milk', 'money', 'morning', 'mother', 'name', 'nest', 'night', 'paper',
  'party', 'picture', 'pig', 'rabbit', 'rain', 'ring', 'robin', 'santa',
  'school', 'seed', 'sheep', 'shoe', 'sister', 'snow', 'song', 'squirrel',
  'stick', 'street', 'sun', 'table', 'thing', 'time', 'top', 'toy',
  'tree', 'watch', 'water', 'way', 'wind', 'window', 'wood'
];
```

## Fry Sight Words

### First 100 (Most Common)

```javascript
const fryFirst100 = {
  '1-25': [
    'the', 'of', 'and', 'a', 'to', 'in', 'is', 'you', 'that', 'it',
    'he', 'was', 'for', 'on', 'are', 'as', 'with', 'his', 'they', 'I',
    'at', 'be', 'this', 'have', 'from'
  ],

  '26-50': [
    'or', 'one', 'had', 'by', 'words', 'but', 'not', 'what', 'all', 'were',
    'we', 'when', 'your', 'can', 'said', 'there', 'use', 'an', 'each', 'which',
    'she', 'do', 'how', 'their', 'if'
  ],

  '51-75': [
    'will', 'up', 'other', 'about', 'out', 'many', 'then', 'them', 'these', 'so',
    'some', 'her', 'would', 'make', 'like', 'him', 'into', 'time', 'has', 'look',
    'two', 'more', 'write', 'go', 'see'
  ],

  '76-100': [
    'number', 'no', 'way', 'could', 'people', 'my', 'than', 'first', 'water', 'been',
    'called', 'who', 'am', 'its', 'now', 'find', 'long', 'down', 'day', 'did',
    'get', 'come', 'made', 'may', 'part'
  ]
};
```

### Second 100

```javascript
const frySecond100 = {
  '101-125': [
    'over', 'new', 'sound', 'take', 'only', 'little', 'work', 'know', 'place', 'years',
    'live', 'me', 'back', 'give', 'most', 'very', 'after', 'things', 'our', 'just',
    'name', 'good', 'sentence', 'man', 'think'
  ],

  '126-150': [
    'say', 'great', 'where', 'help', 'through', 'much', 'before', 'line', 'right', 'too',
    'means', 'old', 'any', 'same', 'tell', 'boy', 'follow', 'came', 'want', 'show',
    'also', 'around', 'form', 'three', 'small'
  ],

  '151-175': [
    'set', 'put', 'end', 'does', 'another', 'well', 'large', 'must', 'big', 'even',
    'such', 'because', 'turn', 'here', 'why', 'asked', 'went', 'men', 'read', 'need',
    'land', 'different', 'home', 'us', 'move'
  ],

  '176-200': [
    'try', 'kind', 'hand', 'picture', 'again', 'change', 'off', 'play', 'spell', 'air',
    'away', 'animal', 'house', 'point', 'page', 'letter', 'mother', 'answer', 'found', 'study',
    'still', 'learn', 'should', 'America', 'world'
  ]
};
```

## Interactive Practice Activities

### Sight Word Flash Cards
```javascript
function createFlashCards(wordList, timePerCard = 3000) {
  let currentIndex = 0;
  let correct = 0;
  let total = 0;

  return {
    words: shuffle(wordList),
    currentWord: wordList[0],

    next: function() {
      currentIndex = (currentIndex + 1) % this.words.length;
      this.currentWord = this.words[currentIndex];
      return this.currentWord;
    },

    checkAnswer: function(userAnswer) {
      total++;
      const isCorrect = userAnswer.toLowerCase() === this.currentWord.toLowerCase();
      if (isCorrect) correct++;

      return {
        correct: isCorrect,
        word: this.currentWord,
        score: `${correct}/${total}`,
        percentage: Math.round((correct / total) * 100)
      };
    },

    getStats: function() {
      return {
        totalSeen: total,
        totalCorrect: correct,
        accuracy: total > 0 ? Math.round((correct / total) * 100) : 0
      };
    }
  };
}
```

### Word Search Game
```javascript
function createWordSearch(words, size = 10) {
  const grid = Array(size).fill().map(() => Array(size).fill(''));
  const placed = [];

  // Place words in grid
  words.forEach(word => {
    const direction = Math.random() < 0.5 ? 'horizontal' : 'vertical';
    const position = placeWord(grid, word, direction);
    if (position) {
      placed.push({ word, ...position });
    }
  });

  // Fill empty spaces with random letters
  for (let i = 0; i < size; i++) {
    for (let j = 0; j < size; j++) {
      if (!grid[i][j]) {
        grid[i][j] = String.fromCharCode(97 + Math.floor(Math.random() * 26));
      }
    }
  }

  return {
    grid: grid,
    words: words,
    found: [],

    checkWord: function(selectedCells) {
      const word = selectedCells.map(cell => grid[cell.row][cell.col]).join('');
      if (words.includes(word) && !this.found.includes(word)) {
        this.found.push(word);
        return { found: true, word: word };
      }
      return { found: false };
    },

    isComplete: function() {
      return this.found.length === words.length;
    }
  };
}
```

### Sentence Building
```javascript
function createSentenceBuilder(sightWords) {
  const sentenceTemplates = [
    ['I', 'can', 'see', 'the', '{noun}'],
    ['The', '{noun}', 'is', '{color}'],
    ['We', 'like', 'to', '{action}'],
    ['{name}', 'said', '{quote}'],
    ['Look', 'at', 'the', '{adjective}', '{noun}']
  ];

  const fillWords = {
    noun: ['cat', 'dog', 'ball', 'sun', 'tree'],
    color: ['red', 'blue', 'green', 'yellow'],
    action: ['play', 'run', 'jump', 'read'],
    name: ['Tom', 'Sue', 'Mom', 'Dad'],
    quote: ['"hello"', '"stop"', '"help"'],
    adjective: ['big', 'little', 'funny', 'pretty']
  };

  return {
    generate: function() {
      const template = sentenceTemplates[Math.floor(Math.random() * sentenceTemplates.length)];
      const sentence = template.map(word => {
        if (word.startsWith('{')) {
          const type = word.slice(1, -1);
          return fillWords[type][Math.floor(Math.random() * fillWords[type].length)];
        }
        return word;
      });

      return {
        sentence: sentence.join(' '),
        words: sentence,
        sightWords: sentence.filter(w => sightWords.includes(w.toLowerCase()))
      };
    },

    scramble: function() {
      const { sentence, words } = this.generate();
      return {
        correctOrder: words,
        scrambled: shuffle([...words]),
        answer: sentence
      };
    }
  };
}
```

### Memory Match Game
```javascript
function createMemoryMatch(words) {
  // Create pairs: word and image/definition
  const pairs = words.map(word => [
    { type: 'word', content: word, id: `${word}-word` },
    { type: 'image', content: getWordImage(word), id: `${word}-image` }
  ]).flat();

  return {
    cards: shuffle(pairs),
    flipped: [],
    matched: [],

    flip: function(cardId) {
      if (this.flipped.length < 2 && !this.flipped.includes(cardId)) {
        this.flipped.push(cardId);

        if (this.flipped.length === 2) {
          return this.checkMatch();
        }
      }
      return { matched: false };
    },

    checkMatch: function() {
      const [id1, id2] = this.flipped;
      const card1 = this.cards.find(c => c.id === id1);
      const card2 = this.cards.find(c => c.id === id2);

      const word1 = id1.split('-')[0];
      const word2 = id2.split('-')[0];

      if (word1 === word2) {
        this.matched.push(id1, id2);
        this.flipped = [];
        return { matched: true, word: word1 };
      }

      // Reset after delay
      setTimeout(() => { this.flipped = []; }, 1000);
      return { matched: false };
    },

    isComplete: function() {
      return this.matched.length === this.cards.length;
    }
  };
}
```

### Typing Practice
```javascript
function createTypingPractice(words) {
  let currentWordIndex = 0;
  let startTime = null;
  let stats = {
    correct: 0,
    total: 0,
    wpm: 0
  };

  return {
    currentWord: words[0],

    start: function() {
      startTime = Date.now();
    },

    check: function(typed) {
      stats.total++;
      const correct = typed === this.currentWord;

      if (correct) {
        stats.correct++;
        currentWordIndex = (currentWordIndex + 1) % words.length;
        this.currentWord = words[currentWordIndex];
      }

      // Calculate WPM
      const elapsed = (Date.now() - startTime) / 1000 / 60; // minutes
      stats.wpm = Math.round(stats.correct / elapsed);

      return {
        correct: correct,
        accuracy: Math.round((stats.correct / stats.total) * 100),
        wpm: stats.wpm
      };
    },

    getStats: function() {
      return stats;
    }
  };
}
```

## Word List Management

### Adaptive Practice
```javascript
class AdaptiveSightWords {
  constructor(allWords) {
    this.allWords = allWords;
    this.mastered = new Set();
    this.practicing = new Set();
    this.new = new Set(allWords);
  }

  getNextWord() {
    // 70% practicing, 20% new, 10% review mastered
    const rand = Math.random();

    if (rand < 0.7 && this.practicing.size > 0) {
      return this.selectFrom(this.practicing);
    } else if (rand < 0.9 && this.new.size > 0) {
      const word = this.selectFrom(this.new);
      this.new.delete(word);
      this.practicing.add(word);
      return word;
    } else if (this.mastered.size > 0) {
      return this.selectFrom(this.mastered);
    }

    return this.selectFrom(this.allWords);
  }

  recordResult(word, correct) {
    if (correct) {
      // Move to mastered after 3 correct in a row
      if (!this.mastered.has(word)) {
        this.practicing.delete(word);
        this.mastered.add(word);
      }
    } else {
      // Move back to practicing
      this.mastered.delete(word);
      this.practicing.add(word);
    }
  }

  selectFrom(set) {
    const arr = Array.from(set);
    return arr[Math.floor(Math.random() * arr.length)];
  }

  getProgress() {
    return {
      total: this.allWords.length,
      mastered: this.mastered.size,
      practicing: this.practicing.size,
      new: this.new.size,
      percentage: Math.round((this.mastered.size / this.allWords.length) * 100)
    };
  }
}
```

## Visual Design Guidelines

### Display Requirements
```javascript
const displaySettings = {
  fontSize: {
    preK: '48px',
    kindergarten: '36px',
    grade1: '32px',
    grade2: '28px',
    grade3: '24px'
  },

  colors: {
    new: '#FF6B9D',        // Pink - new words
    practicing: '#FFE66D',  // Yellow - practicing
    mastered: '#4ECDC4'     // Teal - mastered
  },

  timing: {
    flashDuration: 3000,    // 3 seconds per word
    typingTimeout: 5000,    // 5 seconds to type
    memoryFlipDelay: 1000   // 1 second before flip back
  }
};
```

## Summary

Sight word lists provide:
- Comprehensive Dolch and Fry word lists
- Grade-level organization
- Multiple practice modalities
- Adaptive learning systems
- Progress tracking
- Game-based activities

Use these lists to create effective sight word practice!
