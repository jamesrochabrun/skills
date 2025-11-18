# Calculus Reference

Advanced calculus concepts with interactive visualizations.

## Derivatives

### Derivative Calculator
```javascript
// Numerical derivative using limit definition
function numericalDerivative(f, x, h = 0.0001) {
  return (f(x + h) - f(x - h)) / (2 * h);
}

// Common derivatives
const derivatives = {
  power: (n) => (x) => n * Math.pow(x, n - 1),
  exponential: (a) => (x) => a * Math.pow(Math.E, a * x),
  logarithmic: (x) => 1 / x,
  sine: (x) => Math.cos(x),
  cosine: (x) => -Math.sin(x),
  tangent: (x) => 1 / Math.pow(Math.cos(x), 2)
};
```

### Tangent Line Visualizer
```javascript
function drawTangentLine(f, x0, canvas) {
  const ctx = canvas.getContext('2d');
  const width = canvas.width;
  const height = canvas.height;

  // Calculate derivative at x0
  const slope = numericalDerivative(f, x0);
  const y0 = f(x0);

  // Draw function
  ctx.strokeStyle = '#667eea';
  ctx.lineWidth = 3;
  ctx.beginPath();

  for (let x = -5; x <= 5; x += 0.1) {
    const y = f(x);
    const px = (x + 5) * (width / 10);
    const py = height - ((y + 5) * (height / 10));

    if (x === -5) ctx.moveTo(px, py);
    else ctx.lineTo(px, py);
  }
  ctx.stroke();

  // Draw tangent line
  ctx.strokeStyle = '#FF6347';
  ctx.lineWidth = 2;
  ctx.beginPath();

  for (let x = -5; x <= 5; x += 0.1) {
    const y = y0 + slope * (x - x0); // Point-slope form
    const px = (x + 5) * (width / 10);
    const py = height - ((y + 5) * (height / 10));

    if (x === -5) ctx.moveTo(px, py);
    else ctx.lineTo(px, py);
  }
  ctx.stroke();

  // Mark point of tangency
  const px0 = (x0 + 5) * (width / 10);
  const py0 = height - ((y0 + 5) * (height / 10));

  ctx.fillStyle = '#FFD700';
  ctx.beginPath();
  ctx.arc(px0, py0, 8, 0, Math.PI * 2);
  ctx.fill();

  // Display slope
  ctx.fillStyle = '#333';
  ctx.font = 'bold 16px Arial';
  ctx.fillText(`Slope = ${slope.toFixed(3)}`, 20, 30);
  ctx.fillText(`f'(${x0.toFixed(2)}) = ${slope.toFixed(3)}`, 20, 50);

  return { slope, y0, x0 };
}
```

### Secant Line Animation
```javascript
function animateSecantToTangent(f, x0, canvas) {
  const ctx = canvas.getContext('2d');
  let h = 2; // Start with h = 2

  function animate() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    // Draw function
    drawFunction(f, canvas);

    // Calculate secant slope
    const y0 = f(x0);
    const y1 = f(x0 + h);
    const slope = (y1 - y0) / h;

    // Draw secant line
    drawSecantLine(x0, y0, x0 + h, y1, canvas);

    // Display values
    ctx.fillStyle = '#333';
    ctx.font = 'bold 16px Arial';
    ctx.fillText(`h = ${h.toFixed(4)}`, 20, 30);
    ctx.fillText(`Secant slope = ${slope.toFixed(4)}`, 20, 50);

    if (h > 0.0001) {
      h *= 0.95; // Gradually decrease h
      setTimeout(animate, 50);
    } else {
      ctx.fillText('→ Tangent line!', 20, 70);
      const derivative = numericalDerivative(f, x0);
      ctx.fillText(`Derivative = ${derivative.toFixed(4)}`, 20, 90);
    }
  }

  animate();
}
```

### Rate of Change Explorer
```javascript
function exploreRateOfChange(scenario, canvas) {
  // Scenarios: distance-time → velocity, velocity-time → acceleration, etc.
  const scenarios = {
    position: {
      f: (t) => 5 * t * t, // Position function
      derivative: 'Velocity',
      units: 'm/s',
      explanation: 'How fast position changes = velocity'
    },
    velocity: {
      f: (t) => 10 * t, // Velocity function
      derivative: 'Acceleration',
      units: 'm/s²',
      explanation: 'How fast velocity changes = acceleration'
    },
    population: {
      f: (t) => 1000 * Math.exp(0.1 * t), // Exponential growth
      derivative: 'Growth Rate',
      units: 'people/year',
      explanation: 'How fast population changes = growth rate'
    }
  };

  const s = scenarios[scenario];
  const ctx = canvas.getContext('2d');

  // Draw both function and derivative
  drawTwoGraphs(s.f, (x) => numericalDerivative(s.f, x), canvas);

  return s;
}
```

## Integrals

### Riemann Sum Visualizer
```javascript
function drawRiemannSum(f, a, b, n, method, canvas) {
  const ctx = canvas.getContext('2d');
  const width = canvas.width;
  const height = canvas.height;
  const dx = (b - a) / n;

  let sum = 0;

  // Draw function
  ctx.strokeStyle = '#667eea';
  ctx.lineWidth = 3;
  ctx.beginPath();

  for (let x = a; x <= b; x += 0.01) {
    const y = f(x);
    const px = ((x - a) / (b - a)) * width;
    const py = height - (y / 10) * height;

    if (x === a) ctx.moveTo(px, py);
    else ctx.lineTo(px, py);
  }
  ctx.stroke();

  // Draw rectangles
  for (let i = 0; i < n; i++) {
    const x = a + i * dx;
    let sampleX;

    switch(method) {
      case 'left':
        sampleX = x;
        break;
      case 'right':
        sampleX = x + dx;
        break;
      case 'midpoint':
        sampleX = x + dx / 2;
        break;
      case 'trapezoid':
        // Will handle separately
        break;
    }

    if (method !== 'trapezoid') {
      const height_rect = f(sampleX);
      sum += height_rect * dx;

      // Draw rectangle
      const px = ((x - a) / (b - a)) * width;
      const pw = (dx / (b - a)) * width;
      const ph = (height_rect / 10) * height;

      ctx.fillStyle = 'rgba(102, 126, 234, 0.3)';
      ctx.fillRect(px, height - ph, pw, ph);
      ctx.strokeStyle = '#667eea';
      ctx.strokeRect(px, height - ph, pw, ph);
    }
  }

  // Display sum
  ctx.fillStyle = '#333';
  ctx.font = 'bold 18px Arial';
  ctx.fillText(`Rectangles: ${n}`, 20, 30);
  ctx.fillText(`Approximate Area: ${sum.toFixed(4)}`, 20, 55);

  return sum;
}

