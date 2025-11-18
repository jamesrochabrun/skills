# Common Prompt Engineering Mistakes

Learn from these common pitfalls to create better prompts.

## Mistake 1: Being Too Vague

❌ **Problem:**
```
Write something about AI
```

**Why it fails:**
- No clear scope or direction
- Undefined output format
- Unknown target audience
- No length specification

✅ **Solution:**
```
Write a 500-word introduction to large language models for software developers.

Include:
- What LLMs are and how they work (high-level)
- 3 practical use cases in software development
- 1 code example of API usage
- Limitations to be aware of

Tone: Technical but accessible
Format: Markdown with headers
```

---

## Mistake 2: Instruction Confusion

❌ **Problem:**
```
Here is some text about Python. It talks about lists and dictionaries.
Can you make it better and also add examples? Use clear language.
```

**Why it fails:**
- Instructions mixed with content
- Unclear what "better" means
- No structural separation

✅ **Solution:**
```xml
<instructions>
Improve the following text by:
1. Adding 2 code examples (one for lists, one for dictionaries)
2. Simplifying complex sentences
3. Adding subheadings for each topic
</instructions>

<text_to_improve>
[original text here]
</text_to_improve>

<target_audience>
Beginner Python developers
</target_audience>
```

---

## Mistake 3: No Examples (When Needed)

❌ **Problem:**
```
Extract entities from customer support tickets in a structured format.
```

**Why it fails:**
- "Structured format" is ambiguous
- No clarity on what entities matter
- Different interpretations possible

✅ **Solution:**
```xml
<instructions>
Extract entities from customer support tickets.
</instructions>

<examples>
<example>
<input>
My order #12345 never arrived. I contacted support@example.com but no response.
</input>
<output>
{
  "order_id": "12345",
  "issue_type": "delivery",
  "contact_method": "email",
  "email": "support@example.com"
}
</output>
</example>
</examples>

<input>
[new ticket]
</input>
```

---

## Mistake 4: Prompt Too Long

❌ **Problem:**
```
[5000 words of background information]
[500 words of instructions]
[1000 words of examples]

Now answer this simple question: What is the capital of France?
```

**Why it fails:**
- Wastes tokens on irrelevant context
- Dilutes important information
- Slower and more expensive
- May confuse the model

✅ **Solution:**
```
What is the capital of France?
```

**Principle:** Use minimum necessary context

---

## Mistake 5: Not Controlling Output Format

❌ **Problem:**
```
Give me the user's information from this text.
```

**Result:** Unpredictable format - might be prose, bullet points, or inconsistent structure

✅ **Solution:**
```xml
<instructions>
Extract user information and return as JSON.
</instructions>

<input>
[text here]
</input>

<output_format>
{
  "name": string,
  "email": string | null,
  "phone": string | null
}
</output_format>