# Technical Presentation Guide

Guide to creating effective technical presentations and slides.

---

## Presentation Structure

### Opening (10% of time)
- **Title Slide:** Project name, your name, date
- **Agenda:** What you'll cover
- **Context:** Why this matters

### Body (70% of time)
- **Problem:** What are we solving?
- **Solution:** How are we solving it?
- **Details:** Technical deep dive
- **Demo:** Show it working (if applicable)

### Closing (20% of time)
- **Summary:** Key takeaways
- **Metrics:** Success criteria
- **Next Steps:** What happens next
- **Q&A:** Questions and discussion

---

## Slide Design Principles

### 1. One Idea Per Slide
Each slide should communicate one main point.

**Bad:** Cramming architecture, API, database, and deployment on one slide
**Good:** One slide for architecture, separate slides for details

### 2. Use Visual Hierarchy
- Large text for main points
- Smaller text for supporting details
- Use color to guide attention

### 3. Limit Text
- Max 6 lines of text per slide
- Max 6 words per line (guideline, not rule)
- Use bullet points, not paragraphs

### 4. High Contrast
- Dark text on light background
- Light text on dark background
- Avoid low-contrast combinations

### 5. Consistent Style
- Same fonts throughout
- Consistent color scheme
- Standard layout template

---

## Slide Templates

### Title Slide
```markdown
# [Project Name]
## [Subtitle or Description]

**Presented by:** [Your Name]
**Date:** [Date]
**Team:** [Team Name]
```

### Agenda Slide
```markdown
## Agenda

1. Problem Statement
2. Proposed Solution
3. Architecture Overview
4. Technical Details
5. Success Metrics
6. Timeline & Next Steps
```

### Problem Statement Slide
```markdown
## Problem

**Current Situation:**
- [Pain point 1]
- [Pain point 2]

**Impact:**
- [Impact metric 1]
- [Impact metric 2]

**Why Now:**
[Urgency statement]
```

### Solution Overview Slide
```markdown
## Proposed Solution

[One sentence summary]

**Key Benefits:**
- [Benefit 1]
- [Benefit 2]
- [Benefit 3]

[Simple diagram showing solution]
```

### Architecture Slide
```markdown
## System Architecture

[Architecture diagram]

**Key Components:**
- [Component 1]: [Purpose]
- [Component 2]: [Purpose]
```

### Technical Detail Slide
```markdown
## [Component Name]

**Technology:** [Tech stack]

**Responsibilities:**
- [Responsibility 1]
- [Responsibility 2]

**Key Decisions:**
- [Decision and rationale]
```

### Code Example Slide
```markdown
## Implementation Example

[Code snippet - keep it short!]

**Key Points:**
- [What to notice 1]
- [What to notice 2]
```

### Metrics Slide
```markdown
## Success Metrics

| Metric | Current | Target | Timeline |
|--------|---------|--------|----------|
| [Metric 1] | [Value] | [Value] | [When] |
| [Metric 2] | [Value] | [Value] | [When] |
| [Metric 3] | [Value] | [Value] | [When] |
```

### Timeline Slide
```markdown
## Implementation Timeline

**Phase 1: Foundation** (Weeks 1-2)
- [Task 1]
- [Task 2]

**Phase 2: Core Features** (Weeks 3-4)
- [Task 3]
- [Task 4]

**Phase 3: Launch** (Week 5)
- [Task 5]
```

### Comparison Slide
```markdown
## Option Comparison

| | Option A | Option B | Option C |
|-|----------|----------|----------|
| **Cost** | Low | Medium | High |
| **Time** | Fast | Medium | Slow |
| **Scale** | Limited | Good | Excellent |

**Recommendation:** [Chosen option] because [reason]
```

### Summary Slide
```markdown
## Key Takeaways

1. [Main point 1]
2. [Main point 2]
3. [Main point 3]

**Next Steps:**
- [Action 1]
- [Action 2]
```

### Q&A Slide
```markdown
## Questions?

[Optional: Contact information]
[Optional: Link to docs]
[Optional: Relevant image/logo]
```

---

## Content Guidelines

### Technical Depth
**Know your audience:**
- **Engineering team:** Deep technical details welcome
- **Product team:** Focus on features and user impact
- **Executives:** High-level with business impact
- **Mixed audience:** Start high-level, have backup slides with details

### Code Examples
**Best practices:**
- Syntax highlighted
- Max 10-15 lines
- Remove irrelevant details
- Highlight key parts
- Include comments for context

