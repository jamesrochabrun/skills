# Reading Comprehension Reference

Strategies, question types, and interactive activities for developing reading comprehension.

## Comprehension Strategies

### Before Reading
```javascript
const beforeReadingStrategies = {
  preview: {
    name: 'Preview the Text',
    steps: [
      'Look at title and pictures',
      'Read headings and subheadings',
      'Predict what story is about',
      'Ask: What do I already know about this topic?'
    ],
    prompt: 'What do you think this story will be about?'
  },

  purpose: {
    name: 'Set a Purpose',
    steps: [
      'Why am I reading this?',
      'What do I want to learn?',
      'How will I use this information?'
    ],
    prompt: 'What do you want to find out from this story?'
  },

  vocabulary: {
    name: 'Preview Key Words',
    steps: [
      'Identify unfamiliar words',
      'Look at context',
      'Check pictures for clues',
      'Make predictions about meanings'
    ],
    prompt: 'Are there any new words? What might they mean?'
  }
};
```

### During Reading
```javascript
const duringReadingStrategies = {
  visualize: {
    name: 'Make Mental Pictures',
    prompt: 'What do you see in your mind?',
    activity: 'Draw what you\'re imagining'
  },

  question: {
    name: 'Ask Questions',
    prompts: [
      'What is happening?',
      'Why did that happen?',
      'What will happen next?',
      'How does the character feel?'
    ]
  },

  connect: {
    name: 'Make Connections',
    types: {
      textToSelf: 'Has this happened to you?',
      textToText: 'Does this remind you of another story?',
      textToWorld: 'Where have you seen this in real life?'
    }
  },

  clarify: {
    name: 'Fix Confusions',
    strategies: [
      'Reread the sentence',
      'Read ahead for clues',
      'Look at pictures',
      'Sound out unfamiliar words',
      'Ask for help'
    ]
  },

  predict: {
    name: 'Make Predictions',
    prompt: 'What do you think will happen next?',
    check: 'Was your prediction correct?'
  }
};
```

### After Reading
```javascript
const afterReadingStrategies = {
  summarize: {
    name: 'Retell the Story',
    framework: {
      beginning: 'How did the story start?',
      middle: 'What happened?',
      end: 'How did it end?'
    }
  },

  mainIdea: {
    name: 'Find the Main Idea',
    questions: [
      'What is the story mostly about?',
      'What is the most important part?',
      'What did you learn?'
    ]
  },

  evaluate: {
    name: 'Think About the Story',
    questions: [
      'Did you like it? Why?',
      'What was your favorite part?',
      'Would you recommend this to a friend?',
      'What would you change?'
    ]
  }
};
```

## Question Types

### Literal Questions (Right There)
```javascript
const literalQuestions = {
  who: 'Who is the main character?',
  what: 'What happened in the story?',
  when: 'When did this take place?',
  where: 'Where does the story happen?',
  how: 'How did the character solve the problem?',

  examples: [
    'What color was the cat?',
    'Where did Tom go?',
    'Who helped Sally?',
    'When did they leave?'
  ]
};
```

### Inferential Questions (Think & Search)
```javascript
const inferentialQuestions = {
  why: 'Why did the character do that?',
  cause: 'What caused this to happen?',
  effect: 'What happened because of...?',
  feeling: 'How do you think the character felt?',
  motive: 'Why did the character want...?',

  examples: [
    'Why was the girl sad?',
    'How did the boy feel when...?',
    'What made the dog run away?',
    'Why didn\'t they tell anyone?'
  ]
};
```

### Evaluative Questions (Author & Me)
```javascript
const evaluativeQuestions = {
  opinion: 'What do you think about...?',
  judgment: 'Did the character make a good choice?',
  alternative: 'What would you have done?',
  theme: 'What lesson does this teach?',

  examples: [
    'Was it right for her to...?',
    'What would you do in this situation?',
    'Do you agree with the character?',
    'What is the author trying to tell us?'
  ]
};
```

### Creative Questions (On My Own)
```javascript
const creativeQuestions = {
  extend: 'What might happen next?',
  change: 'How would the story be different if...?',
  relate: 'How is this like your life?',
  imagine: 'What if the character had...?',

  examples: [
    'What would happen if the ending was different?',
    'How would you feel if you were the character?',
    'What other adventures might they have?',
    'If you could change one thing, what would it be?'
  ]
};
```

## Story Elements

### Character Analysis
```javascript
const characterAnalysis = {
  traits: {
    prompt: 'What is the character like?',
    evidence: 'How do you know?',
    categories: ['brave', 'kind', 'funny', 'smart', 'curious', 'helpful']
  },

  feelings: {
    prompt: 'How does the character feel?',
    changes: 'How do their feelings change?',
    emotions: ['happy', 'sad', 'angry', 'scared', 'excited', 'surprised']
  },

  actions: {
    prompt: 'What does the character do?',
    motives: 'Why do they do it?'
  },

  relationships: {
    prompt: 'Who are the other characters?',
    connections: 'How do they interact?'
  }
};
```

