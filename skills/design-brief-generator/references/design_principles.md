# Design Principles

A comprehensive guide to establishing and applying design principles for your projects.

---

## What Are Design Principles?

Design principles are foundational guidelines that inform design decisions and help teams create consistent, purposeful user experiences. They serve as:

- **Decision-making tools** - When faced with trade-offs
- **Alignment mechanisms** - Keep teams on the same page
- **Communication shortcuts** - Express complex ideas quickly
- **Quality filters** - Evaluate if designs meet standards

**Key characteristic:** Good principles are opinionated and help you say "no" to things that don't align.

---

## Characteristics of Effective Design Principles

### 1. Specific, Not Generic
❌ **Bad:** "Keep it simple"
✅ **Good:** "Show one primary action per screen"

### 2. Opinionated
❌ **Bad:** "Design should be accessible"
✅ **Good:** "Accessibility is non-negotiable - WCAG AA minimum"

### 3. Memorable
- Short and punchy
- Easy to remember
- Ideally 3-7 principles total

### 4. Actionable
- Clear enough to guide decisions
- Can be applied in practice
- Include examples of application

### 5. Authentic to Your Product
- Reflect your unique approach
- Not copied from others
- Based on your users and context

---

## Types of Design Principles

### 1. Product-Level Principles
**Scope:** Entire product or company
**Duration:** Years
**Examples:**
- Google Material Design: "Motion provides meaning"
- Apple HIG: "Depth creates hierarchy and focus"
- Shopify Polaris: "Merchants first"

### 2. Project-Level Principles
**Scope:** Specific feature or initiative
**Duration:** Weeks to months
**Examples:**
- "Mobile-first for this redesign"
- "Progressive disclosure over feature parity"
- "Speed trumps beauty for this dashboard"

### 3. Brand Principles
**Scope:** Visual and tonal identity
**Duration:** Years
**Examples:**
- "Bold but not overwhelming"
- "Playful but professional"
- "Technical but approachable"

---

## Framework: Creating Design Principles

### Step 1: Understand Your Context

**Research questions:**
- Who are our users?
- What are their core needs?
- What makes our product unique?
- What do we want to be known for?
- What trade-offs do we commonly face?

**Gather input from:**
- User research findings
- Stakeholder interviews
- Competitive analysis
- Brand strategy
- Product vision

### Step 2: Identify Themes

**Look for patterns:**
- Repeated design challenges
- Common user feedback
- Successful design decisions
- Team values and culture
- Competitive advantages

**Common themes:**
- Simplicity vs. power
- Speed vs. features
- Guidance vs. flexibility
- Innovation vs. familiarity
- Delight vs. efficiency

### Step 3: Draft Principles

**Format options:**

**1. Statement + Explanation**
```
Principle: Progressive disclosure
We show complexity only when needed, starting with
the simplest path and revealing advanced features
as users need them.
```

**2. Principle + Sub-points**
```
Principle: Speed is a feature

- Optimize for p95 latency < 200ms
- Perceived performance > actual performance
- Never block user interactions
```

**3. Opposites**
```
Clarity over cleverness
We prefer obvious solutions over creative ones
that require explanation.
```

### Step 4: Test & Refine

**Validation questions:**
- Can we apply this to real design decisions?
- Does it help us choose between options?
- Is it specific to our product?
- Can we explain it in 30 seconds?
- Does the team agree?

**Test with scenarios:**
- Take recent design decisions
- Apply principles retroactively
- Do they guide toward the right choice?
- Refine based on results

### Step 5: Document & Evangelize

**Documentation should include:**
- Principle statement
- Explanation (1-2 paragraphs)
- Real examples (with images)
- Anti-examples (what to avoid)
- When to apply/not apply

---

## Example Design Principles

### Product: Slack

**1. Work hard at being easy**
Surface the rich capabilities of Slack with progressive disclosure—make the basics easy to understand and the advanced features easy to find.

**2. Empowering, not clever**
Clarity and usefulness, rather than cleverness, should be our guiding light. We should delight people with ease of use, not tricks.

**3. Courtesy and respect**
We're mindful of the language and tone in both the product and our communication. We strive for a friendly, supportive voice.

---

### Product: Airbnb

**1. Unified**
Every part of Airbnb is part of a greater whole. Design cohesively across platforms, features, and touch-points.

**2. Universal**
Airbnb is used by millions around the world. Make sure your designs scale across cultures and contexts.

**3. Iconic**
Our interfaces should be instantly recognizable. Leverage consistency and focus to create memorable moments.

**4. Conversational**
Our voice is friendly and straightforward. Guide users with clarity and warmth.

