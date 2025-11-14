# Technical Writing Best Practices

## Core Principles

### 1. Clarity Over Cleverness
- Use simple, direct language
- Avoid jargon unless necessary
- Define technical terms on first use
- Write for your audience's expertise level

### 2. Structure and Organization
- Start with a clear overview
- Use hierarchical headings (H1 → H2 → H3)
- Group related information together
- Add table of contents for long documents

### 3. Conciseness
- Remove unnecessary words
- Use active voice ("We implemented" vs "It was implemented")
- Break long sentences into shorter ones
- One idea per sentence

### 4. Consistency
- Use the same terminology throughout
- Follow a consistent format structure
- Maintain consistent tone and voice
- Use standard naming conventions

---

## Writing Guidelines

### Headlines and Titles
- Descriptive and specific
- Use title case for main headings
- Include keywords for searchability
- Keep under 60 characters when possible

**Good:** "Design Document: Real-Time Chat Architecture"
**Bad:** "Chat System Doc"

### Introductions
- State purpose in first paragraph
- Summarize key points upfront
- Set reader expectations
- Include relevant context

### Body Content
- Lead with main point (pyramid structure)
- Support claims with evidence
- Use examples liberally
- Break up walls of text

### Conclusions
- Summarize key takeaways
- List action items
- Include next steps
- Provide contact information

---

## Language and Style

### Active Voice
**Prefer:** "The service processes requests"
**Avoid:** "Requests are processed by the service"

### Present Tense
**Prefer:** "The function returns a promise"
**Avoid:** "The function will return a promise"

### Second Person for Instructions
**Prefer:** "You can configure the timeout"
**Avoid:** "One can configure the timeout"

### Specific Numbers
**Prefer:** "Reduces latency by 40%"
**Avoid:** "Significantly reduces latency"

---

## Document Structure Templates

### Design Document Structure
1. Overview (Purpose, Goals, Non-goals)
2. Background & Context
3. Proposed Solution
4. Detailed Design (Data models, APIs, Architecture)
5. Trade-offs & Alternatives
6. Success Metrics
7. Implementation Plan
8. Security & Privacy
9. Operational Considerations
10. Open Questions
11. References

### RFC Structure
1. Metadata (Author, Date, Status)
2. Summary
3. Motivation (Problem statement)
4. Proposed Solution
5. Detailed Design
6. Drawbacks & Alternatives
7. Adoption Strategy
8. Unresolved Questions
9. Related Work