### Setting
```javascript
const settingAnalysis = {
  where: {
    prompt: 'Where does the story take place?',
    details: 'Describe the place'
  },

  when: {
    prompt: 'When does the story happen?',
    clues: ['time of day', 'season', 'past/present/future']
  },

  importance: {
    prompt: 'Does the setting matter to the story?',
    question: 'Would the story be different in a different place/time?'
  }
};
```

### Plot Structure
```javascript
const plotStructure = {
  beginning: {
    name: 'Introduction',
    elements: ['characters', 'setting', 'situation'],
    question: 'How does the story start?'
  },

  middle: {
    name: 'Problem/Conflict',
    elements: ['challenge', 'obstacle', 'quest'],
    question: 'What problem do the characters face?'
  },

  climax: {
    name: 'Turning Point',
    elements: ['most exciting part', 'biggest challenge'],
    question: 'What is the most important moment?'
  },

  end: {
    name: 'Resolution',
    elements: ['solution', 'outcome', 'lesson'],
    question: 'How is the problem solved?'
  }
};
```

## Interactive Comprehension Activities

### Story Map
```javascript
function createStoryMap() {
  return {
    title: '',
    characters: {
      main: [],
      supporting: []
    },
    setting: {
      where: '',
      when: ''
    },
    plot: {
      beginning: '',
      problem: '',
      events: [],
      solution: '',
      ending: ''
    },

    display: function() {
      return `
        📖 ${this.title}
        👥 Characters: ${this.characters.main.join(', ')}
        📍 Setting: ${this.setting.where} (${this.setting.when})

        Story:
        Beginning: ${this.plot.beginning}
        Problem: ${this.plot.problem}
        Events: ${this.plot.events.join(' → ')}
        Solution: ${this.plot.solution}
        Ending: ${this.plot.ending}
      `;
    }
  };
}
```

### Question Generator
```javascript
function generateComprehensionQuestions(story, level) {
  const questions = [];

  // Literal questions (ages 5-7)
  if (level <= 2) {
    questions.push({
      type: 'literal',
      question: `Who is the main character in "${story.title}"?`,
      answer: story.characters.main[0],
      difficulty: 'easy'
    });

    questions.push({
      type: 'literal',
      question: `Where does the story take place?`,
      answer: story.setting.where,
      difficulty: 'easy'
    });
  }

  // Inferential questions (ages 7-9)
  if (level >= 2) {
    questions.push({
      type: 'inferential',
      question: `Why do you think the character...?`,
      answer: null, // Open-ended
      difficulty: 'medium'
    });

    questions.push({
      type: 'inferential',
      question: `How did the character feel when...?`,
      answer: null,
      difficulty: 'medium'
    });
  }

  // Evaluative questions (ages 9+)
  if (level >= 3) {
    questions.push({
      type: 'evaluative',
      question: `What would you have done differently?`,
      answer: null,
      difficulty: 'hard'
    });
  }

  return questions;
}
```

### Cloze Reading (Fill in the Blank)
```javascript
function createClozeActivity(text, difficulty = 'medium') {
  const words = text.split(' ');
  const blanks = [];

  // Remove every Nth word based on difficulty
  const interval = difficulty === 'easy' ? 10 : difficulty === 'medium' ? 7 : 5;

  const modified = words.map((word, index) => {
    if (index % interval === 0 && word.length > 3) {
      blanks.push({
        position: index,
        word: word,
        hint: word[0] + '_'.repeat(word.length - 1)
      });
      return '______';
    }
    return word;
  });

  return {
    original: text,
    modified: modified.join(' '),
    blanks: blanks,

    check: function(userAnswers) {
      let correct = 0;
      userAnswers.forEach((answer, i) => {
        if (answer.toLowerCase() === blanks[i].word.toLowerCase()) {
          correct++;
        }
      });
      return {
        correct: correct,
        total: blanks.length,
        percentage: Math.round((correct / blanks.length) * 100)
      };
    },

    getHint: function(blankIndex) {
      return blanks[blankIndex].hint;
    }
  };
}
```

### Sequence Activity
```javascript
function createSequenceActivity(events) {
  const shuffled = shuffle([...events]);

  return {
    events: events,
    scrambled: shuffled,
    userOrder: [],

    check: function() {
      return {
        correct: JSON.stringify(this.userOrder) === JSON.stringify(events),
        correctOrder: events,
        userOrder: this.userOrder
      };
    },

    hint: function() {
      return `The story starts with: "${events[0]}"`;
    }
  };
}
```

