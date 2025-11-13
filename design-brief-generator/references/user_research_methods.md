# User Research Methods

Comprehensive guide to user research methods for design projects.

---

## Why User Research Matters

**Reduces risk:** Validate assumptions before building
**Saves time:** Fix issues before development
**Builds empathy:** Understand users deeply
**Drives decisions:** Data-informed design choices
**Increases success:** Solutions that actually work

**Rule:** The cost of fixing a problem increases 10x at each stage (design → development → post-launch)

---

## When to Use Which Method

### Discovery Phase (Understanding)
**Goal:** Learn about users, their context, and needs

**Methods:**
- User interviews
- Contextual inquiry
- Diary studies
- Surveys
- Analytics review

**Questions answered:**
- Who are our users?
- What are their goals?
- What problems do they face?
- How do they currently solve this?

---

### Exploration Phase (Ideation)
**Goal:** Generate and evaluate design directions

**Methods:**
- Co-design workshops
- Card sorting
- Concept testing
- Competitive analysis
- Design critiques

**Questions answered:**
- What solutions might work?
- How should we organize information?
- What do users expect?
- What works elsewhere?

---

### Validation Phase (Testing)
**Goal:** Evaluate specific designs before development

**Methods:**
- Usability testing
- Prototype testing
- A/B testing
- First-click tests
- Tree testing

**Questions answered:**
- Can users complete tasks?
- Where do they struggle?
- What works well?
- Which version performs better?

---

### Measurement Phase (Optimization)
**Goal:** Understand performance and iterate

**Methods:**
- Analytics analysis
- Heatmaps
- Session recordings
- Surveys (post-use)
- A/B testing

**Questions answered:**
- How are users actually using it?
- Where do they drop off?
- What's working vs. not?
- How can we improve?

---

## Research Methods Guide

### 1. User Interviews

**What:** One-on-one conversations with users

**When to use:**
- Discovery phase
- Understanding motivations
- Complex topics needing depth
- Building empathy

**Duration:** 30-60 minutes per interview

**Participants:** 5-8 users per user segment

**Format:**
- Semi-structured (planned questions with flexibility)
- Open-ended questions
- Follow-up probes

**Sample questions:**
- "Tell me about a time when..."
- "What were you trying to accomplish?"
- "How did that make you feel?"
- "What would make this better?"

**Best practices:**
- Start broad, get specific
- Ask "why" 5 times
- Listen more than talk
- Avoid leading questions
- Record (with permission)

**Deliverables:**
- Interview transcripts
- Key findings summary
- Quotes and themes
- User journey maps

---

### 2. Contextual Inquiry

**What:** Observing users in their environment

**When to use:**
- Understanding workflows
- Physical context matters
- Complex processes
- B2B/enterprise products

**Duration:** 1-3 hours per session

**Participants:** 3-6 users

**Format:**
- Observe users in natural environment
- Ask questions as they work
- Minimal interruption
- Take photos/notes

**Four principles:**
1. **Context:** Go to the user's environment
2. **Partnership:** User and researcher collaborate
3. **Interpretation:** Develop shared understanding
4. **Focus:** Guide based on research questions

**Best practices:**
- Master-apprentice model
- Think-aloud protocol
- Photograph artifacts
- Note workarounds
- Ask about exceptions

**Deliverables:**
- Observation notes
- Photos of workspace/tools
- Workflow diagrams
- Pain points and opportunities

---

### 3. Surveys

**What:** Quantitative data from many users

**When to use:**
- Large sample sizes needed
- Measuring satisfaction
- Prioritizing features
- Demographic data

**Duration:** 5-10 minutes (completion time)

**Participants:** 100+ for statistical significance

**Types of questions:**
- Multiple choice
- Likert scales (1-5 rating)
- Ranking
- Open-ended (limit to 1-2)

**Best practices:**
- Keep it short (< 10 questions)
- One question per page
- Avoid bias in wording
- Test before sending
- Incentivize completion

**Common formats:**
- NPS (Net Promoter Score)
- CSAT (Customer Satisfaction)
- SUS (System Usability Scale)
- Custom satisfaction surveys

**Deliverables:**
- Response data
- Statistical analysis
- Charts and visualizations
- Key findings report

---

### 4. Usability Testing

**What:** Users attempt tasks with your design

**When to use:**
- Validating designs
- Finding usability issues
- Comparing design options
- Pre-launch validation

**Duration:** 45-60 minutes per session

**Participants:** 5 users per user type
- Nielsen Norman: 5 users find 85% of issues

