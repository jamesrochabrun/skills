#!/bin/bash

# Reading Teacher - Interactive Playground Generator
# Creates instant, interactive reading learning experiences

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
echo "║        Reading Teacher - Playground Generator 📚           ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

print_info "Step 1/4: Age Group"
prompt_select "Choose age group:" AGE_GROUP \
    "Toddler (Ages 1-3)" \
    "Preschool (Ages 3-5)" \
    "Early Elementary (Ages 5-7)" \
    "Elementary (Ages 7-10)"

print_info "Step 2/4: Reading Skill"
case $AGE_GROUP in
    "Toddler (Ages 1-3)")
        prompt_select "Which skill?" SKILL \
            "Letter Recognition" \
            "Letter Sounds" \
            "Alphabet Song"
        ;;
    "Preschool (Ages 3-5)")
        prompt_select "Which skill?" SKILL \
            "Phonics - CVC Words" \
            "Letter Matching" \
            "Rhyming Words"
        ;;
    "Early Elementary (Ages 5-7)")
        prompt_select "Which skill?" SKILL \
            "Sight Words" \
            "Word Families" \
            "Simple Sentences"
        ;;
    "Elementary (Ages 7-10)")
        prompt_select "Which skill?" SKILL \
            "Reading Comprehension" \
            "Vocabulary Building" \
            "Story Sequencing"
        ;;
esac

print_info "Step 3/4: Activity Type"
prompt_select "Type of activity?" ACTIVITY_TYPE \
    "Interactive Explorer" \
    "Practice Game" \
    "Timed Challenge"

print_info "Step 4/4: Output"
read -p "Playground name (e.g., letter-land.html): " OUTPUT_FILE
OUTPUT_DIR="./reading-playgrounds"
mkdir -p "$OUTPUT_DIR"
OUTPUT_PATH="$OUTPUT_DIR/$OUTPUT_FILE"

print_info "📚 Generating your reading playground..."

# Generate based on skill (showing letter recognition as example)
cat > "$OUTPUT_PATH" << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>📚 Reading Playground</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Comic Sans MS', 'Chalkboard SE', cursive, sans-serif;
      background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 20px;
    }
    .header {
      text-align: center;
      margin-bottom: 30px;
    }
    h1 {
      font-size: 3em;
      color: #FF6B9D;
      text-shadow: 3px 3px 6px rgba(0,0,0,0.1);
    }
    .stars {
      font-size: 2em;
      background: rgba(255,255,255,0.8);
      padding: 10px 30px;
      border-radius: 30px;
      margin-top: 10px;
    }
    .letter-display {
      background: white;
      width: 350px;
      height: 350px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 12em;
      font-weight: bold;
      color: #667eea;
      box-shadow: 0 20px 60px rgba(0,0,0,0.2);
      margin: 20px;
      cursor: pointer;
      transition: all 0.3s;
      user-select: none;
    }
    .letter-display:hover { transform: scale(1.05); }
    .letter-display:active { transform: scale(0.95); }
    .controls {
      display: flex;
      gap: 20px;
      margin: 20px;
      flex-wrap: wrap;
      justify-content: center;
    }
    .btn {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border: none;
      padding: 20px 40px;
      font-size: 1.5em;
      border-radius: 20px;
      cursor: pointer;
      transition: transform 0.2s;
      font-weight: bold;
      box-shadow: 0 10px 25px rgba(0,0,0,0.2);
    }
    .btn:hover { transform: translateY(-5px); }
    .instruction {
      font-size: 1.8em;
      color: #333;
      margin: 20px;
      text-align: center;
      background: rgba(255,255,255,0.9);
      padding: 20px;
      border-radius: 15px;
      max-width: 600px;
    }
    .celebration {
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%) scale(0);
      font-size: 8em;
      animation: celebrate 1s ease forwards;
      pointer-events: none;
    }
    @keyframes celebrate {
      0% { transform: translate(-50%, -50%) scale(0) rotate(0); }
      50% { transform: translate(-50%, -50%) scale(1.3) rotate(180deg); }
      100% { transform: translate(-50%, -50%) scale(1) rotate(360deg); opacity: 0; }
    }
  </style>
