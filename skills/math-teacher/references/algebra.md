# Algebra Reference

Algebraic concepts and interactive visualizations for middle school to high school.

## Variables & Expressions

### Visual Variables
```javascript
// Mystery box representation
function drawVariable(name, value, canvas) {
  const ctx = canvas.getContext('2d');

  // Draw box
  ctx.fillStyle = '#667eea';
  ctx.fillRect(50, 50, 100, 100);
  ctx.strokeStyle = '#333';
  ctx.lineWidth = 3;
  ctx.strokeRect(50, 50, 100, 100);

  // Variable name
  ctx.fillStyle = 'white';
  ctx.font = 'bold 40px Arial';
  ctx.textAlign = 'center';
  ctx.fillText(name, 100, 110);

  // Value (revealed)
  if (value !== undefined) {
    ctx.fillStyle = '#FFD700';
    ctx.font = 'bold 30px Arial';
    ctx.fillText(`= ${value}`, 100, 170);
  } else {
    ctx.fillStyle = '#FFF';
    ctx.font = '20px Arial';
    ctx.fillText('?', 100, 170);
  }
}
```

### Expression Evaluator
```javascript
function evaluateExpression(expr, variables) {
  // Replace variables with values
  let result = expr;
  for (const [name, value] of Object.entries(variables)) {
    result = result.replace(new RegExp(name, 'g'), value);
  }

  try {
    return {
      expression: expr,
      substituted: result,
      result: eval(result),
      steps: showSteps(expr, variables)
    };
  } catch (e) {
    return { error: 'Invalid expression' };
  }
}

function showSteps(expr, variables) {
  const steps = [];
  steps.push(`Original: ${expr}`);

  let current = expr;
  for (const [name, value] of Object.entries(variables)) {
    current = current.replace(new RegExp(name, 'g'), value);
    steps.push(`Substitute ${name} = ${value}: ${current}`);
  }

  steps.push(`Evaluate: ${eval(current)}`);
  return steps;
}
```

## Linear Equations

### Equation Solver
```javascript
// Solve ax + b = c for x
function solveLinear(a, b, c) {
  const x = (c - b) / a;

  return {
    equation: `${a}x + ${b} = ${c}`,
    steps: [
      `${a}x + ${b} = ${c}`,
      `${a}x = ${c - b}`,
      `x = ${(c - b)}/${a}`,
      `x = ${x}`
    ],
    solution: x,
    verification: `${a}(${x}) + ${b} = ${a * x + b} ✓`
  };
}
```

### Balance Scale Visualization
```javascript
function drawBalanceScale(left, right, canvas) {
  const ctx = canvas.getContext('2d');
  const centerX = canvas.width / 2;
  const centerY = canvas.height / 2;

  // Calculate balance
  const diff = left - right;
  const angle = Math.atan(diff / 10);

  // Draw fulcrum
  ctx.fillStyle = '#333';
  ctx.beginPath();
  ctx.moveTo(centerX - 20, centerY + 50);
  ctx.lineTo(centerX, centerY);
  ctx.lineTo(centerX + 20, centerY + 50);
  ctx.closePath();
  ctx.fill();

  // Draw beam
  ctx.save();
  ctx.translate(centerX, centerY);
  ctx.rotate(angle);

  ctx.fillStyle = '#8B4513';
  ctx.fillRect(-150, -10, 300, 20);

  // Left side
  ctx.fillStyle = '#667eea';
  ctx.fillRect(-140, -60, 80, 80);
  ctx.fillStyle = 'white';
  ctx.font = 'bold 24px Arial';
  ctx.textAlign = 'center';
  ctx.fillText(left, -100, -10);

  // Right side
  ctx.fillStyle = '#FF6347';
  ctx.fillRect(60, -60, 80, 80);
  ctx.fillStyle = 'white';
  ctx.fillText(right, 100, -10);

  ctx.restore();

  // Status
  ctx.fillStyle = '#333';
  ctx.font = '20px Arial';
  ctx.textAlign = 'center';
  const status = Math.abs(diff) < 0.1 ? '⚖️ Balanced!' :
                 diff > 0 ? '⬅️ Left heavier' : '➡️ Right heavier';
  ctx.fillText(status, centerX, centerY + 100);
}
```

## Quadratic Equations

### Quadratic Formula
```javascript
function solveQuadratic(a, b, c) {
  const discriminant = b * b - 4 * a * c;

  const result = {
    equation: `${a}x² + ${b}x + ${c} = 0`,
    discriminant: discriminant,
    a, b, c
  };

  if (discriminant > 0) {
    const x1 = (-b + Math.sqrt(discriminant)) / (2 * a);
    const x2 = (-b - Math.sqrt(discriminant)) / (2 * a);
    result.solutions = [x1, x2];
    result.type = 'Two real solutions';
    result.message = '🎉 Two x-intercepts!';
  } else if (discriminant === 0) {
    const x = -b / (2 * a);
    result.solutions = [x];
    result.type = 'One real solution';
    result.message = '🎯 One x-intercept (vertex on x-axis)!';
  } else {
    const realPart = -b / (2 * a);
    const imagPart = Math.sqrt(-discriminant) / (2 * a);
    result.solutions = [
      `${realPart} + ${imagPart}i`,
      `${realPart} - ${imagPart}i`
    ];
    result.type = 'Two complex solutions';
    result.message = '👻 No x-intercepts (complex numbers)!';
  }

  return result;
}
```