**Format:**
1. Introduction
2. Background questions
3. Task scenarios (3-5 tasks)
4. Post-task questions
5. Debrief

**Task example:**
"You need to update your credit card information. Show me how you would do that."

**Best practices:**
- Test with prototype or real product
- Think-aloud protocol
- Don't help or lead
- Note time to completion
- Record screen + audio
- Use realistic scenarios

**Metrics to track:**
- Task success rate
- Time on task
- Errors made
- Satisfaction rating

**Deliverables:**
- Usability issues (with severity)
- Task success rates
- Video highlights
- Recommendations

---

### 5. A/B Testing

**What:** Compare two versions with real users

**When to use:**
- Optimizing designs
- Data-driven decisions
- High-traffic pages
- Incremental improvements

**Duration:** 1-4 weeks (until statistical significance)

**Participants:** Varies (need large enough sample)

**Format:**
- Version A (control)
- Version B (variant)
- Randomly assign users
- Measure conversion

**Statistical requirements:**
- Sample size calculator
- 95% confidence level
- 80% statistical power
- Account for baseline conversion

**Best practices:**
- Test one variable at a time
- Run until statistically significant
- Consider external factors (holidays, etc.)
- Don't stop test early
- Account for novelty effect

**Tools:**
- Optimizely
- Google Optimize
- VWO
- Custom implementation

**Deliverables:**
- Winning variant
- Conversion lift
- Statistical confidence
- Implementation recommendation

---

### 6. Card Sorting

**What:** Users organize content into categories

**When to use:**
- Information architecture
- Navigation design
- Taxonomy creation
- Menu structure

**Duration:** 20-30 minutes per session

**Participants:** 15-30 for reliable patterns

**Types:**

**Open card sort:**
- Users create their own categories
- Discovers mental models
- Use early in design

**Closed card sort:**
- Users sort into predefined categories
- Validates existing structure
- Use later in design

**Format:**
1. Give users cards with content items
2. Ask them to group related items
3. Ask them to name groups
4. Analyze patterns

**Tools:**
- Optimal Workshop
- UserZoom
- Miro (remote)
- Physical cards (in-person)

**Deliverables:**
- Dendrogram (similarity matrix)
- Common groupings
- Category names
- IA recommendations

---

### 7. Tree Testing

**What:** Users find content in text-only hierarchy

**When to use:**
- Testing information architecture
- Before visual design
- Validating navigation
- After card sorting

**Duration:** 10-15 minutes

**Participants:** 50+ for statistical significance

**Format:**
1. Present text-only site structure
2. Give user a task
3. User clicks through structure
4. Measure success and path

**Metrics:**
- Success rate
- Directness (optimal path?)
- Time taken
- First click

**Best practices:**
- Test before visual design
- 5-10 tasks
- Realistic task scenarios
- Don't test too deep (3-4 levels)

**Tools:**
- Optimal Workshop
- Treejack
- UserZoom

**Deliverables:**
- Success rates per task
- Problem areas
- Recommended structure changes
- Piecharts showing paths taken

---

### 8. Diary Studies

**What:** Users log experiences over time

**When to use:**
- Long-term behavior
- Infrequent events
- Context switching
- Habitual use

**Duration:** 3-14 days

**Participants:** 10-20 users

**Format:**
- Users log entries daily
- Photo + text entries
- Structured prompts
- Follow-up interview

**Prompts example:**
- "When did you use [product] today?"
- "What were you trying to do?"
- "Photo of where you were"
- "What worked/didn't work?"

**Best practices:**
- Keep it lightweight
- Daily reminders
- Incentivize completion
- Follow up with interview

**Tools:**
- dscout
- Indeemo
- Custom forms
- Mobile apps

**Deliverables:**
- Usage patterns over time
- Context of use
- Pain points
- Opportunity areas

---

### 9. Competitive Analysis

**What:** Evaluate competitor products

**When to use:**
- Understanding landscape
- Identifying opportunities
- Benchmarking
- Inspiration

**Duration:** 1-2 weeks

**Competitors to analyze:** 3-5 direct + 2-3 indirect

**Framework:**
1. Identify competitors
2. Define criteria
3. Evaluate each
4. Synthesize findings

**Criteria examples:**
- Features offered
- User experience quality
- Pricing/model
- Visual design
- Performance
- User reviews

**Best practices:**
- Sign up and use products
- Complete key tasks
- Read user reviews
- Screenshot key flows
- Note strengths/weaknesses