---

### Product: GOV.UK

**1. Start with user needs**
Service design starts with identifying user needs. If you don't know what the user needs are, you won't build the right thing.

**2. Do less**
Government should only do what only government can do. If someone else is doing it, we should point to them.

**3. Design with data**
In most cases, we can learn from real-world behavior by looking at how existing services are used. Let data drive decision-making.

**4. Do the hard work to make it simple**
Making something look simple is easy. Making something simple to use is much harder.

**5. Iterate. Then iterate again**
The best way to build good services is to start small and iterate wildly.

---

## Common Design Principle Patterns

### Simplicity & Clarity

**Patterns:**
- "Simple over clever"
- "Clarity is paramount"
- "Progressive disclosure"
- "One primary action per screen"
- "Remove, then simplify"

**When to use:**
- Complex enterprise software
- Products with steep learning curves
- Designing for novice users

**Example application:**
- Dashboard shows 3 key metrics, not 20
- Single CTA per page
- Hide advanced settings in preferences

---

### Speed & Performance

**Patterns:**
- "Speed is a feature"
- "Instant feedback"
- "Optimistic UI updates"
- "Perceived performance matters"

**When to use:**
- Real-time applications
- Mobile-first products
- High-frequency user actions

**Example application:**
- Show loading states immediately
- Update UI before server confirms
- Preload likely next steps

---

### User Empowerment

**Patterns:**
- "Users in control"
- "Provide escape hatches"
- "No dead ends"
- "Make destructive actions reversible"

**When to use:**
- Professional tools
- Content creation apps
- Complex workflows

**Example application:**
- Undo for all actions
- Multiple ways to accomplish tasks
- Clear exit paths from flows

---

### Consistency & Predictability

**Patterns:**
- "Familiar over novel"
- "Consistency creates trust"
- "Follow platform conventions"
- "Don't reinvent the wheel"

**When to use:**
- Enterprise software
- Products spanning platforms
- Established design systems

**Example application:**
- Use platform-native components
- Maintain interaction patterns
- Consistent terminology

---

### Delight & Personality

**Patterns:**
- "Personality without distraction"
- "Delight in details"
- "Human, not robotic"
- "Make it fun"

**When to use:**
- Consumer products
- Creative tools
- Brand-driven experiences

**Example application:**
- Microinteractions
- Playful empty states
- Friendly error messages
- Celebratory animations

---

## Applying Principles to Decisions

### Decision Framework

When facing a design choice:

1. **Identify the trade-off**
   - What are the options?
   - What does each optimize for?

2. **Consult principles**
   - Which principles apply?
   - What do they suggest?

3. **Make the call**
   - Principle-aligned decision
   - Document reasoning

4. **Validate**
   - Does it feel right?
   - Can you defend it?

### Example Decision Process

**Scenario:** Should we add a feature request form in-app or direct users to a forum?

**Options:**
- A: In-app form (more convenient)
- B: Public forum (builds community)

**Principles:**
- "Community-driven development"
- "Transparent by default"

**Decision:** Option B (forum) aligns better with principles of community and transparency.

---

## Principle Templates

### Template 1: Statement + Rationale
```markdown
## [Principle Name]

[One sentence principle statement]

**Why this matters:**
[1-2 paragraphs explaining the reasoning]

**In practice:**
- [Example 1]
- [Example 2]
- [Example 3]

**Not this:**
[Anti-example with explanation]
```

### Template 2: Principle Pairs
```markdown
## [This] over [That]

We prioritize [this] over [that] because [reasoning].

**Example:**
When [scenario], we choose to [action] rather than
[alternative action] because it better serves [user need].
```

### Template 3: Question Format
```markdown
## [Question as principle]

[Answer and explanation]

**How to apply:**
Ask yourself: [guiding question]
If yes: [recommendation]
If no: [alternative recommendation]
```

---

## Project-Specific Principles: Examples

### E-commerce Redesign

1. **Speed drives conversion**
   - p95 load time < 2 seconds
   - Optimize images aggressively
   - Progressive enhancement

2. **Trust before transaction**
   - Show reviews prominently
   - Clear pricing (no surprises)
   - Visible security signals

3. **Mobile-first, always**
   - Design for small screens
   - Touch targets 44px+
   - One-handed navigation

---

### Enterprise Dashboard

1. **Data density with clarity**
   - Show relevant data, hide noise
   - Progressive disclosure for details
   - Scannable at a glance

2. **Customization without complexity**
   - Smart defaults for 80% of users
   - Power features for the 20%
   - Save personal preferences

3. **Actionable insights**
   - Every chart suggests an action
   - Highlight anomalies
   - Clear next steps

