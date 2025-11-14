#!/bin/bash

# Math Teacher - Interactive Playground Generator
# Creates instant, interactive math learning experiences

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Helper functions
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

prompt_input() {
    local prompt="$1"
    local var_name="$2"
    local required="${3:-false}"

    while true; do
        echo -e "${BLUE}${prompt}${NC}"
        read -r input

        if [ -z "$input" ] && [ "$required" = true ]; then
            print_error "This field is required."
            continue
        fi

        eval "$var_name='$input'"
        break
    done
}

prompt_select() {
    local prompt="$1"
    local var_name="$2"
    shift 2
    local options=("$@")

    echo -e "${BLUE}${prompt}${NC}"
    PS3="Select (1-${#options[@]}): "
    select opt in "${options[@]}"; do
        if [ -n "$opt" ]; then
            eval "$var_name='$opt'"
            break
        else
            print_error "Invalid selection. Try again."
        fi
    done
}

# Banner
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║         Math Teacher - Playground Generator  🎮            ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Step 1: Math Topic Level
print_info "Step 1/5: Choose Math Level"
prompt_select "What level?" LEVEL \
    "Elementary (Ages 6-12)" \
    "Middle School (Ages 12-15)" \
    "High School (Ages 15-18)" \
    "Advanced (College+)"

# Step 2: Specific Topic
print_info "Step 2/5: Choose Topic"

case $LEVEL in
    "Elementary (Ages 6-12)")
        prompt_select "Which topic?" TOPIC \
            "Fractions" \
            "Multiplication Table" \
            "Geometry Shapes" \
            "Number Patterns" \
            "Time & Clock" \
            "Money & Change"
        ;;
    "Middle School (Ages 12-15)")
        prompt_select "Which topic?" TOPIC \
            "Linear Equations" \
            "Ratios & Proportions" \
            "Percentages" \
            "Basic Statistics" \
            "Pythagorean Theorem" \
            "Order of Operations"
        ;;
    "High School (Ages 15-18)")
        prompt_select "Which topic?" TOPIC \
            "Quadratic Functions" \
            "Trigonometry" \
            "Exponential Functions" \
            "Logarithms" \
            "Polynomial Graphs" \
            "Systems of Equations"
        ;;
    "Advanced (College+)")
        prompt_select "Which topic?" TOPIC \
            "Derivatives" \
            "Integrals" \
            "Limits" \
            "Optimization" \
            "Series & Sequences" \
            "Differential Equations"
        ;;
esac

# Step 3: Interaction Type
print_info "Step 3/5: Type of Experience"
prompt_select "What kind of playground?" INTERACTION_TYPE \
    "Visual Explorer (Manipulate and see changes)" \
    "Practice Problems (Randomized with hints)" \
    "Challenge Game (Timed with scoring)" \
    "Concept Demo (Animated explanation)" \
    "Sandbox (Open exploration)"

# Step 4: Difficulty
print_info "Step 4/5: Difficulty Level"
prompt_select "Difficulty?" DIFFICULTY \
    "Easy" \
    "Medium" \
    "Hard"

# Step 5: Output Location
print_info "Step 5/5: Save Location"
prompt_input "Output file name (e.g., fractions-playground.html):" OUTPUT_FILE true
OUTPUT_DIR="./math-playgrounds"
mkdir -p "$OUTPUT_DIR"
OUTPUT_PATH="$OUTPUT_DIR/$OUTPUT_FILE"

# Generate the playground HTML
echo ""
print_info "🎨 Generating your interactive math playground..."
echo ""

# Create the HTML file based on topic
case $TOPIC in
    "Fractions")
        generate_fractions_playground
        ;;
    "Quadratic Functions")
        generate_quadratic_playground
        ;;
    "Derivatives")
        generate_derivatives_playground
        ;;
    *)
        generate_generic_playground
        ;;
esac

# Success message
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                    🎉 Success!                             ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
print_success "Playground created: $OUTPUT_PATH"
print_success "Topic: $TOPIC"
print_success "Level: $LEVEL"
print_success "Type: $INTERACTION_TYPE"
echo ""
print_info "🚀 To use your playground:"
echo "   1. Open in browser: open $OUTPUT_PATH"
echo "   2. Or double-click the file"
echo "   3. Start learning by playing!"
echo ""
print_info "💡 The playground includes:"
echo "   ✓ Interactive visualizations"
echo "   ✓ Real-time feedback"
echo "   ✓ Gamification (points & achievements)"
echo "   ✓ Hints and explanations"
echo "   ✓ Mobile-friendly design"
echo ""

# Function implementations would go here
# For brevity, showing one example:

generate_generic_playground() {
    cat > "$OUTPUT_PATH" << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Math Playground - TOPIC_NAME</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 20px;
      color: white;
    }
    .header {
      text-align: center;
      margin-bottom: 30px;
    }
    h1 { font-size: 3em; margin-bottom: 10px; text-shadow: 2px 2px 4px rgba(0,0,0,0.3); }
    .score-board {
      background: rgba(255,255,255,0.2);
      padding: 15px 30px;
      border-radius: 20px;
      font-size: 1.5em;
      display: inline-block;
      backdrop-filter: blur(10px);
    }
    .main-content {
      background: white;
      padding: 40px;
      border-radius: 20px;
      box-shadow: 0 20px 60px rgba(0,0,0,0.3);
      color: #333;
      max-width: 900px;
      width: 100%;
    }
    .visualization {
      width: 100%;
      height: 400px;
      border: 3px solid #667eea;
      border-radius: 15px;
      margin: 20px 0;
      background: #f9f9f9;
    }
    .controls {
      display: grid;
      gap: 20px;
      margin: 20px 0;
    }
    .control-group {
      display: flex;
      flex-direction: column;
      gap: 10px;
    }
    label {
      font-weight: bold;
      font-size: 1.1em;
      color: #667eea;
    }
    input[type="range"] {
      width: 100%;
      height: 10px;
      border-radius: 5px;
      background: #ddd;
      outline: none;
      cursor: pointer;
    }
    input[type="number"], input[type="text"] {
      padding: 12px;
      font-size: 1.1em;
      border: 2px solid #667eea;
      border-radius: 10px;
      width: 100%;
    }
    button {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border: none;
      padding: 15px 30px;
      font-size: 1.2em;
      border-radius: 10px;
      cursor: pointer;
      transition: transform 0.2s, box-shadow 0.2s;
      font-weight: bold;
    }
    button:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.2);
    }
    button:active { transform: translateY(0); }
    .explanation {
      background: #f0f7ff;
      padding: 20px;
      border-radius: 10px;
      margin: 20px 0;
      border-left: 5px solid #667eea;
      line-height: 1.8;
    }
    .achievement {
      position: fixed;
      top: 20px;
      right: 20px;
      background: gold;
      color: #333;
      padding: 20px 30px;
      border-radius: 15px;
      font-weight: bold;
      font-size: 1.2em;
      animation: slideIn 0.5s ease;
      box-shadow: 0 10px 30px rgba(0,0,0,0.3);
      z-index: 1000;
    }
    @keyframes slideIn {
      from { transform: translateX(400px); opacity: 0; }
      to { transform: translateX(0); opacity: 1; }
    }
    @media (max-width: 768px) {
      h1 { font-size: 2em; }
      .main-content { padding: 20px; }
    }
  </style>
</head>
<body>
  <div class="header">
    <h1>🎯 TOPIC_NAME Playground</h1>
    <div class="score-board">
      Points: <span id="points">0</span> 🌟 | Streak: <span id="streak">0</span> 🔥
    </div>
  </div>

  <div class="main-content">
    <canvas id="canvas" class="visualization"></canvas>

    <div class="controls">
      <div class="control-group">
        <label for="input1">Parameter 1:</label>
        <input type="range" id="input1" min="0" max="10" value="5" step="0.1">
        <span id="value1">5</span>
      </div>

      <div class="control-group">
        <label for="input2">Parameter 2:</label>
        <input type="range" id="input2" min="0" max="10" value="3" step="0.1">
        <span id="value2">3</span>
      </div>

      <button onclick="newProblem()">New Challenge 🎲</button>
      <button onclick="showHint()">Get Hint 💡</button>
    </div>

    <div class="explanation" id="explanation">
      Welcome to your interactive math playground! Adjust the sliders above to explore and learn.
    </div>
  </div>

  <script>
    let points = 0;
    let streak = 0;
    const canvas = document.getElementById('canvas');
    const ctx = canvas.getContext('2d');

    // Set canvas size
    canvas.width = canvas.offsetWidth;
    canvas.height = canvas.offsetHeight;

    // Event listeners
    document.getElementById('input1').addEventListener('input', update);
    document.getElementById('input2').addEventListener('input', update);

    function update() {
      const val1 = parseFloat(document.getElementById('input1').value);
      const val2 = parseFloat(document.getElementById('input2').value);

      document.getElementById('value1').textContent = val1.toFixed(1);
      document.getElementById('value2').textContent = val2.toFixed(1);

      visualize(val1, val2);
      updateExplanation(val1, val2);
    }

    function visualize(val1, val2) {
      ctx.clearRect(0, 0, canvas.width, canvas.height);

      // Example visualization - customize based on topic
      const centerX = canvas.width / 2;
      const centerY = canvas.height / 2;

      // Draw based on parameters
      ctx.fillStyle = '#667eea';
      ctx.beginPath();
      ctx.arc(centerX, centerY, val1 * 20, 0, Math.PI * 2);
      ctx.fill();

      ctx.fillStyle = '#FF6347';
      ctx.beginPath();
      ctx.arc(centerX + val2 * 30, centerY, 30, 0, Math.PI * 2);
      ctx.fill();
    }

    function updateExplanation(val1, val2) {
      const result = val1 + val2;
      document.getElementById('explanation').innerHTML = `
        <strong>Current Values:</strong><br>
        Parameter 1: ${val1.toFixed(2)}<br>
        Parameter 2: ${val2.toFixed(2)}<br>
        <strong>Result: ${result.toFixed(2)}</strong>
      `;
    }

    function newProblem() {
      awardPoints(5);
      document.getElementById('input1').value = Math.random() * 10;
      document.getElementById('input2').value = Math.random() * 10;
      update();
    }

    function showHint() {
      showAchievement('💡 Try different values and see what happens!');
    }

    function awardPoints(amount) {
      points += amount;
      streak++;
      document.getElementById('points').textContent = points;
      document.getElementById('streak').textContent = streak;

      if (streak % 5 === 0) {
        showAchievement(`🔥 ${streak} streak! Awesome!`);
      }
    }

    function showAchievement(text) {
      const achievement = document.createElement('div');
      achievement.className = 'achievement';
      achievement.textContent = text;
      document.body.appendChild(achievement);
      setTimeout(() => achievement.remove(), 3000);
    }

    // Initialize
    update();
  </script>
</body>
</html>
EOF

    # Replace placeholders
    sed -i "s/TOPIC_NAME/$TOPIC/g" "$OUTPUT_PATH"
}

print_info "🎓 Happy learning!"