**Deliverables:**
- Competitive matrix
- Feature comparison
- UX evaluation
- Screenshots
- Opportunities

---

### 10. Analytics Review

**What:** Analyze quantitative usage data

**When to use:**
- Understanding current behavior
- Identifying issues
- Measuring impact
- Continuous improvement

**Data sources:**
- Google Analytics
- Product analytics (Mixpanel, Amplitude)
- Heatmaps (Hotjar, Crazy Egg)
- Session recordings
- Error logs

**Key metrics:**
- Page views
- Bounce rate
- Time on page
- Conversion rate
- Drop-off points
- Feature adoption

**Best practices:**
- Define questions first
- Look for anomalies
- Segment users
- Combine with qualitative
- Track over time

**Deliverables:**
- Usage dashboard
- Key metrics report
- Problem areas identified
- Hypotheses for testing

---

## Research Planning

### Research Questions

**Bad questions:**
- "Do users like this design?"
- "Is this easy to use?"

**Good questions:**
- "Can users find the checkout button within 10 seconds?"
- "What prevents users from completing signup?"
- "How do users currently manage their projects?"

### Research Plan Template

```markdown
## Research Plan: [Project Name]

### Background
[Why we're doing this research]

### Goals
- [Goal 1]
- [Goal 2]

### Research Questions
1. [Question 1]
2. [Question 2]
3. [Question 3]

### Method
[Which research method(s)]

### Participants
- **Who:** [User segment]
- **Number:** [How many]
- **Recruiting:** [Where/how]
- **Compensation:** [Incentive]

### Timeline
- Planning: [Dates]
- Recruiting: [Dates]
- Sessions: [Dates]
- Analysis: [Dates]
- Reporting: [Dates]

### Deliverables
- [Deliverable 1]
- [Deliverable 2]

### Team
- Researcher: [Name]
- Designer: [Name]
- Note-taker: [Name]
```

---

## Recruiting Participants

### Screening Criteria

**Example screener questions:**

```markdown
1. How often do you [relevant behavior]?
   - Daily (CONTINUE)
   - Weekly (CONTINUE)
   - Monthly (TERMINATE)
   - Never (TERMINATE)

2. What tools do you currently use for [task]?
   - [Competitor A] (CONTINUE)
   - [Competitor B] (CONTINUE)
   - Other: _____ (CONTINUE)
   - None (TERMINATE)

3. What is your role?
   - [Target role] (CONTINUE)
   - Other (TERMINATE)
```

### Recruiting Sources

**Internal:**
- Customer database
- Email campaigns
- In-app recruitment
- Support ticket users

**External:**
- User Interviews (platform)
- Respondent.io
- Ethnio
- Craigslist (with screening)
- Social media

### Incentives

**Typical rates:**
- 30 min interview: $50-75
- 60 min interview: $75-125
- 90 min session: $100-200
- B2B participants: $150-300
- Executives: $300-500

---

## Conducting Research

### Interview Guide Template

```markdown
## [Project] Interview Guide

**Duration:** 60 minutes

### Introduction (5 min)
- Thank you for joining
- Recording with permission
- No right/wrong answers
- Can stop anytime
- Questions before we start?

### Warm-up (5 min)
- Tell me about your role
- Typical day at work
- [Relevant context questions]

### Main Questions (40 min)

**Section 1: Current Behavior**
- Walk me through how you [task]
- What tools do you use?
- What works well?
- What's frustrating?

**Section 2: [Topic]**
- [Questions]

**Section 3: [Topic]**
- [Questions]

### Concept Test (if applicable) (10 min)
- Show prototype/mockup
- What do you see here?
- What would you do first?
- What questions do you have?

### Wrap-up (5 min)
- Anything we didn't cover?
- Final thoughts?
- Thank you + compensation
```

### Facilitation Best Practices

**DO:**
- ✅ Build rapport first
- ✅ Ask open-ended questions
- ✅ Probe deeper ("Tell me more...")
- ✅ Embrace silence
- ✅ Stay neutral
- ✅ Take notes (or have note-taker)

**DON'T:**
- ❌ Lead the witness
- ❌ Explain your design
- ❌ Defend your choices
- ❌ Ask yes/no questions
- ❌ Put words in their mouth
- ❌ Multi-part questions

---

## Analyzing Research

### Affinity Mapping

**Process:**
1. Write observations on sticky notes
2. Group related notes
3. Name themes
4. Identify patterns
5. Prioritize insights

**Tools:**
- Miro
- Mural
- FigJam
- Physical wall + stickies