function animateRiemannIncrease(f, a, b, canvas) {
  let n = 1;

  function animate() {
    const sum = drawRiemannSum(f, a, b, n, 'midpoint', canvas);

    if (n < 100) {
      n++;
      setTimeout(animate, 100);
    } else {
      // Show exact integral
      const exact = exactIntegral(f, a, b);
      const ctx = canvas.getContext('2d');
      ctx.fillStyle = '#FF6347';
      ctx.font = 'bold 18px Arial';
      ctx.fillText(`Exact Area: ${exact.toFixed(4)}`, 20, 80);
    }
  }

  animate();
}
```

### Area Under Curve
```javascript
function calculateDefiniteIntegral(f, a, b, method = 'simpson') {
  const n = 1000; // Number of subdivisions
  const h = (b - a) / n;
  let sum = 0;

  switch(method) {
    case 'simpson':
      // Simpson's Rule (most accurate)
      sum = f(a) + f(b);
      for (let i = 1; i < n; i++) {
        const x = a + i * h;
        sum += (i % 2 === 0 ? 2 : 4) * f(x);
      }
      sum *= h / 3;
      break;

    case 'trapezoidal':
      sum = (f(a) + f(b)) / 2;
      for (let i = 1; i < n; i++) {
        sum += f(a + i * h);
      }
      sum *= h;
      break;

    case 'midpoint':
      for (let i = 0; i < n; i++) {
        sum += f(a + (i + 0.5) * h);
      }
      sum *= h;
      break;
  }

  return sum;
}
```

### Accumulation Function
```javascript
function drawAccumulationFunction(f, a, canvas) {
  // Draw A(x) = ∫[a to x] f(t) dt
  const ctx = canvas.getContext('2d');
  const width = canvas.width;
  const height = canvas.height;

  // Original function f
  ctx.strokeStyle = '#667eea';
  ctx.lineWidth = 2;
  ctx.beginPath();

  for (let x = -5; x <= 5; x += 0.1) {
    const y = f(x);
    const px = (x + 5) * (width / 10);
    const py = height / 2 - y * 20;

    if (x === -5) ctx.moveTo(px, py);
    else ctx.lineTo(px, py);
  }
  ctx.stroke();

  // Accumulation function A(x)
  ctx.strokeStyle = '#FF6347';
  ctx.lineWidth = 3;
  ctx.beginPath();

  for (let x = -5; x <= 5; x += 0.1) {
    const y = calculateDefiniteIntegral(f, a, x);
    const px = (x + 5) * (width / 10);
    const py = height / 2 - y * 20;

    if (x === -5) ctx.moveTo(px, py);
    else ctx.lineTo(px, py);
  }
  ctx.stroke();

  // Labels
  ctx.fillStyle = '#333';
  ctx.font = '16px Arial';
  ctx.fillText('f(x) - Original function', 20, 30);
  ctx.fillStyle = '#FF6347';
  ctx.fillText('A(x) = ∫f(t)dt - Accumulation', 20, 55);
}
```

## Limits

### Limit Visualizer
```javascript
function visualizeLimit(f, a, canvas) {
  const ctx = canvas.getContext('2d');
  const width = canvas.width;
  const height = canvas.height;

  // Draw function
  ctx.strokeStyle = '#667eea';
  ctx.lineWidth = 3;
  ctx.beginPath();

  let leftLimit = null;
  let rightLimit = null;

  for (let x = -5; x <= 5; x += 0.01) {
    if (Math.abs(x - a) > 0.001) { // Skip the point
      const y = f(x);
      if (isFinite(y)) {
        const px = (x + 5) * (width / 10);
        const py = height / 2 - y * 20;

        if (x === -5) ctx.moveTo(px, py);
        else ctx.lineTo(px, py);

        // Track limits
        if (x < a && x > a - 0.1) leftLimit = y;
        if (x > a && x < a + 0.1) rightLimit = y;
      }
    }
  }
  ctx.stroke();

  // Mark point of interest
  const px = (a + 5) * (width / 10);
  const py_left = height / 2 - leftLimit * 20;
  const py_right = height / 2 - rightLimit * 20;

  // Open circles for limit points
  ctx.strokeStyle = '#FF6347';
  ctx.lineWidth = 3;
  ctx.beginPath();
  ctx.arc(px, py_left, 6, 0, Math.PI * 2);
  ctx.stroke();

  // Display limit values
  ctx.fillStyle = '#333';
  ctx.font = 'bold 16px Arial';
  ctx.fillText(`lim (x→${a}⁻) = ${leftLimit?.toFixed(3)}`, 20, 30);
  ctx.fillText(`lim (x→${a}⁺) = ${rightLimit?.toFixed(3)}`, 20, 55);

  const limitExists = Math.abs(leftLimit - rightLimit) < 0.01;
  if (limitExists) {
    ctx.fillStyle = '#4CAF50';
    ctx.fillText(`Limit exists: ${leftLimit.toFixed(3)}`, 20, 80);
  } else {
    ctx.fillStyle = '#FF6347';
    ctx.fillText('Limit does not exist', 20, 80);
  }

  return { leftLimit, rightLimit, limitExists };
}
```

### Interactive Epsilon-Delta
```javascript
function visualizeEpsilonDelta(f, a, L, epsilon, canvas) {
  const ctx = canvas.getContext('2d');

  // Draw function
  drawFunction(f, canvas);

  // Draw epsilon band
  const py_upper = height / 2 - (L + epsilon) * 20;
  const py_lower = height / 2 - (L - epsilon) * 20;

  ctx.fillStyle = 'rgba(255, 99, 71, 0.2)';
  ctx.fillRect(0, py_upper, width, py_lower - py_upper);

  // Find delta
  let delta = 0.1;
  for (let d = 0.01; d < 5; d += 0.01) {
    const y_left = f(a - d);
    const y_right = f(a + d);

    if (Math.abs(y_left - L) < epsilon && Math.abs(y_right - L) < epsilon) {
      delta = d;
    } else {
      break;
    }
  }

  // Draw delta interval
  const px_left = (a - delta + 5) * (width / 10);
  const px_right = (a + delta + 5) * (width / 10);

  ctx.fillStyle = 'rgba(102, 126, 234, 0.2)';
  ctx.fillRect(px_left, 0, px_right - px_left, height);

  // Labels
  ctx.fillStyle = '#333';
  ctx.font = 'bold 16px Arial';
  ctx.fillText(`ε = ${epsilon.toFixed(3)}`, 20, 30);
  ctx.fillText(`δ = ${delta.toFixed(3)}`, 20, 55);
  ctx.fillText(`For |x - ${a}| < δ, |f(x) - ${L}| < ε`, 20, 80);

  return delta;
}
```

## Optimization

### Critical Points Finder
```javascript
function findCriticalPoints(f, a, b) {
  const points = [];
  const step = (b - a) / 1000;

  for (let x = a; x <= b; x += step) {
    const derivative = numericalDerivative(f, x);

    // Check if derivative is close to zero
    if (Math.abs(derivative) < 0.01) {
      const secondDerivative = numericalDerivative(
        (t) => numericalDerivative(f, t),
        x
      );

      points.push({
        x: x,
        y: f(x),
        type: secondDerivative < 0 ? 'local maximum' :
              secondDerivative > 0 ? 'local minimum' :
              'inflection point',
        derivative: derivative,
        secondDerivative: secondDerivative
      });
    }
  }

  return points;
}