### Parabola Grapher
```javascript
function drawParabola(a, b, c, canvas) {
  const ctx = canvas.getContext('2d');
  const width = canvas.width;
  const height = canvas.height;

  // Clear canvas
  ctx.clearRect(0, 0, width, height);

  // Draw axes
  drawAxes(ctx, width, height);

  // Calculate vertex
  const vertexX = -b / (2 * a);
  const vertexY = a * vertexX * vertexX + b * vertexX + c;

  // Draw parabola
  ctx.beginPath();
  ctx.strokeStyle = '#667eea';
  ctx.lineWidth = 3;

  for (let x = -10; x <= 10; x += 0.1) {
    const y = a * x * x + b * x + c;
    const px = (x + 10) * (width / 20);
    const py = height - ((y + 10) * (height / 20));

    if (x === -10) ctx.moveTo(px, py);
    else ctx.lineTo(px, py);
  }
  ctx.stroke();

  // Mark vertex
  const vx = (vertexX + 10) * (width / 20);
  const vy = height - ((vertexY + 10) * (height / 20));

  ctx.fillStyle = '#FF6347';
  ctx.beginPath();
  ctx.arc(vx, vy, 8, 0, Math.PI * 2);
  ctx.fill();

  // Vertex label
  ctx.fillStyle = '#333';
  ctx.font = '14px Arial';
  ctx.fillText(`Vertex: (${vertexX.toFixed(2)}, ${vertexY.toFixed(2)})`,
               vx + 10, vy - 10);

  // Draw axis of symmetry
  ctx.strokeStyle = '#FFD700';
  ctx.setLineDash([5, 5]);
  ctx.beginPath();
  ctx.moveTo(vx, 0);
  ctx.lineTo(vx, height);
  ctx.stroke();
  ctx.setLineDash([]);

  return { vertexX, vertexY };
}

function drawAxes(ctx, width, height) {
  ctx.strokeStyle = '#CCC';
  ctx.lineWidth = 1;

  // X-axis
  ctx.beginPath();
  ctx.moveTo(0, height / 2);
  ctx.lineTo(width, height / 2);
  ctx.stroke();

  // Y-axis
  ctx.beginPath();
  ctx.moveTo(width / 2, 0);
  ctx.lineTo(width / 2, height);
  ctx.stroke();

  // Grid
  ctx.strokeStyle = '#F0F0F0';
  for (let i = 0; i < width; i += width / 20) {
    ctx.beginPath();
    ctx.moveTo(i, 0);
    ctx.lineTo(i, height);
    ctx.stroke();
  }
  for (let i = 0; i < height; i += height / 20) {
    ctx.beginPath();
    ctx.moveTo(0, i);
    ctx.lineTo(width, i);
    ctx.stroke();
  }
}
```

## Functions

### Function Visualizer
```javascript
const commonFunctions = {
  linear: (x, m, b) => m * x + b,
  quadratic: (x, a, b, c) => a * x * x + b * x + c,
  cubic: (x, a) => a * x * x * x,
  exponential: (x, a) => Math.pow(a, x),
  logarithmic: (x, a) => Math.log(x) / Math.log(a),
  sine: (x, a) => a * Math.sin(x),
  cosine: (x, a) => a * Math.cos(x),
  absolute: (x) => Math.abs(x),
  squareRoot: (x) => Math.sqrt(x)
};

function plotFunction(fn, xMin, xMax, canvas) {
  const ctx = canvas.getContext('2d');
  const width = canvas.width;
  const height = canvas.height;

  drawAxes(ctx, width, height);

  ctx.beginPath();
  ctx.strokeStyle = '#667eea';
  ctx.lineWidth = 3;

  const step = (xMax - xMin) / width;
  for (let x = xMin; x <= xMax; x += step) {
    try {
      const y = fn(x);
      if (!isNaN(y) && isFinite(y)) {
        const px = ((x - xMin) / (xMax - xMin)) * width;
        const py = height - ((y - (-10)) / 20) * height;

        if (x === xMin) ctx.moveTo(px, py);
        else ctx.lineTo(px, py);
      }
    } catch (e) {
      // Skip invalid points
    }
  }
  ctx.stroke();
}
```

