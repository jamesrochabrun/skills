#!/bin/bash

# Reading Teacher - Game Generator
# Creates gamified reading challenges

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
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
echo "║         Reading Teacher - Game Generator 🎮               ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

print_info "Step 1/3: Game Type"
prompt_select "What type of game?" GAME_TYPE \
    "Sight Word Speed Challenge" \
    "Phonics Matching Game" \
    "Word Building Adventure" \
    "Reading Comprehension Quiz"

print_info "Step 2/3: Difficulty"
prompt_select "Difficulty level?" DIFFICULTY \
    "Easy (Kindergarten)" \
    "Medium (1st-2nd Grade)" \
    "Hard (3rd+ Grade)"

print_info "Step 3/3: Output"
read -p "Game name (e.g., sight-word-game.html): " OUTPUT_FILE
OUTPUT_DIR="./reading-games"
mkdir -p "$OUTPUT_DIR"
OUTPUT_PATH="$OUTPUT_DIR/$OUTPUT_FILE"

print_info "🎮 Generating your reading game..."

cat > "$OUTPUT_PATH" << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>📚 Reading Game Challenge</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Arial Black', sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
      max-width: 700px;
      width: 90%;
      text-align: center;
    }
    h1 { font-size: 3em; margin-bottom: 20px; }
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
    .word-display {
      font-size: 5em;
      margin: 40px 0;
      font-weight: bold;
      min-height: 120px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .answer-buttons {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 20px;
      margin: 20px 0;
    }
    .btn {
      background: rgba(255,255,255,0.3);
      border: 3px solid white;
      padding: 30px;
      font-size: 2em;
      border-radius: 15px;
      cursor: pointer;
      transition: all 0.2s;
      font-weight: bold;
      color: white;
    }
    .btn:hover {
      background: rgba(255,255,255,0.5);
      transform: scale(1.05);
    }
    .timer {
      font-size: 3em;
      color: #FFD700;
      margin: 20px 0;
    }
    .feedback {
      font-size: 2em;
      min-height: 60px;
      margin: 20px 0;
    }
    .correct { color: #4CAF50; }
    .incorrect { color: #FF6347; }
    .game-over {
      display: none;
      flex-direction: column;
      gap: 20px;
    }
    .final-score { font-size: 5em; color: #FFD700; }
  </style>
</head>
<body>
  <div class="game-container">
    <h1>🎯 Sight Word Challenge</h1>

    <div class="stats">
      <div class="stat-box">
        <div>Score</div>
        <div id="score">0</div>
      </div>
      <div class="stat-box">
        <div>Streak</div>
        <div id="streak">0</div>
      </div>
    </div>

    <div id="game-area">
      <div class="timer" id="timer">60</div>
      <div class="word-display" id="word">the</div>
      <div class="answer-buttons">
        <button class="btn" onclick="checkAnswer(true)">I Know It! ✓</button>
        <button class="btn" onclick="checkAnswer(false)">Skip ➡️</button>
      </div>
      <div class="feedback" id="feedback"></div>
    </div>

    <div class="game-over" id="gameOver">
      <h2>🎉 Time's Up!</h2>
      <div class="final-score" id="finalScore">0</div>
      <p id="rating"></p>
      <button class="btn" onclick="restartGame()" style="grid-column: span 2;">Play Again 🔄</button>
    </div>
  </div>

  <script>
    const sightWords = [
      'the', 'of', 'and', 'a', 'to', 'in', 'is', 'you', 'that', 'it',
      'he', 'was', 'for', 'on', 'are', 'as', 'with', 'his', 'they', 'I',
      'at', 'be', 'this', 'have', 'from', 'or', 'one', 'had', 'by', 'words',
      'but', 'not', 'what', 'all', 'were', 'we', 'when', 'your', 'can', 'said',
      'there', 'use', 'an', 'each', 'which', 'she', 'do', 'how', 'their', 'if'
    ];

    let score = 0;
    let streak = 0;
    let timeRemaining = 60;
    let currentWord = '';
    let gameActive = true;
    let timerInterval;

    function newWord() {
      currentWord = sightWords[Math.floor(Math.random() * sightWords.length)];
      document.getElementById('word').textContent = currentWord;
      document.getElementById('feedback').textContent = '';
    }

    function checkAnswer(knows) {
      if (!gameActive) return;

      const feedback = document.getElementById('feedback');

      if (knows) {
        streak++;
        const points = 10 * (1 + streak * 0.1);
        score += Math.floor(points);

        feedback.innerHTML = `<span class="correct">✓ Great! +${Math.floor(points)}</span>`;

        if (streak % 5 === 0) {
          feedback.innerHTML += ` <span style="color: #FFD700;">🔥 ${streak} Streak!</span>`;
        }
      } else {
        streak = 0;
        feedback.innerHTML = `<span class="incorrect">Keep practicing "${currentWord}"!</span>`;
      }

      updateStats();
      setTimeout(newWord, 800);
    }

    function updateStats() {
      document.getElementById('score').textContent = score;
      document.getElementById('streak').textContent = streak;
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
      if (score >= 300) rating = '🏆 Reading Superstar!';
      else if (score >= 200) rating = '⭐ Excellent Reader!';
      else if (score >= 100) rating = '👍 Great Job!';
      else rating = '💪 Keep Practicing!';

      document.getElementById('rating').textContent = rating;
    }

    function restartGame() {
      score = 0;
      streak = 0;
      timeRemaining = 60;
      gameActive = true;

      document.getElementById('game-area').style.display = 'block';
      document.getElementById('gameOver').style.display = 'none';
      document.getElementById('timer').style.color = '#FFD700';

      updateStats();
      newWord();
      startTimer();
    }

    // Keyboard controls
    document.addEventListener('keydown', (e) => {
      if (e.key === ' ' || e.key === 'Enter') checkAnswer(true);
      if (e.key === 'ArrowRight') checkAnswer(false);
    });

    // Initialize
    newWord();
    startTimer();
  </script>
</body>
</html>
EOF

echo ""
print_success "Game created: $OUTPUT_PATH"
echo ""
print_info "🎮 To play:"
echo "   open $OUTPUT_PATH"
echo ""
print_info "Game features:"
echo "   ✓ 60-second challenge"
echo "   ✓ Sight word practice"
echo "   ✓ Streak bonuses"
echo "   ✓ Keyboard controls (Space/Enter = Know, Arrow = Skip)"
echo "   ✓ Progress tracking"
echo ""