---

### Developer Tool

1. **Documentation first**
   - Inline code examples
   - Self-documenting APIs
   - Error messages that teach

2. **Powerful defaults, maximum flexibility**
   - Work out-of-box
   - Expose all config options
   - Follow principle of least surprise

3. **Speed matters**
   - Fast by default
   - Show performance metrics
   - Optimize for developer velocity

---

## Anti-Patterns to Avoid

### ❌ Too Generic
"Make it user-friendly"
- Applies to everything
- Doesn't guide decisions
- Basically useless

### ❌ Too Prescriptive
"Always use blue buttons"
- Too specific
- Becomes a rule, not a principle
- Limits creativity

### ❌ Too Many Principles
Having 15+ principles
- Can't remember them
- Dilutes focus
- Slows decisions

### ❌ Contradictory Principles
"Move fast" + "Pixel-perfect polish"
- Confuses priorities
- Can't both be true
- Leads to inconsistency

### ❌ Aspirational but Not Authentic
Copying Apple's principles for your B2B SaaS
- Doesn't fit your context
- Team won't believe it
- Won't guide real decisions

---

## Maintaining Design Principles

### Regular Review

**Quarterly check:**
- Are we following them?
- Do they still apply?
- Should we refine them?

**Annual revision:**
- Major product changes
- New company direction
- Market shifts

### Evangelization

**Onboarding:**
- Introduce principles to new team members
- Explain with real examples
- Show how they're applied

**Design reviews:**
- Reference principles explicitly
- Call out misalignments
- Celebrate when followed well

**Documentation:**
- Include in design system
- Show in component examples
- Link from design files

---

## Principle Checklist for Design Briefs

When creating project-specific principles:

- [ ] **Based on research** - Grounded in user needs
- [ ] **Specific to project** - Not generic platitudes
- [ ] **Actionable** - Can guide real decisions
- [ ] **Memorable** - Team can recall without looking
- [ ] **3-5 principles** - Not too many
- [ ] **Not contradictory** - Work together
- [ ] **Include examples** - Show how to apply
- [ ] **Team alignment** - Everyone agrees
- [ ] **Documented** - Written in brief
- [ ] **Referenced** - Used in reviews

---

## Resources

### Books
- "Designing with Principles" - Ben Brignell
- "The Design of Everyday Things" - Don Norman
- "Don't Make Me Think" - Steve Krug

### Articles
- [Design Principles FTW](https://www.designprinciplesftw.com/) - Collection of principles
- [Creating Design Principles](https://alistapart.com/article/design-principles/) - A List Apart
- [Bad Design Principles](https://www.smashingmagazine.com/2010/04/bad-design-principles/) - Smashing Magazine

### Examples
- [Material Design Principles](https://material.io/design/introduction)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [Salesforce Lightning Principles](https://www.lightningdesignsystem.com/)
- [Atlassian Design Principles](https://atlassian.design/foundations/design-principles)

---

## Template: Document Your Principles

```markdown
# [Project Name] Design Principles

## Overview
These principles guide design decisions for [project].
When faced with trade-offs, these help us choose the right path.

---

## 1. [Principle Name]

**Statement:**
[One clear sentence]

**Why this matters:**
[Explanation of rationale - 2-3 sentences]

**In practice:**
✅ **Do this:**
- [Specific example]
- [Specific example]

❌ **Not this:**
- [Anti-example]
- [Anti-example]

**Example:**
[Real example from the project, ideally with image]

---

## 2. [Principle Name]

[Repeat structure]

---

## When to Apply These Principles

These principles apply to:
- [Context 1]
- [Context 2]

These principles may not apply when:
- [Exception 1]
- [Exception 2]

---

## Decision Framework

When facing a design choice:
1. Identify the trade-off
2. Consult relevant principles
3. Make principle-aligned decision
4. Document reasoning

---

## Examples of Principles in Action

### Decision 1: [Description]
**Options:** A or B
**Principle:** [Which principle applies]
**Decision:** [What we chose and why]

### Decision 2: [Description]
[Repeat structure]
```

---

## Quick Tips

1. **Start broad, refine narrow** - Draft many, pick few
2. **Test with real scenarios** - Do they actually help?
3. **Get team buy-in** - Collaborative > dictated
4. **Show, don't just tell** - Use examples
5. **Evolve over time** - Principles aren't permanent
6. **Make them visible** - Post in design files, Slack, etc.
7. **Use in reviews** - "Does this align with principle X?"

---

**Remember:** Design principles should make decisions easier, not harder. If a principle doesn't help you choose, refine or remove it.