</head>
<body>
  <div class="header">
    <h1>🌈 Letter Land Adventure!</h1>
    <div class="stars">Stars: <span id="stars">0</span> ⭐</div>
  </div>

  <div class="letter-display" id="letterDisplay" onclick="clickLetter()">A</div>

  <div class="instruction" id="instruction">
    Click the letter to hear its name and sound!
  </div>

  <div class="controls">
    <button class="btn" onclick="nextLetter()">Next Letter ➡️</button>
    <button class="btn" onclick="randomLetter()">Random 🎲</button>
    <button class="btn" onclick="playGame()">Practice Game 🎮</button>
  </div>

  <script>
    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
    const letterWords = {
      'A': 'Apple', 'B': 'Ball', 'C': 'Cat', 'D': 'Dog', 'E': 'Elephant',
      'F': 'Fish', 'G': 'Goat', 'H': 'Hat', 'I': 'Ice Cream', 'J': 'Juice',
      'K': 'Kite', 'L': 'Lion', 'M': 'Moon', 'N': 'Nest', 'O': 'Orange',
      'P': 'Pig', 'Q': 'Queen', 'R': 'Rabbit', 'S': 'Sun', 'T': 'Tiger',
      'U': 'Umbrella', 'V': 'Violin', 'W': 'Whale', 'X': 'X-ray', 'Y': 'Yellow', 'Z': 'Zebra'
    };
    const colors = ['#FF6B9D', '#4ECDC4', '#FFE66D', '#A8E6CF', '#FF8B94'];

    let currentIndex = 0;
    let stars = 0;

    function updateDisplay(letter) {
      const display = document.getElementById('letterDisplay');
      display.textContent = letter;
      display.style.color = colors[Math.floor(Math.random() * colors.length)];
    }

    function clickLetter() {
      const letter = document.getElementById('letterDisplay').textContent;

      stars++;
      document.getElementById('stars').textContent = stars;

      celebrate('🎉');

      // Update instruction
      document.getElementById('instruction').textContent =
        `${letter}! ${letter} is for ${letterWords[letter]}!`;

      // Speak letter (if browser supports)
      if ('speechSynthesis' in window) {
        const utterance = new SpeechSynthesisUtterance(
          `${letter}. ${letter} is for ${letterWords[letter]}`
        );
        utterance.rate = 0.8;
        utterance.pitch = 1.3;
        speechSynthesis.speak(utterance);
      }
    }

    function nextLetter() {
      currentIndex = (currentIndex + 1) % alphabet.length;
      updateDisplay(alphabet[currentIndex]);
      document.getElementById('instruction').textContent = 'Click the letter!';
    }

    function randomLetter() {
      currentIndex = Math.floor(Math.random() * alphabet.length);
      updateDisplay(alphabet[currentIndex]);
      celebrate('✨');
    }

    function playGame() {
      // Simple recognition game
      const target = alphabet[Math.floor(Math.random() * alphabet.length)];
      document.getElementById('instruction').textContent =
        `Find the letter ${target}! Click when you see it.`;

      // Cycle through letters
      let count = 0;
      const interval = setInterval(() => {
        updateDisplay(alphabet[Math.floor(Math.random() * alphabet.length)]);
        count++;
        if (count > 20) clearInterval(interval);
      }, 800);
    }

    function celebrate(emoji) {
      const div = document.createElement('div');
      div.className = 'celebration';
      div.textContent = emoji;
      document.body.appendChild(div);
      setTimeout(() => div.remove(), 1000);
    }

    // Initialize
    updateDisplay(alphabet[0]);
  </script>
</body>
</html>
EOF

echo ""
print_success "Playground created: $OUTPUT_PATH"
echo ""
print_info "🚀 To use:"
echo "   open $OUTPUT_PATH"
echo ""
print_info "Features:"
echo "   ✓ Interactive letter display"
echo "   ✓ Audio pronunciation (if supported)"
echo "   ✓ Star rewards"
echo "   ✓ Practice game mode"
echo "   ✓ Colorful, engaging design"
echo ""
