# Gamification Reference

Game mechanics, reward systems, and engagement techniques for math learning.

## Points System

### Base Points
```javascript
const POINTS = {
  // Correctness
  CORRECT_FIRST_TRY: 10,
  CORRECT_SECOND_TRY: 7,
  CORRECT_THIRD_TRY: 5,
  CORRECT_WITH_HINT: 3,

  // Exploration
  TRY_DIFFERENT_VALUE: 2,
  DISCOVER_PATTERN: 15,
  FIND_SPECIAL_CASE: 20,

  // Speed
  SPEED_BONUS_5SEC: 5,
  SPEED_BONUS_10SEC: 3,
  SPEED_BONUS_30SEC: 1,

  // Completion
  COMPLETE_LEVEL: 50,
  COMPLETE_CHALLENGE: 100,
  PERFECT_SCORE: 200,

  // Daily
  DAILY_LOGIN: 10,
  DAILY_CHALLENGE: 25
};
```

### Multipliers
```javascript
function calculateMultiplier(state) {
  let multiplier = 1.0;

  // Streak multiplier
  if (state.streak >= 3) multiplier += 0.5;
  if (state.streak >= 5) multiplier += 0.5;
  if (state.streak >= 10) multiplier += 1.0;

  // Difficulty multiplier
  multiplier *= {
    'easy': 1.0,
    'medium': 1.5,
    'hard': 2.0,
    'expert': 3.0
  }[state.difficulty] || 1.0;

  // Level multiplier
  multiplier *= (1 + (state.level * 0.1));

  return Math.min(multiplier, 5.0); // Cap at 5x
}
```

### Total Score Calculation
```javascript
function awardPoints(basePoints, state) {
  const multiplier = calculateMultiplier(state);
  const speedBonus = calculateSpeedBonus(state.timeSpent);
  const total = Math.floor(basePoints * multiplier) + speedBonus;

  return {
    base: basePoints,
    multiplier: multiplier,
    speedBonus: speedBonus,
    total: total,
    breakdown: `${basePoints} × ${multiplier.toFixed(1)} + ${speedBonus}`
  };
}

function calculateSpeedBonus(seconds) {
  if (seconds < 5) return POINTS.SPEED_BONUS_5SEC;
  if (seconds < 10) return POINTS.SPEED_BONUS_10SEC;
  if (seconds < 30) return POINTS.SPEED_BONUS_30SEC;
  return 0;
}
```

## Achievements

### Achievement Definitions
```javascript
const ACHIEVEMENTS = {
  first_steps: {
    id: 'first_steps',
    name: '🌟 First Steps',
    description: 'Complete your first problem',
    condition: (stats) => stats.problemsCompleted >= 1,
    points: 10,
    rarity: 'common'
  },

  hot_streak: {
    id: 'hot_streak',
    name: '🔥 Hot Streak',
    description: 'Get 5 correct answers in a row',
    condition: (stats) => stats.currentStreak >= 5,
    points: 25,
    rarity: 'uncommon'
  },

  speed_demon: {
    id: 'speed_demon',
    name: '⚡ Speed Demon',
    description: 'Solve 10 problems in under 5 seconds each',
    condition: (stats) => stats.fastSolves >= 10,
    points: 50,
    rarity: 'rare'
  },

  perfectionist: {
    id: 'perfectionist',
    name: '💯 Perfectionist',
    description: 'Get 100% on a challenge',
    condition: (stats) => stats.perfectScores >= 1,
    points: 100,
    rarity: 'epic'
  },

  math_master: {
    id: 'math_master',
    name: '🏆 Math Master',
    description: 'Reach 1000 total points',
    condition: (stats) => stats.totalPoints >= 1000,
    points: 200,
    rarity: 'legendary'
  },

  explorer: {
    id: 'explorer',
    name: '🔍 Explorer',
    description: 'Try 50 different values',
    condition: (stats) => stats.valuesExplored >= 50,
    points: 30,
    rarity: 'uncommon'
  },

  pattern_finder: {
    id: 'pattern_finder',
    name: '🧩 Pattern Finder',
    description: 'Discover 5 mathematical patterns',
    condition: (stats) => stats.patternsFound >= 5,
    points: 75,
    rarity: 'rare'
  },

  night_owl: {
    id: 'night_owl',
    name: '🦉 Night Owl',
    description: 'Practice after midnight',
    condition: (stats) => stats.lateNightSessions >= 1,
    points: 15,
    rarity: 'common'
  },

  early_bird: {
    id: 'early_bird',
    name: '🐦 Early Bird',
    description: 'Practice before 6 AM',
    condition: (stats) => stats.earlyMorningSessions >= 1,
    points: 15,
    rarity: 'common'
  },

  week_warrior: {
    id: 'week_warrior',
    name: '📅 Week Warrior',
    description: 'Practice 7 days in a row',
    condition: (stats) => stats.dailyStreak >= 7,
    points: 150,
    rarity: 'epic'
  }
};
```