function visualizeOptimization(f, a, b, canvas) {
  const ctx = canvas.getContext('2d');

  // Draw function
  drawFunction(f, canvas);

  // Find and mark critical points
  const criticalPoints = findCriticalPoints(f, a, b);

  criticalPoints.forEach(point => {
    const px = (point.x + 5) * (width / 10);
    const py = height / 2 - point.y * 20;

    // Different colors for different types
    ctx.fillStyle = point.type.includes('maximum') ? '#4CAF50' :
                    point.type.includes('minimum') ? '#FF6347' :
                    '#FFD700';

    ctx.beginPath();
    ctx.arc(px, py, 8, 0, Math.PI * 2);
    ctx.fill();

    // Label
    ctx.fillStyle = '#333';
    ctx.font = '12px Arial';
    ctx.fillText(`${point.type}`, px + 10, py - 10);
    ctx.fillText(`(${point.x.toFixed(2)}, ${point.y.toFixed(2)})`,
                 px + 10, py + 5);
  });

  return criticalPoints;
}
```

## Related Rates

### Related Rates Visualizer
```javascript
function visualizeRelatedRates(scenario, rate, time, canvas) {
  const scenarios = {
    ladder: {
      // Ladder sliding down wall
      length: 10, // Ladder length
      rate: rate, // dx/dt (horizontal speed)
      draw: function(t) {
        const x = rate * t;
        const y = Math.sqrt(this.length * this.length - x * x);
        const dy_dt = -(x * rate) / y; // dy/dt calculated

        drawLadder(x, y, canvas);
        return { x, y, dx_dt: rate, dy_dt };
      }
    },
    balloon: {
      // Expanding balloon
      rate: rate, // dr/dt (radius growth rate)
      draw: function(t) {
        const r = 1 + rate * t;
        const V = (4/3) * Math.PI * r * r * r;
        const dV_dt = 4 * Math.PI * r * r * rate; // dV/dt

        drawBalloon(r, canvas);
        return { r, V, dr_dt: rate, dV_dt };
      }
    }
  };

  return scenarios[scenario].draw(time);
}
```

## Summary

Calculus patterns provide:
- Visual derivative calculations with tangent lines
- Riemann sum animations showing integral approximation
- Limit visualization with epsilon-delta
- Critical point finding for optimization
- Related rates scenarios with animations

These tools make abstract calculus concepts concrete and interactive!
