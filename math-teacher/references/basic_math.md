# Basic Math Reference

Elementary mathematics concepts for interactive playgrounds.

## Arithmetic Operations

### Addition
```javascript
// Visual addition with counting blocks
function visualAdd(a, b) {
  return {
    result: a + b,
    visualization: `${'🟦'.repeat(a)} + ${'🟨'.repeat(b)} = ${'🟩'.repeat(a + b)}`
  };
}
```

### Multiplication
```javascript
// Array/grid visualization
function visualMultiply(rows, cols) {
  let grid = '';
  for (let i = 0; i < rows; i++) {
    grid += '⬜'.repeat(cols) + '\n';
  }
  return {
    result: rows * cols,
    grid: grid,
    explanation: `${rows} rows × ${cols} columns = ${rows * cols} squares`
  };
}
```

## Fractions

### Visual Representation
```javascript
function drawFraction(numerator, denominator, canvas) {
  const ctx = canvas.getContext('2d');
  const width = canvas.width;
  const height = canvas.height;
  const sliceWidth = width / denominator;

  for (let i = 0; i < denominator; i++) {
    ctx.fillStyle = i < numerator ? '#FF6347' : '#DDD';
    ctx.fillRect(i * sliceWidth, 0, sliceWidth - 2, height);
  }
}
```

### Equivalent Fractions
```javascript
function findEquivalent(numerator, denominator, multiplier) {
  return {
    original: `${numerator}/${denominator}`,
    equivalent: `${numerator * multiplier}/${denominator * multiplier}`,
    explanation: `Multiply both by ${multiplier}`
  };
}

function simplify(numerator, denominator) {
  const gcd = (a, b) => b === 0 ? a : gcd(b, a % b);
  const divisor = gcd(numerator, denominator);
  return {
    original: `${numerator}/${denominator}`,
    simplified: `${numerator / divisor}/${denominator / divisor}`,
    divisor: divisor
  };
}
```

## Geometry

### Area Calculations
```javascript
// Rectangle
function rectangleArea(length, width) {
  return {
    area: length * width,
    perimeter: 2 * (length + width),
    visualization: drawRectangle(length, width)
  };
}

// Circle
function circleArea(radius) {
  return {
    area: Math.PI * radius * radius,
    circumference: 2 * Math.PI * radius,
    diameter: 2 * radius
  };
}

// Triangle
function triangleArea(base, height) {
  return {
    area: 0.5 * base * height,
    explanation: 'Half of base × height'
  };
}
```

### Angle Visualizer
```javascript
function drawAngle(degrees, canvas) {
  const ctx = canvas.getContext('2d');
  const centerX = canvas.width / 2;
  const centerY = canvas.height / 2;
  const radius = 100;

  // Draw angle arc
  ctx.beginPath();
  ctx.arc(centerX, centerY, radius, 0, degrees * Math.PI / 180);
  ctx.lineTo(centerX, centerY);
  ctx.closePath();
  ctx.fillStyle = 'rgba(102, 126, 234, 0.3)';
  ctx.fill();
  ctx.strokeStyle = '#667eea';
  ctx.lineWidth = 3;
  ctx.stroke();

  // Label
  ctx.fillStyle = '#333';
  ctx.font = '20px Arial';
  ctx.fillText(`${degrees}°`, centerX + 50, centerY - 50);
}
```

## Number Patterns

### Sequences
```javascript
// Arithmetic sequence
function arithmeticSequence(start, difference, terms) {
  const sequence = [];
  for (let i = 0; i < terms; i++) {
    sequence.push(start + (i * difference));
  }
  return {
    sequence: sequence,
    rule: `Start at ${start}, add ${difference} each time`,
    next: start + (terms * difference)
  };
}

// Geometric sequence
function geometricSequence(start, ratio, terms) {
  const sequence = [];
  for (let i = 0; i < terms; i++) {
    sequence.push(start * Math.pow(ratio, i));
  }
  return {
    sequence: sequence,
    rule: `Start at ${start}, multiply by ${ratio} each time`,
    next: start * Math.pow(ratio, terms)
  };
}
```

## Time & Money

### Clock
```javascript
function drawClock(hours, minutes) {
  // Draw clock face with hands
  const hourAngle = (hours % 12) * 30 + minutes * 0.5;
  const minuteAngle = minutes * 6;

  return {
    hourAngle: hourAngle,
    minuteAngle: minuteAngle,
    timeString: `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}`
  };
}
```

### Money
```javascript
function calculateChange(paid, cost) {
  const change = paid - cost;
  const bills = {
    '20': Math.floor(change / 20),
    '10': Math.floor((change % 20) / 10),
    '5': Math.floor((change % 10) / 5),
    '1': Math.floor(change % 5)
  };

  return {
    change: change.toFixed(2),
    breakdown: bills,
    visualization: visualizeChange(bills)
  };
}
```

## Interactive Elements