### Finding Themes

**Look for:**
- Repeated phrases
- Common pain points
- Similar behaviors
- Workarounds
- Strong emotions

**Quotes to capture:**
- Memorable phrases
- Representative of theme
- Emotionally resonant
- Actionable insights

### Prioritizing Insights

**Framework:**
- **Frequency:** How many users mentioned it?
- **Severity:** How big a problem is it?
- **Impact:** How much would solving it help?

**Priority Matrix:**
```
High Impact, High Frequency → P0 (Must fix)
High Impact, Low Frequency → P1 (Should fix)
Low Impact, High Frequency → P2 (Nice to fix)
Low Impact, Low Frequency → P3 (Maybe later)
```

---

## Research Deliverables

### 1. Research Report

**Structure:**
```markdown
# [Project] Research Report

## Executive Summary
- Key findings (3-5 bullets)
- Recommendations (3-5 bullets)

## Background
- Research questions
- Methods
- Participants

## Findings
### Theme 1: [Name]
- Finding
- Evidence (quotes, data)
- Implications

### Theme 2: [Name]
[Repeat]

## Recommendations
1. [Action item with priority]
2. [Action item with priority]

## Next Steps
- [What comes next]

## Appendix
- Full transcripts
- Detailed data
```

### 2. User Personas

**Components:**
- Name and photo
- Demographics
- Goals
- Frustrations
- Behaviors
- Quote
- Scenario

**Keep it:**
- Based on research
- Focused on behaviors
- Referenced in decisions
- Updated regularly

### 3. Journey Maps

**Components:**
- Stages of experience
- User actions
- Thoughts and feelings
- Pain points
- Opportunities

**Format:**
- Timeline across top
- Emotional curve
- Touchpoints
- Behind-the-scenes actions

---

## Research Ethics

### Informed Consent

**Must include:**
- Purpose of research
- What you'll do with data
- Recording disclosure
- Right to stop anytime
- How data will be stored
- Contact information

### Privacy & Data

**Best practices:**
- De-identify data
- Secure storage
- Limited access
- Retention policy
- GDPR/privacy compliance
- Don't share recordings externally

### Participant Wellbeing

**Considerations:**
- Don't cause distress
- Allow breaks
- Respect "I don't know"
- Compensate fairly
- Follow through on promises

---

## Research Checklist for Design Briefs

- [ ] **Research questions** defined
- [ ] **Methods** selected and justified
- [ ] **Participants** criteria specified
- [ ] **Sample size** determined
- [ ] **Timeline** planned
- [ ] **Recruiting** strategy defined
- [ ] **Incentives** budgeted
- [ ] **Interview guide** created
- [ ] **Consent form** prepared
- [ ] **Analysis plan** defined
- [ ] **Deliverables** specified
- [ ] **Stakeholder** review scheduled

---

## Resources

### Books
- "Just Enough Research" - Erika Hall
- "The User Experience Team of One" - Leah Buley
- "Interviewing Users" - Steve Portigal
- "Observing the User Experience" - Goodman, Kuniavsky, Moed

### Tools
- **Recruiting:** User Interviews, Respondent
- **Remote testing:** UserTesting, Lookback, Maze
- **Surveys:** Typeform, Google Forms, Qualtrics
- **Analysis:** Dovetail, Airtable, Notion
- **Card sorting:** Optimal Workshop, UserZoom

### Templates
- [Research Plan Template](https://www.nngroup.com/articles/ux-research-cheat-sheet/)
- [Interview Guide Template](https://userinterviews.com/blog/interview-guide-template)
- [Usability Test Plan](https://www.usability.gov/how-to-and-tools/resources/templates.html)

---

## Quick Reference

### Research Method Selection

| Need | Method | Participants | Duration |
|------|--------|--------------|----------|
| Understand users | Interviews | 5-8 | 30-60 min |
| Observe context | Contextual inquiry | 3-6 | 1-3 hours |
| Large sample | Survey | 100+ | 5-10 min |
| Test usability | Usability test | 5 | 45-60 min |
| Compare options | A/B test | 1000+ | 1-4 weeks |
| Organize content | Card sorting | 15-30 | 20-30 min |
| Test IA | Tree testing | 50+ | 10-15 min |
| Long-term use | Diary study | 10-20 | 3-14 days |
| Competitor insight | Competitive analysis | N/A | 1-2 weeks |
| Usage patterns | Analytics | N/A | Ongoing |

---

**Remember:** Research is not a phase, it's a practice. Build it into every project.
