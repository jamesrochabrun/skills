# Advanced Prompt Engineering Techniques

Advanced techniques for optimizing Claude prompts for complex use cases.

## Few-Shot Prompting (Learning from Examples)

**What it is:** Provide examples of inputs and desired outputs to teach Claude the pattern

**Why it works:** Claude learns from examples better than from abstract instructions alone

**When to use:**
- Complex output formats
- Specific writing styles
- Pattern recognition tasks
- Consistent formatting needs

**Best practices:**
- Use 2-5 diverse examples
- Include edge cases
- Ensure examples are accurate
- Use XML tags to structure examples

**Example:**
```xml
<instructions>
Extract product information in the specified format.
</instructions>

<examples>
<example>
<input>iPhone 15 Pro - $999 - 128GB storage, titanium finish</input>
<output>
Product: iPhone 15 Pro
Price: $999
Features: 128GB storage, titanium finish
</output>
</example>

<example>
<input>MacBook Air M2 chip starting at $1,199</input>
<output>
Product: MacBook Air M2
Price: $1,199
Features: M2 chip
</output>
</example>
</examples>

<input>
[new product description]
</input>
```

---

## Role Prompting

**What it is:** Assign Claude a specific role or persona to guide its responses

**Why it works:** Provides context for appropriate tone, knowledge level, and approach

**When to use:**
- Domain-specific tasks
- Specific communication styles
- Educational content
- Professional contexts

**Examples:**

```
You are a senior Python developer with 10 years of experience.
Review this code and provide feedback as you would to a junior developer.
Focus on best practices, performance, and maintainability.

<code>
[code here]
</code>
```

```
You are a patient elementary school math teacher.
Explain fractions to a 7-year-old using simple language and fun examples.
```

---

## Context Engineering

**What it is:** Carefully managing what information goes into the prompt

**Why it works:** LLMs have finite attention - every token counts

**Key principles:**
- Treat context as a finite resource
- Use "just-in-time" data loading
- Progressive disclosure over dump-all
- Prioritize signal over noise

**Best practices:**
- Start minimal, add based on failures
- Use structural organization (XML/Markdown headers)
- Remove redundant information
- Find the right altitude (specific but flexible)

**Example - Bad:**
```
[Dumps entire 10-page documentation]

Answer this specific question about one feature.
```

**Example - Good:**
```xml
<instructions>
Answer the user's question using only the relevant documentation below.
</instructions>

<relevant_docs>
[Only the 2 paragraphs about the specific feature]
</relevant_docs>

<question>
How do I configure feature X?
</question>
```

---

## Long-Form Task Prompting

**What it is:** Breaking complex tasks into clear steps

**Why it works:** Reduces ambiguity and improves consistency

**When to use:**
- Multi-step processes
- Complex analysis tasks
- Content generation workflows
- Production systems

**Example:**
```xml
<task>
Generate a comprehensive blog post about topic X.
</task>

<steps>
1. Research: Identify 3 key points about the topic
2. Structure: Create an outline with introduction, 3 main sections, conclusion
3. Write: Develop each section with examples and data
4. Optimize: Add SEO-friendly headers and meta description
5. Review: Check for accuracy, clarity, and completeness
</steps>

<requirements>
- Length: 1500-2000 words
- Tone: Professional but approachable
- Include: Statistics, examples, actionable takeaways
- Audience: Intermediate practitioners
</requirements>
```

---

## Prompt Chaining

**What it is:** Breaking a complex task into a sequence of simpler prompts

**Why it works:** Each step focuses on one thing, improving quality

**When to use:**
- Very complex tasks
- When intermediate verification is needed
- Multi-stage processing
- Quality-critical applications

**Example workflow:**
1. **Analysis prompt:** "Extract key themes from this document"
2. **Synthesis prompt:** "Using these themes, create an outline"
3. **Generation prompt:** "Using this outline, write the full content"
4. **Review prompt:** "Review and improve this content"

---

## Output Control Techniques

### Controlling Length

**Specify exact targets:**
```
Write a 250-word summary (aim for 240-260 words)
```

**Use structural limits:**
```
Summarize in exactly 3 bullet points, each 1-2 sentences
```

### Controlling Format

**Use prefilling:**
```
Assistant: {
  "status":
```

**Specify structure:**
```xml
<output_format>
Return markdown with:
## Summary
[2-3 sentences]

## Key Points
- [point 1]
- [point 2]
- [point 3]

## Recommendation
[1 paragraph]
</output_format>
```

### Controlling Tone

**Be specific:**
```
Tone: Technical but accessible
- Use industry terminology
- Explain complex concepts simply
- Professional yet conversational
- Avoid jargon where possible
```

---

## Meta-Prompting

**What it is:** Having Claude help improve or generate prompts

**Use cases:**
- Generating prompt variations
- Improving existing prompts
- Creating test cases
- Prompt optimization

**Example:**
```
I want to create a prompt that extracts structured data from resumes.

Help me design an effective prompt that:
1. Uses XML tags for structure
2. Includes 2 examples
3. Specifies exact JSON output format
4. Handles edge cases (missing information)

Show me the complete prompt.
```

---

## Testing and Iteration

**Empirical approach:**
1. Start with a baseline prompt
2. Test with diverse inputs
3. Identify failure modes
4. Add examples or constraints
5. Re-test and measure improvement
6. Iterate until quality threshold met

**Key metrics:**
- Accuracy on test cases
- Consistency across runs
- Edge case handling
- Token efficiency
- Response time

**Best practice:** Test-driven prompt development
- Create evaluation dataset first
- Define success criteria
- Iterate systematically
- Measure objectively