### Number Line
```javascript
function drawNumberLine(min, max, highlight, canvas) {
  const ctx = canvas.getContext('2d');
  const width = canvas.width;
  const height = canvas.height;
  const y = height / 2;

  // Draw line
  ctx.strokeStyle = '#333';
  ctx.lineWidth = 2;
  ctx.beginPath();
  ctx.moveTo(20, y);
  ctx.lineTo(width - 20, y);
  ctx.stroke();

  // Draw numbers
  const range = max - min;
  const step = (width - 40) / range;

  for (let i = min; i <= max; i++) {
    const x = 20 + (i - min) * step;

    // Tick mark
    ctx.beginPath();
    ctx.moveTo(x, y - 10);
    ctx.lineTo(x, y + 10);
    ctx.stroke();

    // Number label
    ctx.fillStyle = i === highlight ? '#FF6347' : '#333';
    ctx.font = i === highlight ? 'bold 20px Arial' : '16px Arial';
    ctx.textAlign = 'center';
    ctx.fillText(i, x, y + 30);

    // Highlight
    if (i === highlight) {
      ctx.beginPath();
      ctx.arc(x, y, 8, 0, Math.PI * 2);
      ctx.fillStyle = '#FF6347';
      ctx.fill();
    }
  }
}
```

### Counting Blocks
```javascript
function drawCountingBlocks(number, canvas) {
  const ctx = canvas.getContext('2d');
  const blockSize = 40;
  const gap = 10;
  const blocksPerRow = 10;

  for (let i = 0; i < number; i++) {
    const row = Math.floor(i / blocksPerRow);
    const col = i % blocksPerRow;
    const x = col * (blockSize + gap);
    const y = row * (blockSize + gap);

    // Draw block
    ctx.fillStyle = '#667eea';
    ctx.fillRect(x, y, blockSize, blockSize);
    ctx.strokeStyle = '#333';
    ctx.strokeRect(x, y, blockSize, blockSize);

    // Number in block
    ctx.fillStyle = 'white';
    ctx.font = 'bold 20px Arial';
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    ctx.fillText(i + 1, x + blockSize / 2, y + blockSize / 2);
  }
}
```

## Word Problems

### Template System
```javascript
const wordProblemTemplates = {
  addition: [
    "🍎 Sarah has {a} apples. Her friend gives her {b} more. How many apples does Sarah have now?",
    "🚗 There are {a} cars in the parking lot. {b} more cars arrive. How many cars are there in total?",
    "⭐ Tom collected {a} stars. He then collected {b} more stars. How many stars does Tom have?"
  ],

  subtraction: [
    "🍪 Mom baked {a} cookies. The family ate {b} cookies. How many cookies are left?",
    "🎈 There were {a} balloons at the party. {b} balloons popped. How many balloons remain?",
    "💰 You have ${a}. You spend ${b}. How much money do you have left?"
  ],

  multiplication: [
    "📦 Each box contains {a} toys. You have {b} boxes. How many toys do you have in total?",
    "🌳 Each tree has {a} apples. There are {b} trees. How many apples are there?",
    "👥 Each team has {a} players. There are {b} teams. How many players in total?"
  ],

  division: [
    "🍕 You have {a} pizza slices to share equally among {b} friends. How many slices does each friend get?",
    "🎁 {a} presents need to be distributed equally to {b} children. How many presents per child?",
    "📚 {a} books are arranged into {b} equal stacks. How many books in each stack?"
  ]
};

function generateWordProblem(type, difficulty) {
  const template = wordProblemTemplates[type][
    Math.floor(Math.random() * wordProblemTemplates[type].length)
  ];

  const range = difficulty === 'easy' ? 10 : difficulty === 'medium' ? 50 : 100;
  const a = Math.floor(Math.random() * range) + 1;
  const b = Math.floor(Math.random() * range) + 1;

  const problem = template.replace('{a}', a).replace('{b}', b);
  const answer = calculateAnswer(type, a, b);

  return { problem, answer, a, b };
}

function calculateAnswer(type, a, b) {
  switch(type) {
    case 'addition': return a + b;
    case 'subtraction': return a - b;
    case 'multiplication': return a * b;
    case 'division': return Math.floor(a / b);
  }
}
```

## Game Mechanics

### Points System
```javascript
const scoring = {
  correct: {
    first_try: 10,
    second_try: 7,
    third_try: 5,
    with_hint: 3
  },
  streak: {
    multiplier: (streak) => Math.min(1 + (streak * 0.1), 3.0)
  },
  speed: {
    bonus: (seconds) => seconds < 5 ? 5 : seconds < 10 ? 3 : 0
  }
};

function calculatePoints(attempt, streak, seconds, usedHint) {
  let basePoints = scoring.correct.first_try;
  if (usedHint) basePoints = scoring.correct.with_hint;
  else if (attempt === 2) basePoints = scoring.correct.second_try;
  else if (attempt >= 3) basePoints = scoring.correct.third_try;

  const streakMultiplier = scoring.streak.multiplier(streak);
  const speedBonus = scoring.speed.bonus(seconds);

  return Math.floor(basePoints * streakMultiplier) + speedBonus;
}
```

## Summary

These basic math patterns provide:
- Visual representations for concrete understanding
- Interactive manipulatives for hands-on learning
- Gamification elements for engagement
- Progressive difficulty scaffolding
- Clear explanations with every calculation

Use these as building blocks for creating engaging math playgrounds!