### Domain & Range Finder
```javascript
function analyzeFunctionDomainRange(type, params) {
  const analysis = {
    type: type,
    params: params
  };

  switch(type) {
    case 'linear':
      analysis.domain = '(-∞, ∞)';
      analysis.range = '(-∞, ∞)';
      break;
    case 'quadratic':
      const a = params.a;
      const vertex = -params.b / (2 * a);
      const vertexY = a * vertex * vertex + params.b * vertex + params.c;
      analysis.domain = '(-∞, ∞)';
      analysis.range = a > 0 ? `[${vertexY.toFixed(2)}, ∞)` :
                                `(-∞, ${vertexY.toFixed(2)}]`;
      analysis.vertex = { x: vertex, y: vertexY };
      break;
    case 'squareRoot':
      analysis.domain = '[0, ∞)';
      analysis.range = '[0, ∞)';
      break;
    case 'logarithmic':
      analysis.domain = '(0, ∞)';
      analysis.range = '(-∞, ∞)';
      break;
  }

  return analysis;
}
```

## Systems of Equations

### Graphical Solution
```javascript
function solveSystemGraphically(eq1, eq2, canvas) {
  // eq1 and eq2 are linear equations in form {m: slope, b: intercept}

  const ctx = canvas.getContext('2d');
  const width = canvas.width;
  const height = canvas.height;

  drawAxes(ctx, width, height);

  // Plot first equation
  ctx.strokeStyle = '#667eea';
  ctx.lineWidth = 3;
  ctx.beginPath();
  for (let x = -10; x <= 10; x += 0.1) {
    const y = eq1.m * x + eq1.b;
    const px = (x + 10) * (width / 20);
    const py = height - ((y + 10) * (height / 20));
    if (x === -10) ctx.moveTo(px, py);
    else ctx.lineTo(px, py);
  }
  ctx.stroke();

  // Plot second equation
  ctx.strokeStyle = '#FF6347';
  ctx.beginPath();
  for (let x = -10; x <= 10; x += 0.1) {
    const y = eq2.m * x + eq2.b;
    const px = (x + 10) * (width / 20);
    const py = height - ((y + 10) * (height / 20));
    if (x === -10) ctx.moveTo(px, py);
    else ctx.lineTo(px, py);
  }
  ctx.stroke();

  // Find intersection
  // eq1.m * x + eq1.b = eq2.m * x + eq2.b
  // (eq1.m - eq2.m) * x = eq2.b - eq1.b
  const x = (eq2.b - eq1.b) / (eq1.m - eq2.m);
  const y = eq1.m * x + eq1.b;

  // Mark intersection
  const px = (x + 10) * (width / 20);
  const py = height - ((y + 10) * (height / 20));

  ctx.fillStyle = '#FFD700';
  ctx.beginPath();
  ctx.arc(px, py, 10, 0, Math.PI * 2);
  ctx.fill();

  ctx.fillStyle = '#333';
  ctx.font = 'bold 16px Arial';
  ctx.fillText(`(${x.toFixed(2)}, ${y.toFixed(2)})`, px + 15, py - 15);

  return { x, y };
}
```

## Polynomials

### Polynomial Evaluator
```javascript
function evaluatePolynomial(coefficients, x) {
  // coefficients = [a0, a1, a2, ...] for a0 + a1*x + a2*x^2 + ...
  let result = 0;
  let term = 1;

  const terms = [];
  for (let i = 0; i < coefficients.length; i++) {
    const value = coefficients[i] * term;
    result += value;
    terms.push({
      coefficient: coefficients[i],
      power: i,
      value: value,
      display: i === 0 ? `${coefficients[i]}` :
               i === 1 ? `${coefficients[i]}x` :
               `${coefficients[i]}x^${i}`
    });
    term *= x;
  }

  return {
    x: x,
    result: result,
    terms: terms,
    polynomial: formatPolynomial(coefficients)
  };
}

function formatPolynomial(coefficients) {
  return coefficients.map((c, i) => {
    if (c === 0) return '';
    if (i === 0) return `${c}`;
    if (i === 1) return `${c}x`;
    return `${c}x^${i}`;
  }).filter(t => t).join(' + ');
}
```

## Interactive Elements

### Slider for Coefficients
```javascript
function createCoefficientSliders(equation) {
  const sliders = {};
  const params = ['a', 'b', 'c'];

  params.forEach(param => {
    const slider = document.createElement('input');
    slider.type = 'range';
    slider.min = -10;
    slider.max = 10;
    slider.step = 0.1;
    slider.value = equation[param] || 0;

    slider.addEventListener('input', () => {
      equation[param] = parseFloat(slider.value);
      updateGraph();
      updateEquationDisplay();
    });

    sliders[param] = slider;
  });

  return sliders;
}
```

## Summary

Algebra patterns provide:
- Visual equation solving with balance scales
- Interactive function graphing
- Step-by-step solutions
- Real-time parameter manipulation
- Geometric representations of algebraic concepts

These tools make abstract algebra concrete and interactive!
