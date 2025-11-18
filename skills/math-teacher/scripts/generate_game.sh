#!/bin/bash

# Math Teacher - Game Generator
# Creates gamified math challenges with scoring and achievements

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✓ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ $1${NC}"; }

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
        fi
    done
}

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║            Math Teacher - Game Generator  🎮               ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

print_info "Step 1/3: Game Type"
prompt_select "What type of game?" GAME_TYPE \
    "Speed Challenge (Time Attack)" \
    "Accuracy Mode (No Mistakes)" \
    "Endless Practice (Streak Building)" \
    "Boss Battle (Progressive Difficulty)"

print_info "Step 2/3: Math Topic"
prompt_select "Which topic?" TOPIC \
    "Mental Math" \
    "Fractions" \
    "Algebra" \
    "Geometry" \
    "Mixed Topics"

print_info "Step 3/3: Output"
read -p "Game name (e.g., speed-math-game.html): " OUTPUT_FILE
OUTPUT_DIR="./math-games"
mkdir -p "$OUTPUT_DIR"
OUTPUT_PATH="$OUTPUT_DIR/$OUTPUT_FILE"

print_info "🎮 Generating your math game..."

cat > "$OUTPUT_PATH" << 'GAMEEOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Math Game Challenge</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Arial Black', sans-serif;
      background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      color: white;
    }
    .game-container {
      background: rgba(255,255,255,0.1);
      backdrop-filter: blur(10px);
      padding: 40px;
      border-radius: 30px;
      box-shadow: 0 20px 60px rgba(0,0,0,0.5);
      max-width: 600px;
      width: 90%;
      text-align: center;
    }
    h1 { font-size: 3em; margin-bottom: 10px; text-shadow: 3px 3px 6px rgba(0,0,0,0.5); }
    .stats {
      display: flex;
      justify-content: space-around;
      margin: 30px 0;
      font-size: 1.5em;
    }
    .stat-box {
      background: rgba(255,255,255,0.2);
      padding: 15px 25px;
      border-radius: 15px;
    }
    .problem {
      font-size: 4em;
      margin: 40px 0;
      font-weight: bold;
      text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
    }
    .answer-input {
      font-size: 2em;
      padding: 20px;
      border: none;
      border-radius: 15px;
      text-align: center;
      width: 100%;
      margin: 20px 0;
      background: white;
      color: #333;
      font-weight: bold;
    }
    .button {
      background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
      color: white;
      border: none;
      padding: 20px 40px;
      font-size: 1.5em;
      border-radius: 15px;
      cursor: pointer;
      margin: 10px;
      transition: transform 0.2s;
      font-weight: bold;
    }
    .button:hover { transform: scale(1.05); }
    .button:active { transform: scale(0.95); }
    .feedback {
      font-size: 2em;
      margin: 20px 0;
      min-height: 60px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .correct { color: #4CAF50; }
    .incorrect { color: #FF6347; }
    .timer {
      font-size: 3em;
      color: #FFD700;
      font-weight: bold;
      margin: 20px 0;
    }
    .progress-bar {
      width: 100%;
      height: 20px;
      background: rgba(255,255,255,0.2);
      border-radius: 10px;
      overflow: hidden;
      margin: 20px 0;
    }
    .progress-fill {
      height: 100%;
      background: linear-gradient(90deg, #4CAF50, #8BC34A);
      transition: width 0.3s ease;
    }
    .achievement-popup {
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%) scale(0);
      background: linear-gradient(135deg, #FFD700, #FFA500);
      color: #333;
      padding: 40px;
      border-radius: 20px;
      font-size: 2em;
      font-weight: bold;
      box-shadow: 0 20px 60px rgba(0,0,0,0.5);
      animation: popIn 0.5s ease forwards;
      z-index: 1000;
    }
    @keyframes popIn {
      to { transform: translate(-50%, -50%) scale(1); }
    }
    .game-over {
      display: none;
      flex-direction: column;
      gap: 20px;
    }
    .final-score { font-size: 4em; color: #FFD700; }
  </style>
</head>
<body>
  <div class="game-container">
    <h1>🎯 Math Challenge</h1>

    <div class="stats">
      <div class="stat-box">
        <div>Score</div>
        <div id="score">0</div>
      </div>
      <div class="stat-box">
        <div>Streak</div>
        <div id="streak">0</div>
      </div>
      <div class="stat-box">
        <div>Level</div>
        <div id="level">1</div>
      </div>
    </div>

    <div id="game-area">
      <div class="timer" id="timer">60</div>
      <div class="progress-bar">
        <div class="progress-fill" id="progress"></div>
      </div>
      <div class="problem" id="problem">5 + 3 = ?</div>
      <input type="number" class="answer-input" id="answer" placeholder="Your answer...">
      <button class="button" onclick="checkAnswer()">Submit ✓</button>
      <div class="feedback" id="feedback"></div>
    </div>

    <div class="game-over" id="gameOver">
      <h2>🎉 Game Over!</h2>
      <div class="final-score" id="finalScore">0</div>
      <p id="rating"></p>
      <button class="button" onclick="restartGame()">Play Again 🔄</button>
    </div>
  </div>

  <script>
    let score = 0;
    let streak = 0;
    let level = 1;
    let currentProblem = {};
    let timeRemaining = 60;
    let gameActive = true;
    let timerInterval;

    const operators = ['+', '-', '×', '÷'];

    function generateProblem() {
      const difficulty = Math.min(level, 10);
      const range = 10 * difficulty;
      const op = operators[Math.floor(Math.random() * operators.length)];

      let num1 = Math.floor(Math.random() * range) + 1;
      let num2 = Math.floor(Math.random() * range) + 1;

      // Ensure num1 >= num2 for subtraction
      if (op === '-' && num1 < num2) [num1, num2] = [num2, num1];

      // Make division result integer
      if (op === '÷') {
        num1 = num2 * (Math.floor(Math.random() * 10) + 1);
      }

      let answer;
      switch(op) {
        case '+': answer = num1 + num2; break;
        case '-': answer = num1 - num2; break;
        case '×': answer = num1 * num2; break;
        case '÷': answer = num1 / num2; break;
      }

      currentProblem = { num1, num2, op, answer };
      document.getElementById('problem').textContent = `${num1} ${op} ${num2} = ?`;
      document.getElementById('answer').value = '';
      document.getElementById('answer').focus();
    }

    function checkAnswer() {
      if (!gameActive) return;

      const userAnswer = parseFloat(document.getElementById('answer').value);
      const feedback = document.getElementById('feedback');

      if (userAnswer === currentProblem.answer) {
        streak++;
        const points = 10 * (1 + streak * 0.1);
        score += Math.floor(points);

        feedback.innerHTML = `<span class="correct">✓ Correct! +${Math.floor(points)} points</span>`;

        if (streak % 5 === 0) {
          showAchievement(`🔥 ${streak} Streak!`);
          level++;
          document.getElementById('level').textContent = level;
        }

        updateStats();
        setTimeout(generateProblem, 500);
      } else {
        streak = 0;
        feedback.innerHTML = `<span class="incorrect">✗ Incorrect! Answer: ${currentProblem.answer}</span>`;
        updateStats();
        setTimeout(() => {
          feedback.innerHTML = '';
          generateProblem();
        }, 1500);
      }
    }

    function updateStats() {
      document.getElementById('score').textContent = score;
      document.getElementById('streak').textContent = streak;
      document.getElementById('progress').style.width = `${(score % 100)}%`;
    }

    function startTimer() {
      timerInterval = setInterval(() => {
        timeRemaining--;
        document.getElementById('timer').textContent = timeRemaining;

        if (timeRemaining <= 10) {
          document.getElementById('timer').style.color = '#FF6347';
        }

        if (timeRemaining <= 0) {
          endGame();
        }
      }, 1000);
    }

    function endGame() {
      gameActive = false;
      clearInterval(timerInterval);

      document.getElementById('game-area').style.display = 'none';
      document.getElementById('gameOver').style.display = 'flex';
      document.getElementById('finalScore').textContent = score;

      let rating;
      if (score >= 500) rating = '🏆 Math Master!';
      else if (score >= 300) rating = '⭐ Excellent!';
      else if (score >= 200) rating = '👍 Great job!';
      else if (score >= 100) rating = '✓ Good effort!';
      else rating = '💪 Keep practicing!';

      document.getElementById('rating').textContent = rating;
    }

    function restartGame() {
      score = 0;
      streak = 0;
      level = 1;
      timeRemaining = 60;
      gameActive = true;

      document.getElementById('game-area').style.display = 'block';
      document.getElementById('gameOver').style.display = 'none';
      document.getElementById('timer').style.color = '#FFD700';

      updateStats();
      generateProblem();
      startTimer();
    }

    function showAchievement(text) {
      const popup = document.createElement('div');
      popup.className = 'achievement-popup';
      popup.textContent = text;
      document.body.appendChild(popup);
      setTimeout(() => popup.remove(), 2000);
    }

    // Enter key submits answer
    document.getElementById('answer').addEventListener('keypress', (e) => {
      if (e.key === 'Enter') checkAnswer();
    });

    // Initialize
    generateProblem();
    startTimer();
  </script>
</body>
</html>
GAMEEOF

echo ""
print_success "Game created: $OUTPUT_PATH"
echo ""
print_info "Game features:"
echo "   ✓ 60-second time challenge"
echo "   ✓ Progressive difficulty"
echo "   ✓ Streak bonuses"
echo "   ✓ Achievement system"
echo "   ✓ Final score rating"
echo ""
print_info "🚀 Opening game in browser..."
open "$OUTPUT_PATH"