**Good code slide:**
```typescript
// Simplified authentication flow
async function authenticateUser(credentials: Credentials) {
  // Verify credentials
  const user = await db.findUser(credentials.email);

  if (!user || !await bcrypt.compare(credentials.password, user.hash)) {
    throw new AuthError('Invalid credentials');
  }

  // Generate JWT token
  return jwt.sign({ userId: user.id }, SECRET, { expiresIn: '1h' });
}
```

### Diagrams
**Keep diagrams simple:**
- Focus on key components
- Use colors to group related parts
- Label everything clearly
- Show data flow with arrows
- Include legend if needed

### Data and Metrics
**Make numbers meaningful:**
- Use comparisons (before/after)
- Show trends with charts
- Round to significant figures
- Add context (is this good/bad?)
- Use visualizations over tables

---

## Presentation Delivery Tips

### Preparation
1. **Practice:** Run through 2-3 times
2. **Timing:** Aim for 60-70% of allotted time
3. **Backup:** Have offline version ready
4. **Demos:** Pre-record critical demos
5. **Questions:** Anticipate and prepare answers

### During Presentation
1. **Start strong:** Hook audience in first 30 seconds
2. **Eye contact:** Look at audience, not slides
3. **Pace:** Speak slowly and clearly
4. **Pause:** Give time for points to land
5. **Energy:** Show enthusiasm for your topic

### Handling Q&A
1. **Listen:** Fully understand the question
2. **Clarify:** Repeat or rephrase if needed
3. **Answer:** Be concise and direct
4. **Defer:** If you don't know, offer to follow up
5. **Time:** Keep answers brief to get more questions

---

## Slide Deck Examples

### Example 1: Design Review Presentation

**Slide 1: Title**
```
Real-Time Notification System
Design Review

Presented by: @engineering-team
Date: November 14, 2025
```

**Slide 2: Agenda**
```
1. Problem & Requirements (5 min)
2. Proposed Architecture (10 min)
3. Technical Deep Dive (15 min)
4. Trade-offs & Alternatives (5 min)
5. Implementation Plan (5 min)
6. Q&A (10 min)
```

**Slide 3: Problem**
```
Current Notification System

Problems:
- 15-minute email delay (batch processing)
- No push notifications for mobile
- Users miss time-sensitive updates
- Impacts engagement by 25%

Goal: <1 second delivery for 99.9% of users
```

**Slide 4: Solution Overview**
```
Event-Driven Real-Time Architecture

[Diagram: Client -> API -> Queue -> Workers -> Push/Email/WebSocket]

Benefits:
- Sub-second delivery
- Reliable retry mechanism
- Scales to 10M users
```

**Slide 5: Architecture**
```
[Detailed architecture diagram]

Key Components:
- Notification Service (Node.js)
- Message Queue (SQS)
- Push Provider (FCM/APNS)
- WebSocket Server (Socket.io)
```

**Slide 6-10: Technical Details**
```
[One slide per component with tech stack, data models, API examples]
```

**Slide 11: Metrics**
```
Success Criteria

| Metric | Target | Measurement |
|--------|--------|-------------|
| Delivery Time (P99) | <1s | CloudWatch |
| Success Rate | >99.5% | App metrics |
| Throughput | 10K/sec | SQS metrics |
```

**Slide 12: Timeline**
```
8-Week Implementation

Week 1-3: MVP (Push notifications)
Week 4-5: Web support (WebSocket)
Week 6-7: Advanced features
Week 8: Launch & monitoring
```

**Slide 13: Next Steps**
```
Action Items:
1. Approval from architecture team
2. Create Jira tickets
3. Set up development environment
4. Begin Phase 1

Timeline: Start next week
```

---

### Example 2: RFC Presentation

**Slide 1: Title**
```
RFC-042: GraphQL API Migration
From REST to GraphQL

Author: @backend-team
Status: Open for Comments
```

**Slide 2: Problem**
```
REST API Challenges

- Over-fetching (mobile bandwidth waste)
- Under-fetching (multiple requests needed)
- 20+ endpoints (hard to maintain)
- Breaking changes impact clients
- No type safety

Impact: Slows feature development by 30%
```

**Slide 3: Proposed Solution**
```
Migrate to GraphQL

Benefits:
- Clients fetch exactly what they need
- Single endpoint
- Strong typing
- Better developer experience
- Introspection & tooling
```

**Slide 4: Example Comparison**
```
REST (3 requests):
GET /users/123
GET /users/123/posts
GET /posts/456/comments

GraphQL (1 request):
query {
  user(id: "123") {
    name
    posts {
      title
      comments { text }
    }
  }
}
```

**Slide 5: Architecture**
```
[Diagram showing GraphQL layer over existing services]

Implementation:
- Apollo Server
- Existing REST services as data sources
- Gradual migration
```

