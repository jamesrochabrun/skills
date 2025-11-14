#!/bin/bash

# Technical Presentation Generator
# Interactive script to create technical slide decks

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎤 Technical Presentation Generator"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Presentation type selection
echo "Select presentation type:"
echo "1) Design Review"
echo "2) RFC Presentation"
echo "3) Sprint Demo"
echo "4) Architecture Overview"
echo "5) Post-Mortem Review"
echo ""
read -p "Enter choice (1-5): " pres_type

# Get presentation details
echo ""
read -p "Presentation title: " title
read -p "Presenter name: " presenter
read -p "Date (YYYY-MM-DD): " date
read -p "Output filename (without extension): " filename

# Generate presentation based on type
case $pres_type in
  1)
    # Design Review
    cat > "${filename}.md" << 'EOF'
# TITLE_PLACEHOLDER

**Design Review**

Presented by: PRESENTER_PLACEHOLDER
Date: DATE_PLACEHOLDER

---

## Agenda

1. Problem & Requirements (5 min)
2. Proposed Solution (5 min)
3. Architecture Overview (10 min)
4. Technical Deep Dive (15 min)
5. Trade-offs & Risks (5 min)
6. Timeline & Next Steps (5 min)
7. Q&A (15 min)

---

## Problem Statement

### Current Situation
- [Pain point 1]
- [Pain point 2]
- [Pain point 3]

### Impact
- [Impact metric 1]
- [Impact metric 2]