### Achievement Checker
```javascript
function checkAchievements(stats, unlockedAchievements) {
  const newAchievements = [];

  for (const [id, achievement] of Object.entries(ACHIEVEMENTS)) {
    if (!unlockedAchievements.includes(id)) {
      if (achievement.condition(stats)) {
        newAchievements.push(achievement);
        unlockedAchievements.push(id);
      }
    }
  }

  return newAchievements;
}
```

### Achievement Display
```javascript
function showAchievementPopup(achievement) {
  const popup = document.createElement('div');
  popup.className = 'achievement-popup';
  popup.style.cssText = `
    position: fixed;
    top: 20px;
    right: 20px;
    background: linear-gradient(135deg, ${getRarityColor(achievement.rarity)});
    color: white;
    padding: 20px 30px;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    animation: slideIn 0.5s ease, pulse 0.5s ease 0.5s;
    z-index: 1000;
    font-weight: bold;
    min-width: 250px;
  `;

  popup.innerHTML = `
    <div style="font-size: 2em; text-align: center;">${achievement.name}</div>
    <div style="margin-top: 10px; text-align: center;">${achievement.description}</div>
    <div style="margin-top: 10px; text-align: center; font-size: 1.5em;">
      +${achievement.points} points
    </div>
  `;

  document.body.appendChild(popup);

  // Play sound
  playAchievementSound(achievement.rarity);

  // Remove after 4 seconds
  setTimeout(() => {
    popup.style.animation = 'slideOut 0.5s ease';
    setTimeout(() => popup.remove(), 500);
  }, 4000);
}

function getRarityColor(rarity) {
  const colors = {
    common: '#909090, #606060',
    uncommon: '#4CAF50, #388E3C',
    rare: '#2196F3, #1565C0',
    epic: '#9C27B0, #6A1B9A',
    legendary: '#FFC107, #F57C00'
  };
  return colors[rarity] || colors.common;
}
```

## Progress Tracking

### Stats Structure
```javascript
const playerStats = {
  // Basic counts
  problemsAttempted: 0,
  problemsCompleted: 0,
  correctAnswers: 0,
  incorrectAnswers: 0,

  // Streaks
  currentStreak: 0,
  longestStreak: 0,
  dailyStreak: 0,

  // Performance
  averageTime: 0,
  fastestTime: Infinity,
  fastSolves: 0,
  perfectScores: 0,

  // Exploration
  valuesExplored: 0,
  patternsFound: 0,

  // Points & Level
  totalPoints: 0,
  level: 1,
  pointsToNextLevel: 100,

  // Time tracking
  totalTimeSpent: 0,
  sessionsCount: 0,
  lastSessionDate: null,
  lateNightSessions: 0,
  earlyMorningSessions: 0,

  // Achievements
  achievementsUnlocked: [],
  achievementPoints: 0
};
```