**Slide 6: Migration Plan**
```
3-Phase Approach

Phase 1: Add GraphQL alongside REST (4 weeks)
Phase 2: Migrate clients to GraphQL (8 weeks)
Phase 3: Deprecate REST endpoints (4 weeks)

Total: 16 weeks
```

**Slide 7: Risks & Mitigations**
```
| Risk | Mitigation |
|------|------------|
| Learning curve | Training & docs |
| Performance | Caching strategy |
| N+1 queries | DataLoader |
| Breaking changes | Versioning |
```

**Slide 8: Decision Needed**
```
Questions for Review:

1. Approve GraphQL migration?
2. Timeline acceptable?
3. Resource allocation OK?

Next: Vote by Friday, start Monday
```

---

### Example 3: Sprint Demo

**Slide 1: Title**
```
Sprint 23 Demo
Payment Integration

Team: @payments-team
Sprint: Nov 1-14, 2025
```

**Slide 2: Sprint Goals**
```
Completed:
✅ Stripe integration
✅ Payment processing flow
✅ Refund functionality

In Progress:
🔄 Subscription billing (next sprint)
```

**Slide 3: Demo**
```
[Live demo or video]

Features:
- Credit card payments
- Real-time validation
- Receipt generation
- Refund processing
```

**Slide 4: Technical Highlights**
```
Key Implementation Details:

- Idempotency keys for reliability
- Webhook handling for async updates
- PCI compliance (tokenization)
- Comprehensive error handling
```

**Slide 5: Metrics**
```
Performance:

- Payment processing: 2.3s avg
- Success rate: 99.7%
- Error recovery: 100%
- Test coverage: 94%
```

**Slide 6: Next Sprint**
```
Sprint 24 Goals:

1. Subscription billing
2. Payment methods management
3. Invoice generation
4. Analytics dashboard

Timeline: Nov 15-28
```

---

## Tools and Resources

### Presentation Software
- **Google Slides:** Collaborative, cloud-based
- **Keynote:** Mac users, beautiful templates
- **PowerPoint:** Traditional, widely used
- **Pitch:** Modern, design-focused
- **Figma:** Design tool, great for technical presentations

### Diagram Tools
- **Mermaid:** Code-based diagrams
- **Excalidraw:** Hand-drawn style
- **Lucidchart:** Professional diagramming
- **Draw.io:** Free, powerful
- **Figma:** Design and diagrams

### Code Screenshots
- **Carbon:** Beautiful code screenshots
- **Ray.so:** Code screenshots with backgrounds
- **Snappify:** Code snippets for presentations

### Stock Images
- **Unsplash:** Free high-quality photos
- **Pexels:** Free stock photos
- **Undraw:** Free illustrations

### Icons
- **Heroicons:** Simple, clean icons
- **Feather Icons:** Minimal icons
- **Font Awesome:** Comprehensive icon set

---

## Common Mistakes to Avoid

### ❌ Too Much Text
Slides become unreadable when packed with text. Use bullet points and images.

### ❌ Tiny Font Size
Font smaller than 24pt is hard to read. Use 32-44pt for body, 54pt+ for headings.

### ❌ Reading Slides Verbatim
Audience can read. Use slides as visual aids, add value with your narration.

### ❌ Complex Diagrams
If it takes 2 minutes to understand, it's too complex. Simplify or break into multiple slides.

### ❌ No Narrative Flow
Each slide should naturally lead to the next. Tell a story.

### ❌ Ignoring Time Limits
Practice with a timer. Aim for 1-2 minutes per slide.

### ❌ No Backup Plan
Demos fail. Have screenshots or videos as backup.

### ❌ Ending Abruptly
Always have a clear conclusion and call-to-action.

---

## Accessibility Considerations

### Color Blindness
- Don't rely solely on color to convey meaning
- Use patterns or labels in addition to colors
- Test with color blindness simulators

### Font Readability
- Use sans-serif fonts (Arial, Helvetica, Calibri)
- Minimum 24pt font size
- High contrast between text and background

### Alternative Text
- Provide alt text for images
- Describe diagrams verbally
- Share detailed notes separately

---

## Post-Presentation

### Follow-Up
1. **Share slides:** Provide access to deck
2. **Send notes:** Summary of key points
3. **Action items:** List next steps and owners
4. **Recording:** Share if available
5. **Q&A:** Answer deferred questions

### Gather Feedback
- Survey attendees
- Ask for improvement suggestions
- Iterate for next time

### Document Decisions
- Record any decisions made
- Update related documentation
- Notify relevant stakeholders