### ADR Structure
1. Title
2. Status (Proposed, Accepted, Deprecated, Superseded)
3. Context (What's the issue we're facing?)
4. Decision (What we've decided to do)
5. Consequences (Positive and negative outcomes)
6. Alternatives Considered

### API Documentation Structure
1. Overview
2. Authentication
3. Endpoints (Method, Path, Parameters, Responses)
4. Error Codes
5. Rate Limiting
6. Code Examples
7. Changelog

### Post-Mortem Structure
1. Summary
2. Timeline of Events
3. Root Cause Analysis (5 Whys)
4. Impact Assessment
5. What Went Well
6. What Went Wrong
7. Action Items
8. Lessons Learned

---

## Formatting Best Practices

### Code Blocks
Always specify language for syntax highlighting:

```typescript
// Good: Language specified
function calculateTotal(items: Item[]): number {
  return items.reduce((sum, item) => sum + item.price, 0);
}
```

### Lists
- Use bulleted lists for unordered items
- Use numbered lists for sequential steps
- Keep list items parallel in structure
- Don't exceed 7-10 items (split if needed)

### Tables
- Use for structured data comparison
- Include header row
- Keep columns narrow enough to scan
- Left-align text, right-align numbers

| Metric | Current | Target |
|--------|---------|--------|
| Latency | 500ms | 200ms |
| Throughput | 1K/s | 10K/s |

### Emphasis
- **Bold** for important terms on first use
- *Italic* for emphasis
- `Code font` for technical terms, variables, commands
- > Blockquotes for important callouts

### Links
- Use descriptive link text
- Avoid "click here" or "this link"
- Link to authoritative sources

**Good:** See [AWS Lambda documentation](https://docs.aws.amazon.com/lambda/)
**Bad:** Click [here](https://docs.aws.amazon.com/lambda/) for docs

---

## Diagrams and Visuals

### When to Use Diagrams
- System architecture (components and connections)
- Data flow (how information moves)
- Sequence of operations (timing and order)
- Decision trees (conditional logic)
- State machines (status transitions)

### Diagram Best Practices
- Include a title and caption
- Use consistent shapes and colors
- Label all components clearly
- Show direction of flow with arrows
- Add legend if needed
- Keep it simple (split if too complex)

### Diagram Types
- **Flowchart:** Process steps and decisions
- **Sequence:** Interactions over time
- **Architecture:** System components and relationships
- **ERD:** Database entities and relationships
- **State:** States and transitions
- **Gantt:** Timeline and dependencies

---

## Code Examples

### Good Code Examples
- Complete and runnable
- Include necessary imports/dependencies
- Show both request and response
- Handle errors appropriately
- Add comments for complex logic
- Use realistic variable names

### Example Structure
```typescript
// 1. Import dependencies
import { createOrder } from './api';

// 2. Define data
const orderData = {
  userId: 'user_123',
  items: [{ productId: 'prod_456', quantity: 2 }],
};

// 3. Make request
try {
  const order = await createOrder(orderData);
  console.log('Order created:', order.id);
} catch (error) {
  // 4. Handle errors
  console.error('Failed to create order:', error.message);
}
```

---

## Common Mistakes to Avoid

### ❌ Vague Language
**Bad:** "The system is pretty fast"
**Good:** "The system handles 10,000 requests per second with p99 latency under 100ms"

### ❌ Assuming Context
**Bad:** "Add the config to the usual place"
**Good:** "Add the config to `/etc/app/config.yaml`"

### ❌ Overusing Acronyms
**Bad:** "The SQS DLQ handles failed msgs from the SNS topic"
**Good:** "The SQS Dead Letter Queue (DLQ) handles failed messages from the SNS topic"

### ❌ Missing Examples
**Bad:** "You can filter results using query parameters"
**Good:** "You can filter results using query parameters like `?status=active&limit=10`"

### ❌ Ignoring the Audience
**Bad (to non-engineers):** "We'll use a B+ tree index for O(log n) lookups"
**Good:** "We'll use database indexing to make searches much faster"

### ❌ Burying the Lede
**Bad:** "After extensive analysis... [5 paragraphs] ...we recommend using PostgreSQL"
**Good:** "We recommend using PostgreSQL. Here's why: [detailed analysis]"

### ❌ No Visual Hierarchy
Use headings, spacing, and formatting to guide the eye and make scanning easy.

---

## Editing Checklist

Before publishing, verify:

- [ ] Title clearly describes content
- [ ] First paragraph states purpose
- [ ] All technical terms defined
- [ ] Code examples are complete and tested
- [ ] Diagrams are clear and labeled
- [ ] Links are working and relevant
- [ ] No spelling or grammar errors
- [ ] Consistent formatting throughout
- [ ] Appropriate for target audience
- [ ] Includes next steps/action items
- [ ] Document metadata is complete (author, date, reviewers)

---

## Tone Guidelines

### Technical Documentation
- **Formal but approachable**
- Objective and factual
- Avoid humor (can be misinterpreted)
- Focus on information, not persuasion

### Runbooks and Procedures
- **Direct and instructional**
- Use imperative mood ("Run this command")
- Step-by-step format
- Include safety warnings

### Design Proposals
- **Balanced and analytical**
- Present trade-offs fairly
- Support with data
- Acknowledge alternatives

### Post-Mortems
- **Blameless and constructive**
- Focus on systems, not people
- Emphasize learning
- Forward-looking action items

---

## Accessibility Considerations

- Use sufficient color contrast
- Don't rely solely on color to convey meaning
- Provide alt text for images
- Use semantic HTML/markdown structure
- Keep paragraphs short for readability
- Use plain language when possible

---

## Platform-Specific Tips

### Google Docs
- Use built-in heading styles for navigation
- Enable outline view for long documents
- Use suggesting mode for reviews
- Add bookmarks for cross-references

### Notion
- Use callout blocks for important information
- Toggle lists for expandable sections
- Inline databases for structured data
- Link to related pages liberally

### Quip
- Use @mentions for collaboration
- Embed live spreadsheets for data
- Add checklists for action items
- Use folders for organization

### Confluence
- Use page templates for consistency
- Add labels for discoverability
- Use macros for dynamic content
- Create space guidelines for team docs

---

## Maintenance and Updates

### Version Control
- Track major revisions
- Include changelog section
- Note deprecated information
- Archive old versions

### Review Cycle
- Set review dates for critical docs
- Assign owners for maintenance
- Update links and examples regularly
- Remove outdated content

### Deprecation
- Mark clearly with status banner
- Link to replacement documentation
- Explain migration path
- Set sunset date

---

## Resources

### Style Guides
- [Google Developer Documentation Style Guide](https://developers.google.com/style)
- [Microsoft Writing Style Guide](https://docs.microsoft.com/en-us/style-guide/)
- [Write the Docs](https://www.writethedocs.org/)

### Tools
- **Grammarly:** Grammar and style checking
- **Hemingway Editor:** Readability improvement
- **Mermaid Live Editor:** Diagram creation
- **Carbon:** Beautiful code screenshots

### Books
- *"The Elements of Style"* by Strunk & White
- *"On Writing Well"* by William Zinsser
- *"Docs for Developers"* by Jared Bhatti et al.