### Level System
```javascript
function calculateLevel(points) {
  // Level 1: 0-100 points
  // Level 2: 100-300 points
  // Level 3: 300-600 points
  // Formula: points_needed = 100 * level * (level + 1) / 2

  let level = 1;
  let pointsNeeded = 100;
  let totalPointsForLevel = 0;

  while (points >= totalPointsForLevel + pointsNeeded) {
    totalPointsForLevel += pointsNeeded;
    level++;
    pointsNeeded = 100 * level;
  }

  return {
    level: level,
    currentPoints: points,
    pointsInLevel: points - totalPointsForLevel,
    pointsToNextLevel: pointsNeeded,
    progress: (points - totalPointsForLevel) / pointsNeeded
  };
}

function checkLevelUp(oldPoints, newPoints) {
  const oldLevel = calculateLevel(oldPoints).level;
  const newLevel = calculateLevel(newPoints).level;

  if (newLevel > oldLevel) {
    showLevelUpAnimation(newLevel);
    return true;
  }
  return false;
}
```

### Progress Visualization
```javascript
function drawProgressBar(progress, canvas) {
  const ctx = canvas.getContext('2d');
  const width = canvas.width;
  const height = 40;

  // Background
  ctx.fillStyle = '#E0E0E0';
  ctx.fillRect(0, 0, width, height);

  // Progress fill
  const gradient = ctx.createLinearGradient(0, 0, width * progress, 0);
  gradient.addColorStop(0, '#667eea');
  gradient.addColorStop(1, '#764ba2');
  ctx.fillStyle = gradient;
  ctx.fillRect(0, 0, width * progress, height);

  // Border
  ctx.strokeStyle = '#333';
  ctx.lineWidth = 2;
  ctx.strokeRect(0, 0, width, height);

  // Text
  ctx.fillStyle = '#333';
  ctx.font = 'bold 18px Arial';
  ctx.textAlign = 'center';
  ctx.textBaseline = 'middle';
  ctx.fillText(`${Math.floor(progress * 100)}%`, width / 2, height / 2);
}
```

## Reward Animations

### Confetti
```javascript
function createConfetti() {
  const colors = ['#FF6347', '#FFD700', '#4CAF50', '#2196F3', '#9C27B0'];
  const confettiCount = 50;
  const confetti = [];

  for (let i = 0; i < confettiCount; i++) {
    confetti.push({
      x: Math.random() * window.innerWidth,
      y: -20,
      vx: (Math.random() - 0.5) * 5,
      vy: Math.random() * 3 + 2,
      color: colors[Math.floor(Math.random() * colors.length)],
      size: Math.random() * 10 + 5,
      rotation: Math.random() * 360,
      rotationSpeed: (Math.random() - 0.5) * 10
    });
  }

  return confetti;
}

function animateConfetti(confetti, ctx) {
  ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);

  let active = 0;
  confetti.forEach(piece => {
    piece.x += piece.vx;
    piece.y += piece.vy;
    piece.vy += 0.1; // Gravity
    piece.rotation += piece.rotationSpeed;

    if (piece.y < ctx.canvas.height) {
      active++;

      ctx.save();
      ctx.translate(piece.x, piece.y);
      ctx.rotate(piece.rotation * Math.PI / 180);
      ctx.fillStyle = piece.color;
      ctx.fillRect(-piece.size / 2, -piece.size / 2, piece.size, piece.size);
      ctx.restore();
    }
  });

  if (active > 0) {
    requestAnimationFrame(() => animateConfetti(confetti, ctx));
  }
}

function celebrateWithConfetti() {
  const canvas = document.createElement('canvas');
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  canvas.style.cssText = `
    position: fixed;
    top: 0;
    left: 0;
    pointer-events: none;
    z-index: 9999;
  `;
  document.body.appendChild(canvas);

  const ctx = canvas.getContext('2d');
  const confetti = createConfetti();

  animateConfetti(confetti, ctx);

  setTimeout(() => canvas.remove(), 5000);
}
```

### Score Popup
```javascript
function showScorePopup(points, x, y) {
  const popup = document.createElement('div');
  popup.textContent = `+${points}`;
  popup.style.cssText = `
    position: absolute;
    left: ${x}px;
    top: ${y}px;
    color: #FFD700;
    font-size: 2em;
    font-weight: bold;
    animation: floatUp 1s ease-out forwards;
    pointer-events: none;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
    z-index: 1000;
  `;

  document.body.appendChild(popup);
  setTimeout(() => popup.remove(), 1000);
}

// Add CSS animation
const style = document.createElement('style');
style.textContent = `
  @keyframes floatUp {
    from {
      transform: translateY(0) scale(1);
      opacity: 1;
    }
    to {
      transform: translateY(-100px) scale(1.5);
      opacity: 0;
    }
  }
