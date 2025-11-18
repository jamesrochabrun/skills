# Core Prompt Engineering Techniques

Anthropic's official prompt engineering techniques for Claude AI models.

## 1. Be Clear and Direct

**What it is:** Provide explicit, unambiguous instructions

**Why it works:** Claude 4.x models are trained for precise instruction following

**When to use:**
- Any prompt where clarity matters
- Production systems requiring consistent output
- Complex tasks with specific requirements

**How to apply:**
- State exactly what you want
- Specify format, length, and tone
- Avoid vague or ambiguous language
- Include specific constraints and requirements

**Examples:**

❌ **Bad:**
```
Tell me about Python
```

✅ **Good:**
```
Write a 300-word explanation of Python's list comprehensions for intermediate developers.
Include:
- 3 practical examples
- Performance considerations
- Common pitfalls to avoid
```

---

## 2. Use XML Tags for Structure

**What it is:** Organize prompts with XML tags like `<instructions>`, `<example>`, `<context>`

**Why it works:** Claude was trained with XML tags, naturally recognizing them as structural elements

**When to use:**
- Separating data from instructions
- Complex prompts with multiple sections
- When working with variable content
- Production systems requiring clear boundaries

**Common tags:**
- `<instructions>` - Main task description
- `<example>` - Few-shot examples
- `<context>` - Background information
- `<document>` - Input data to process
- `<output_format>` - Expected result format
- `<constraints>` - Limitations and rules

**Example:**
```xml
<instructions>
Analyze the customer review below and extract structured sentiment data.
</instructions>

<review>
The product arrived damaged and customer service was unhelpful.
</review>

<output_format>
Return JSON with:
- "sentiment": "positive" | "negative" | "neutral"
- "confidence": 0.0 to 1.0
- "key_issues": array of strings
</output_format>
```

---

## 3. Chain of Thought (CoT)

**What it is:** Ask Claude to think step-by-step before providing final answer

**Why it works:** Breaking down problems leads to more accurate, nuanced, and reliable responses

**When to use:**
- Math and logical reasoning problems
- Complex analysis tasks
- Multi-step processes
- When accuracy is critical
- Debugging and troubleshooting

**How to apply:**
- Add "Think step by step" to your prompt
- Request reasoning in `<thinking>` tags
- Ask Claude to show its work
- Guide the thinking process with specific steps

**Examples:**

**Basic CoT:**
```
Solve this problem step by step:

<problem>
A store sells apples for $2 each. If you buy 5 or more, you get 20% off.
How much do 7 apples cost?
</problem>

Think through this step by step, showing your work.
```

**Structured thinking:**
```
Analyze this code for bugs. Use the following process:

<thinking>
1. Read and understand the code structure
2. Identify potential issues
3. Assess severity of each issue
4. Recommend fixes
</thinking>

<code>
[code here]
</code>
```

---

## 4. Prefilling Claude's Response

**What it is:** Provide the beginning of Claude's response to guide output format and style

**Why it works:** Immediately directs the response in the desired direction

**When to use:**
- Forcing specific output formats (especially JSON)
- Controlling tone and style
- Ensuring responses start correctly
- Avoiding preambles

**Examples:**

**JSON output:**
```
User: Extract the name, email, and phone from this text: [text]