**Goal:** [What we're trying to achieve]

---

## Requirements

### Functional Requirements
- [Requirement 1]
- [Requirement 2]
- [Requirement 3]

### Non-Functional Requirements
- **Performance:** [Target]
- **Scale:** [Target]
- **Availability:** [Target]

---

## Proposed Solution

[One sentence summary of the solution]

### Key Benefits
- [Benefit 1]
- [Benefit 2]
- [Benefit 3]

---

## High-Level Architecture

```mermaid
graph TB
    A[Client] --> B[API Gateway]
    B --> C[Service 1]
    B --> D[Service 2]
    C --> E[(Database)]
    D --> E
```

**Key Components:**
- [Component 1]: [Purpose]
- [Component 2]: [Purpose]

---

## Component 1: [Name]

**Technology:** [Tech stack]

**Responsibilities:**
- [Responsibility 1]
- [Responsibility 2]

**Key Decisions:**
- [Decision and rationale]

---

## Component 2: [Name]

**Technology:** [Tech stack]

**Responsibilities:**
- [Responsibility 1]
- [Responsibility 2]

**Key Decisions:**
- [Decision and rationale]

---

## Data Flow

```mermaid
sequenceDiagram
    Client->>API: Request
    API->>Service: Process
    Service->>Database: Store
    Database-->>Service: Success
    Service-->>API: Result
    API-->>Client: Response
```

---

## API Design

**Endpoint:** `POST /api/v1/resource`

```json
{
  "field1": "value1",
  "field2": "value2"
}
```

**Response: 201 Created**
```json
{
  "id": "123",
  "status": "success"
}
```

---

## Data Model

```typescript
interface Resource {
  id: string;
  name: string;
  status: Status;
  createdAt: Date;
  metadata: Record<string, any>;
}

enum Status {
  ACTIVE = 'active',
  INACTIVE = 'inactive'
}
```

---

## Trade-offs

| Decision | Trade-off | Rationale |
|----------|-----------|-----------|
| [Decision 1] | [What we give up] | [Why it's worth it] |
| [Decision 2] | [What we give up] | [Why it's worth it] |

---

## Alternatives Considered

### Option A: [Name]
**Pros:** [Benefits]
**Cons:** [Drawbacks]
**Decision:** Not chosen because [reason]

### Option B: [Name]
**Pros:** [Benefits]
**Cons:** [Drawbacks]
**Decision:** Not chosen because [reason]

---

## Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| [Risk 1] | H/M/L | [How we'll handle it] |
| [Risk 2] | H/M/L | [How we'll handle it] |
| [Risk 3] | H/M/L | [How we'll handle it] |

---

## Success Metrics

| Metric | Current | Target | Timeline |
|--------|---------|--------|----------|
| [Metric 1] | [Value] | [Value] | [When] |
| [Metric 2] | [Value] | [Value] | [When] |
| [Metric 3] | [Value] | [Value] | [When] |

---

## Implementation Timeline

**Phase 1: Foundation** (Weeks 1-2)
- [Task 1]
- [Task 2]

**Phase 2: Core Features** (Weeks 3-4)
- [Task 3]
- [Task 4]

**Phase 3: Launch** (Week 5)
- [Task 5]

---

## Dependencies

**External Dependencies:**
- [Dependency 1]
- [Dependency 2]

**Team Dependencies:**
- [Team 1]: [What we need]
- [Team 2]: [What we need]

---

## Security Considerations

- **Authentication:** [Approach]
- **Authorization:** [Approach]
- **Data Protection:** [Encryption, PII]
- **Compliance:** [GDPR, etc.]

---

## Monitoring & Operations

**Key Metrics:**
- [Metric 1]
- [Metric 2]

**Alerts:**
- [Alert condition 1]
- [Alert condition 2]

**Runbook:** [Link to documentation]

---

## Key Takeaways

1. [Main point 1]
2. [Main point 2]
3. [Main point 3]

---

## Next Steps

**Action Items:**
- [ ] [Action 1] - Owner: [@person]
- [ ] [Action 2] - Owner: [@person]
- [ ] [Action 3] - Owner: [@person]

**Timeline:** Start [date]

---

## Questions?

**Contact:**
- Slack: [#channel]
- Email: [email]
- Doc: [Link to detailed design doc]
EOF
    ;;

  2)
    # RFC Presentation
    cat > "${filename}.md" << 'EOF'
# RFC: TITLE_PLACEHOLDER

Presented by: PRESENTER_PLACEHOLDER
Date: DATE_PLACEHOLDER

---

## Summary

[2-3 sentence summary of what we're proposing]

---

## The Problem

### Current State
[What we have today]

### Pain Points
- [Pain point 1]
- [Pain point 2]
- [Pain point 3]

**Impact:** [Who's affected and how]

---

## Why Now?

[Explain urgency - why we need to address this now]

**Consequences of Waiting:**
- [Consequence 1]
- [Consequence 2]

---

## Proposed Solution

[One paragraph explaining the proposed solution]

---

## Solution Benefits

1. **[Benefit 1]**
   - [Detail 1]
   - [Detail 2]

2. **[Benefit 2]**
   - [Detail 1]
   - [Detail 2]

3. **[Benefit 3]**
   - [Detail 1]
   - [Detail 2]

---

## Example: Before

```typescript
// Current approach
[Show current code/approach]
```

**Problems:**
- [Problem 1]
- [Problem 2]

---

## Example: After

```typescript
// Proposed approach
[Show proposed code/approach]
```

**Improvements:**
- [Improvement 1]
- [Improvement 2]

---

## Technical Design

```mermaid
graph TB
    [Architecture diagram showing the solution]
```

**Key Components:**
- [Component 1]
- [Component 2]

---

## Implementation Details

### Changes Required
1. [Change 1]
2. [Change 2]
3. [Change 3]

### Estimated Effort
- [X weeks/sprints]
- [Y engineers]

---

## Migration Path

**Phase 1:** [Initial step]
**Phase 2:** [Middle step]
**Phase 3:** [Final step]

**Backward Compatibility:** [How we maintain compatibility]

---

## Alternatives Considered

### Option A: [Name]
**Pros:** [Benefits]
**Cons:** [Drawbacks]

### Option B: [Name]
**Pros:** [Benefits]
**Cons:** [Drawbacks]

### Do Nothing
**Cons:** [Why this isn't viable]

---

## Trade-offs

| We Gain | We Give Up | Rationale |
|---------|------------|-----------|
| [Gain 1] | [Cost 1] | [Why worth it] |
| [Gain 2] | [Cost 2] | [Why worth it] |

---

## Risks & Mitigations

| Risk | Likelihood | Mitigation |
|------|------------|------------|
| [Risk 1] | H/M/L | [How we'll handle] |
| [Risk 2] | H/M/L | [How we'll handle] |

---

## Success Metrics

How we'll measure success:

- **Metric 1:** [Target]
- **Metric 2:** [Target]
- **Metric 3:** [Target]

---

## Timeline

```mermaid
gantt
    title Implementation Timeline
    dateFormat  YYYY-MM-DD
    section Phase 1
    Task 1           :2025-01-01, 14d
    section Phase 2
    Task 2           :14d
    section Phase 3
    Task 3           :7d
```

---

## Open Questions

- [ ] [Question 1]
- [ ] [Question 2]
- [ ] [Question 3]

**Need feedback by:** [Date]

---

## Decision Needed

**Approval Required From:**
- [@stakeholder1]
- [@stakeholder2]

**Timeline:**
- Comments due: [Date]
- Decision: [Date]
- Implementation start: [Date]

---

## Questions & Discussion
EOF
    ;;

  3)
    # Sprint Demo
    cat > "${filename}.md" << 'EOF'
# Sprint Demo: TITLE_PLACEHOLDER

**Team:** [@team-name]
**Sprint:** [Sprint number/dates]
**Presenter:** PRESENTER_PLACEHOLDER
**Date:** DATE_PLACEHOLDER

---

## Sprint Goals

### Planned
- [Goal 1] ✅
- [Goal 2] ✅
- [Goal 3] 🔄

### Completed
✅ [Achievement 1]
✅ [Achievement 2]
✅ [Achievement 3]

### Carried Over
🔄 [Item to next sprint]

---

## Feature 1: [Name]

**What we built:**
[1-2 sentences describing the feature]

**Demo:**
[Live demo or video]

---

## Feature 1: User Impact

**Before:**
- [Pain point/limitation]

**After:**
- [Improvement/benefit]

**Metrics:**
- [Metric 1]: [Result]
- [Metric 2]: [Result]

---

## Feature 2: [Name]

**What we built:**
[1-2 sentences describing the feature]

**Demo:**
[Live demo or video]

---

## Technical Highlights

### Architecture
```mermaid
graph LR
    A[Component 1] --> B[New Feature]
    B --> C[Component 2]
```

### Key Implementation Details
- [Technical detail 1]
- [Technical detail 2]
- [Technical detail 3]

---

## Code Example

```typescript
// Interesting code snippet or pattern used
[Show code that demonstrates the solution]
```

**Why this matters:**
- [Explanation]

---

## Challenges & Solutions

### Challenge 1: [Description]
**Solution:** [How we solved it]

### Challenge 2: [Description]
**Solution:** [How we solved it]

---

## Quality Metrics

| Metric | Target | Actual | Status |
|--------|--------|--------|--------|
| Test Coverage | >80% | 87% | ✅ |
| Performance | <200ms | 180ms | ✅ |
| Bug Count | <5 | 3 | ✅ |

---

## What Went Well

- [Success 1]
- [Success 2]
- [Success 3]

**Key Learnings:**
- [Learning 1]
- [Learning 2]

---

## What Could Improve

- [Area for improvement 1]
- [Area for improvement 2]

**Action Items:**
- [ ] [Action 1]
- [ ] [Action 2]

---

## Next Sprint Goals

**Sprint [N+1]:**
1. [Goal 1]
2. [Goal 2]
3. [Goal 3]

**Timeline:** [Start date] - [End date]

---

## Questions?
EOF
    ;;

  4)
    # Architecture Overview
    cat > "${filename}.md" << 'EOF'
# System Architecture: TITLE_PLACEHOLDER

Presented by: PRESENTER_PLACEHOLDER
Date: DATE_PLACEHOLDER

---

## Overview

**System Purpose:**
[1-2 sentences describing what the system does]

**Key Capabilities:**
- [Capability 1]
- [Capability 2]
- [Capability 3]

---

## High-Level Architecture

```mermaid
graph TB
    subgraph "Client Layer"
        A[Web App]
        B[Mobile App]
    end

    subgraph "API Layer"
        C[API Gateway]
    end

    subgraph "Services"
        D[Service 1]
        E[Service 2]
        F[Service 3]
    end

    subgraph "Data Layer"
        G[(Database)]
        H[(Cache)]
    end

    A --> C
    B --> C
    C --> D
    C --> E
    C --> F
    D --> G
    E --> G
    F --> G
    D --> H
    E --> H
```

---

## Component Breakdown

### Client Layer
- **Web App:** [Description and tech stack]
- **Mobile App:** [Description and tech stack]

### API Layer
- **API Gateway:** [Purpose and capabilities]

### Services
- **Service 1:** [Purpose]
- **Service 2:** [Purpose]
- **Service 3:** [Purpose]

### Data Layer
- **Database:** [Type and purpose]
- **Cache:** [Type and purpose]

---

## Service 1: [Name]

**Purpose:** [What it does]

**Technology:**
- Language: [e.g., Node.js]
- Framework: [e.g., Express]
- Database: [e.g., PostgreSQL]

**Key Responsibilities:**
- [Responsibility 1]
- [Responsibility 2]

**Scale:** [e.g., 10K requests/second]

---

## Service 2: [Name]

**Purpose:** [What it does]

**Technology:**
- Language: [e.g., Python]
- Framework: [e.g., FastAPI]
- Database: [e.g., MongoDB]

**Key Responsibilities:**
- [Responsibility 1]
- [Responsibility 2]

**Scale:** [e.g., 5K requests/second]

---

## Data Flow

```mermaid
sequenceDiagram
    Client->>API Gateway: Request
    API Gateway->>Service 1: Route
    Service 1->>Cache: Check cache
    alt Cache hit
        Cache-->>Service 1: Return data
    else Cache miss
        Service 1->>Database: Query
        Database-->>Service 1: Return data
        Service 1->>Cache: Update cache
    end
    Service 1-->>API Gateway: Response
    API Gateway-->>Client: Response
```

---

## Communication Patterns

### Synchronous
- REST APIs for client-server
- gRPC for service-to-service

### Asynchronous
- Message queue: [e.g., RabbitMQ]
- Event stream: [e.g., Kafka]

---

## Data Architecture

### Primary Database
- **Type:** [SQL/NoSQL]
- **Purpose:** [What data]
- **Scale:** [Size/throughput]

### Cache Layer
- **Type:** [e.g., Redis]
- **Purpose:** [What's cached]
- **TTL:** [Cache duration]

---

## Security Architecture

**Authentication:**
- [Method, e.g., JWT]

**Authorization:**
- [Method, e.g., RBAC]

**Data Protection:**
- Encryption at rest: [Method]
- Encryption in transit: [TLS]

---

## Scalability

**Horizontal Scaling:**
- Services: Auto-scaling based on CPU
- Database: Read replicas

**Vertical Scaling:**
- Database: Upgrade instance size

**Caching Strategy:**
- [What's cached and why]

---

## Availability & Reliability

**Target SLA:** 99.9% uptime

**Strategies:**
- Multi-region deployment
- Load balancing
- Health checks
- Circuit breakers
- Retry mechanisms

---

## Monitoring

**Key Metrics:**
- Request rate
- Error rate
- Latency (p50, p95, p99)
- Resource utilization

**Tools:**
- Metrics: [e.g., Prometheus]
- Logs: [e.g., ELK Stack]
- Tracing: [e.g., Jaeger]

---

## Deployment

**Infrastructure:**
- [e.g., Kubernetes on AWS]

**CI/CD:**
- [e.g., GitHub Actions]

**Strategy:**
- Blue-green deployment
- Canary releases

---

## Technology Stack

| Layer | Technology |
|-------|------------|
| Frontend | [e.g., React, TypeScript] |
| API Gateway | [e.g., Kong] |
| Services | [e.g., Node.js, Python] |
| Database | [e.g., PostgreSQL, MongoDB] |
| Cache | [e.g., Redis] |
| Message Queue | [e.g., RabbitMQ] |
| Infrastructure | [e.g., Kubernetes, AWS] |

---

## Key Decisions

### Decision 1: [Technology Choice]
**Rationale:** [Why we chose this]

### Decision 2: [Architecture Pattern]
**Rationale:** [Why we chose this]

---

## Future Roadmap

**Short Term (3 months):**
- [Item 1]
- [Item 2]

**Long Term (6-12 months):**
- [Item 3]
- [Item 4]

---

## Questions?

**Resources:**
- Architecture Doc: [Link]
- API Documentation: [Link]
- Runbooks: [Link]
EOF
    ;;

  5)
    # Post-Mortem Review
    cat > "${filename}.md" << 'EOF'
# Post-Mortem: TITLE_PLACEHOLDER

**Incident Date:** DATE_PLACEHOLDER
**Presenter:** PRESENTER_PLACEHOLDER
**Review Date:** [Today's date]

---

## Executive Summary

**What Happened:**
[2-3 sentences describing the incident]

**Impact:**
- Duration: [X hours]
- Users affected: [Number/percentage]
- Services affected: [List]

---

## Timeline

| Time | Event |
|------|-------|
| 10:00 | [First sign of issue] |
| 10:05 | [Detection] |
| 10:10 | [Team engaged] |
| 10:25 | [Root cause identified] |
| 10:40 | [Fix deployed] |
| 10:50 | [Service restored] |

**Total Duration:** [X minutes/hours]

---

## What Happened

[Detailed explanation of the incident sequence]

1. [Event 1]
2. [Event 2]
3. [Event 3]

---

## Root Cause

**Technical Cause:**
[Detailed technical explanation]

```
[Code, config, or system state that caused the issue]
```

---

## Impact Assessment

### Users
- [Number] users affected
- [Description of user impact]

### Business
- [Revenue/engagement impact]
- [Customer service impact]

### Systems
- [Which systems were affected]
- [Degradation level]

---

## Detection

**How Detected:**
[Monitoring alert, user report, etc.]

**Time to Detect:**
[X minutes from start to detection]

**What Worked:**
- [Effective monitoring]

**What Could Improve:**
- [Detection gaps]

---

## Response

**Time to Engage:** [X minutes]
**Time to Identify:** [X minutes]
**Time to Fix:** [X minutes]
**Time to Verify:** [X minutes]

---

## What Went Well ✅

- [Success 1]
- [Success 2]
- [Success 3]

**Key Strengths:**
- [Process or tool that helped]

---

## What Went Wrong ❌

- [Problem 1]
- [Problem 2]
- [Problem 3]

**Areas for Improvement:**
- [Process or tool gap]

---

## 5 Whys Analysis

1. **Why did [event] happen?**
   [Answer]

2. **Why did [answer from #1] happen?**
   [Answer]

3. **Why did [answer from #2] happen?**
   [Answer]

4. **Why did [answer from #3] happen?**
   [Answer]

5. **Why did [answer from #4] happen?**
   [Root cause]

---

## Action Items: Prevent

- [ ] [Action 1] - Owner: [@person] - Due: [Date]
- [ ] [Action 2] - Owner: [@person] - Due: [Date]
- [ ] [Action 3] - Owner: [@person] - Due: [Date]

**Priority:** HIGH

---

## Action Items: Detect

- [ ] [Monitoring improvement 1] - Owner: [@person] - Due: [Date]
- [ ] [Alert improvement 1] - Owner: [@person] - Due: [Date]

**Priority:** MEDIUM

---

## Action Items: Respond

- [ ] [Process improvement 1] - Owner: [@person] - Due: [Date]
- [ ] [Runbook update 1] - Owner: [@person] - Due: [Date]

**Priority:** MEDIUM

---

## Lessons Learned

1. [Key lesson 1]
2. [Key lesson 2]
3. [Key lesson 3]

---

## Follow-up

**Action Item Review:** [Date]
**Owner:** [@person]

**Related Incidents:**
- [Link to similar past incident]

---

## Questions?
EOF
    ;;

  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
esac

# Replace placeholders
sed -i "s/TITLE_PLACEHOLDER/$title/g" "${filename}.md"
sed -i "s/PRESENTER_PLACEHOLDER/$presenter/g" "${filename}.md"
sed -i "s/DATE_PLACEHOLDER/$date/g" "${filename}.md"

echo ""
echo "✅ Presentation generated: ${filename}.md"
echo ""
echo "Next steps:"
echo "1. Open ${filename}.md in your editor"
echo "2. Fill in the template sections"
echo "3. Add diagrams, code examples, and metrics"
echo "4. Convert to slides:"
echo "   - Copy to Google Slides"
echo "   - Import to PowerPoint"
echo "   - Use Markdown presentation tools (Marp, Reveal.js)"
echo ""
echo "Tips:"
echo "- Keep 1-2 minutes per slide"
echo "- Use visuals over text"
echo "- Practice with a timer"
echo ""