`;
document.head.appendChild(style);
```

## Challenge Modes

### Time Attack
```javascript
class TimeAttackMode {
  constructor(duration = 60) {
    this.duration = duration;
    this.timeRemaining = duration;
    this.problemsSolved = 0;
    this.totalPoints = 0;
    this.isActive = false;
  }

  start() {
    this.isActive = true;
    this.timer = setInterval(() => {
      this.timeRemaining--;
      this.updateDisplay();

      if (this.timeRemaining <= 0) {
        this.end();
      }
    }, 1000);
  }

  solve(points) {
    if (this.isActive) {
      this.problemsSolved++;
      this.totalPoints += points;
      this.generateNewProblem();
    }
  }

  end() {
    this.isActive = false;
    clearInterval(this.timer);
    this.showResults();
  }

  showResults() {
    const results = {
      problemsSolved: this.problemsSolved,
      totalPoints: this.totalPoints,
      averageTime: this.duration / this.problemsSolved,
      rating: this.calculateRating()
    };

    displayResults(results);
  }

  calculateRating() {
    if (this.problemsSolved >= 30) return '🏆 Master';
    if (this.problemsSolved >= 20) return '⭐ Expert';
    if (this.problemsSolved >= 15) return '👍 Good';
    if (this.problemsSolved >= 10) return '✓ Average';
    return '💪 Keep Practicing';
  }
}
```

### Accuracy Challenge
```javascript
class AccuracyChallenge {
  constructor(problemCount = 10) {
    this.problemCount = problemCount;
    this.currentProblem = 0;
    this.correctAnswers = 0;
    this.mistakes = 0;
    this.maxMistakes = 3;
  }

  checkAnswer(userAnswer, correctAnswer) {
    if (userAnswer === correctAnswer) {
      this.correctAnswers++;
      this.currentProblem++;
      celebrateCorrect();

      if (this.currentProblem >= this.problemCount) {
        this.complete();
      } else {
        this.nextProblem();
      }
    } else {
      this.mistakes++;

      if (this.mistakes >= this.maxMistakes) {
        this.fail();
      } else {
        showMistakeWarning(this.maxMistakes - this.mistakes);
      }
    }
  }

  complete() {
    const accuracy = (this.correctAnswers / this.problemCount) * 100;
    showCompletionScreen({
      success: true,
      accuracy: accuracy,
      perfect: accuracy === 100,
      reward: this.calculateReward(accuracy)
    });
  }

  fail() {
    showCompletionScreen({
      success: false,
      correctAnswers: this.correctAnswers,
      totalProblems: this.problemCount
    });
  }

  calculateReward(accuracy) {
    if (accuracy === 100) return 200;
    if (accuracy >= 90) return 150;
    if (accuracy >= 80) return 100;
    if (accuracy >= 70) return 75;
    return 50;
  }
}
```

## Sound Effects

### Audio System
```javascript
const sounds = {
  correct: 'data:audio/wav;base64,...', // Positive chime
  incorrect: 'data:audio/wav;base64,...', // Gentle buzz
  achievement: 'data:audio/wav;base64,...', // Fanfare
  levelUp: 'data:audio/wav;base64,...', // Ascending notes
  click: 'data:audio/wav;base64,...' // Click sound
};

function playSound(soundName) {
  if (!sounds[soundName]) return;

  const audio = new Audio(sounds[soundName]);
  audio.volume = 0.3;
  audio.play().catch(() => {
    // Ignore if user hasn't interacted yet
  });
}
```

## Summary

These gamification patterns provide:
- Comprehensive points and achievement systems
- Progressive difficulty with level systems
- Engaging reward animations
- Multiple challenge modes
- Progress tracking and visualization
- Sound effects and celebrations

Use these to make math learning addictively fun!