### Vocabulary in Context
```javascript
function createVocabularyActivity(text, targetWords) {
  return targetWords.map(word => {
    const sentence = findSentenceWith(text, word);
    const context = getContext(text, word);

    return {
      word: word,
      sentence: sentence,
      beforeContext: context.before,
      afterContext: context.after,

      questions: [
        {
          type: 'multiple-choice',
          question: `What does "${word}" mean in this sentence?`,
          options: generateDefinitionOptions(word),
          answer: getCorrectDefinition(word)
        },
        {
          type: 'context-clue',
          question: 'Which words help you understand the meaning?',
          answer: getContextClues(sentence, word)
        }
      ],

      practice: {
        blank: sentence.replace(word, '______'),
        wordBank: [word, ...generateSimilarWords(word)],
        correctWord: word
      }
    };
  });
}
```

## Comprehension Games

### Story Detective
```javascript
class StoryDetective {
  constructor(story) {
    this.story = story;
    this.clues = [];
    this.questions = [];
    this.score = 0;
  }

  addClue(question, answer, location) {
    this.clues.push({
      question: question,
      answer: answer,
      found: false,
      location: location
    });
  }

  checkClue(clueIndex, userAnswer) {
    const clue = this.clues[clueIndex];

    if (userAnswer.toLowerCase().includes(clue.answer.toLowerCase())) {
      clue.found = true;
      this.score += 10;
      return {
        correct: true,
        message: '🔍 Clue found! +10 points',
        location: clue.location
      };
    }

    return {
      correct: false,
      hint: `Look ${clue.location}`,
      message: 'Keep searching!'
    };
  }

  getProgress() {
    const found = this.clues.filter(c => c.found).length;
    return {
      found: found,
      total: this.clues.length,
      percentage: Math.round((found / this.clues.length) * 100),
      score: this.score
    };
  }
}
```

### Reading Race
```javascript
class ReadingRace {
  constructor(passage, questionsPerCheckpoint = 3) {
    this.passage = passage;
    this.checkpoints = this.createCheckpoints(questionsPerCheckpoint);
    this.currentCheckpoint = 0;
    this.startTime = null;
    this.endTime = null;
  }

  start() {
    this.startTime = Date.now();
  }

  answerQuestion(answer) {
    const checkpoint = this.checkpoints[this.currentCheckpoint];
    const question = checkpoint.questions[checkpoint.currentQuestion];

    const correct = this.checkAnswer(answer, question.answer);

    if (correct) {
      checkpoint.correct++;
      checkpoint.currentQuestion++;

      if (checkpoint.currentQuestion >= checkpoint.questions.length) {
        this.currentCheckpoint++;
        return {
          checkpointComplete: true,
          message: `🏁 Checkpoint ${this.currentCheckpoint} complete!`
        };
      }
    }

    return { correct: correct };
  }

  finish() {
    this.endTime = Date.now();
    const time = (this.endTime - this.startTime) / 1000; // seconds

    return {
      time: time,
      checkpoints: this.checkpoints.length,
      accuracy: this.calculateAccuracy(),
      rating: this.getRating(time, this.calculateAccuracy())
    };
  }
}
```

## Progress Tracking

### Comprehension Skills Tracker
```javascript
class ComprehensionTracker {
  constructor() {
    this.skills = {
      literal: { attempts: 0, correct: 0 },
      inferential: { attempts: 0, correct: 0 },
      evaluative: { attempts: 0, correct: 0 },
      vocabulary: { attempts: 0, correct: 0 },
      sequencing: { attempts: 0, correct: 0 },
      mainIdea: { attempts: 0, correct: 0 },
      causeEffect: { attempts: 0, correct: 0 }
    };
  }

  record(skillType, correct) {
    this.skills[skillType].attempts++;
    if (correct) this.skills[skillType].correct++;
  }

  getSkillLevel(skillType) {
    const skill = this.skills[skillType];
    if (skill.attempts === 0) return 'Not Started';

    const accuracy = skill.correct / skill.attempts;

    if (accuracy >= 0.9) return 'Mastered';
    if (accuracy >= 0.7) return 'Proficient';
    if (accuracy >= 0.5) return 'Developing';
    return 'Needs Practice';
  }

  getReport() {
    return Object.entries(this.skills).map(([name, data]) => ({
      skill: name,
      level: this.getSkillLevel(name),
      accuracy: data.attempts > 0 ? Math.round((data.correct / data.attempts) * 100) : 0,
      attempts: data.attempts
    }));
  }
}
```

## Summary

Reading comprehension tools provide:
- Before, during, and after reading strategies
- Multiple question types (literal, inferential, evaluative, creative)
- Story element analysis (character, setting, plot)
- Interactive activities (story maps, cloze, sequencing)
- Comprehension games
- Progress tracking

Use these patterns to create effective comprehension practice!
