# Document Templates

Complete templates for common technical documents.

---

## Design Document Template

```markdown
# Design Document: [Feature/System Name]

**Author:** [Your Name] (@username)
**Date:** [YYYY-MM-DD]
**Status:** [Draft | In Review | Approved | Implemented]
**Reviewers:** [@reviewer1, @reviewer2]
**Related Documents:** [Links to related docs]

---

## 1. Overview

### Purpose
[One paragraph: What is this document about?]

### Goals
- [Specific goal 1]
- [Specific goal 2]
- [Specific goal 3]

### Non-Goals
- [What's explicitly out of scope]
- [Future considerations]

### Success Metrics
| Metric | Current | Target | Measurement |
|--------|---------|--------|-------------|
| [Metric 1] | [Value] | [Value] | [How measured] |
| [Metric 2] | [Value] | [Value] | [How measured] |

---

## 2. Background & Context

### Current State
[Describe existing system/solution]

### Problem Statement
[What problem are we solving? Why now?]

### User Stories / Use Cases
- As a [user type], I want to [action] so that [benefit]
- As a [user type], I want to [action] so that [benefit]

---

## 3. Proposed Solution

### High-Level Overview
[2-3 paragraphs describing the solution]

### Architecture Diagram
```mermaid
[Insert architecture diagram]
```

### Key Components
#### [Component 1 Name]
- **Purpose:** [What it does]
- **Technology:** [Tech stack]
- **Responsibilities:** [Key responsibilities]

#### [Component 2 Name]
- **Purpose:** [What it does]
- **Technology:** [Tech stack]
- **Responsibilities:** [Key responsibilities]

---

## 4. Detailed Design

### Data Models
```typescript
interface [ModelName] {
  // Define data structure
}
```

### API Contracts
```http
[HTTP Method] /api/v1/[resource]
[Headers]
[Request body]

Response: [Status Code]
[Response body]
```

### Algorithms / Core Logic
[Explain key algorithms or complex logic]

### Sequence Diagrams
```mermaid
sequenceDiagram
    [Define interactions]
```

---

## 5. Trade-offs & Alternatives

### Alternative 1: [Name]
**Pros:**
- [Pro 1]
- [Pro 2]

**Cons:**
- [Con 1]
- [Con 2]

**Decision:** [Why rejected or chosen]

### Alternative 2: [Name]
[Same structure]

### Key Trade-offs
| Decision | Trade-off | Rationale |
|----------|-----------|-----------|
| [Decision] | [What we give up] | [Why worth it] |

---

## 6. Implementation Plan

### Phase 1: [Name] ([Timeline])
- [ ] [Task 1]
- [ ] [Task 2]
- [ ] [Task 3]

### Phase 2: [Name] ([Timeline])
- [ ] [Task 1]
- [ ] [Task 2]

### Dependencies
- [External dependency 1]
- [External dependency 2]

### Risks & Mitigations
| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| [Risk] | [H/M/L] | [H/M/L] | [How to mitigate] |

---

## 7. Security & Privacy

- **Authentication:** [How users/services authenticate]
- **Authorization:** [Access control mechanism]
- **Data Protection:** [Encryption, PII handling]
- **Compliance:** [GDPR, HIPAA, etc.]
- **Audit Logging:** [What gets logged]

---

## 8. Operational Considerations

### Monitoring & Alerting
- [Metric 1]: Alert if [condition]
- [Metric 2]: Alert if [condition]

### Scaling Strategy
[How system scales with load]

### Disaster Recovery
- **RPO:** [Recovery Point Objective]
- **RTO:** [Recovery Time Objective]
- **Backup Strategy:** [Backup approach]

### Rollout Plan
1. [Step 1]
2. [Step 2]
3. [Step 3]

### Rollback Plan
[How to rollback if needed]

---

## 9. Testing Strategy

### Unit Tests
[Coverage expectations]

### Integration Tests
[Key integration scenarios]

### Performance Tests
[Load testing approach]

### Security Tests
[Security testing approach]

---

## 10. Documentation & Training

- [ ] API documentation
- [ ] User guide
- [ ] Runbook
- [ ] Team training session

---

## 11. Open Questions

- [ ] [Question 1]
- [ ] [Question 2]
- [ ] [Question 3]

---

## 12. References

- [Link 1 - Description]
- [Link 2 - Description]
- [Link 3 - Description]

---

## Appendix

### A. Detailed Calculations
[Any complex calculations or analysis]

### B. Research Notes
[Additional research findings]
```

---

## RFC (Request for Comments) Template

```markdown
# RFC [Number]: [Title]

**Author:** [Your Name] (@username)
**Date:** [YYYY-MM-DD]
**Status:** [Draft | Open for Comments | Accepted | Rejected | Implemented]
**Discussion Thread:** [Link to discussion]
**Approvers:** [@approver1, @approver2]

---

## Summary

[2-3 sentence summary of the proposal]

---

## Motivation

### Problem
[Detailed description of the problem we're solving]

### Impact
- **Who is affected:** [Users, teams, systems]
- **Severity:** [High | Medium | Low]
- **Urgency:** [Why we need to act now]

### Current Workarounds
[How people currently deal with this problem]

---

## Proposed Solution

### Overview
[High-level description of the proposed solution]

### Design
[Detailed design with diagrams, code examples, APIs]

### Example Usage
```typescript
// Show how the solution would be used
```

### Benefits
- [Benefit 1]
- [Benefit 2]
- [Benefit 3]

---

## Detailed Design

### Changes Required
1. [Change 1]
2. [Change 2]
3. [Change 3]

### API / Interface Changes
```typescript
// Before
[Old interface]

// After
[New interface]
```

### Migration Path
[How existing code/data will be migrated]

---

## Drawbacks & Alternatives

### Drawbacks of This Approach
- [Drawback 1]
- [Drawback 2]

### Alternative 1: [Name]
[Description, pros, cons, why not chosen]

### Alternative 2: [Name]
[Description, pros, cons, why not chosen]

### Do Nothing
[Consequences of not addressing the problem]

---

## Adoption Strategy

### Backward Compatibility
[How this maintains compatibility with existing systems]

### Deprecation Strategy
[If deprecating old functionality]

### Communication Plan
- [Who needs to be informed]
- [When and how to communicate]

---

## Implementation Plan

### Estimated Effort
[Person-days or story points]

### Timeline
- **Start Date:** [Date]
- **Target Completion:** [Date]
- **Milestones:** [Key milestones]

### Team & Resources
- **Owner:** [@owner]
- **Contributors:** [@contributor1, @contributor2]
- **Stakeholders:** [@stakeholder1, @stakeholder2]

---

## Success Metrics

How we'll measure success:
- [Metric 1: Target value]
- [Metric 2: Target value]
- [Metric 3: Target value]

---

## Unresolved Questions

- [ ] [Question 1]
- [ ] [Question 2]
- [ ] [Question 3]

---

## Related Work

- [RFC/Design doc 1]
- [Similar implementation elsewhere]
- [Industry standards or prior art]

---

## Changelog

| Date | Change | Author |
|------|--------|--------|
| [Date] | Initial draft | [@author] |
| [Date] | Updated based on feedback | [@author] |
```

---

## ADR (Architecture Decision Record) Template

```markdown
# ADR [Number]: [Short title of decision]

**Date:** [YYYY-MM-DD]
**Status:** [Proposed | Accepted | Deprecated | Superseded by ADR-XXX]
**Deciders:** [@person1, @person2]
**Tags:** [tag1, tag2]

---

## Context

[Describe the context and problem statement. What forces are at play?]

### Technical Story
[Optional: Link to related ticket/story]

---

## Decision

[State the decision that was made. Use active voice: "We will..."]

---

## Consequences

### Positive
- [Good consequence 1]
- [Good consequence 2]
- [Good consequence 3]

### Negative
- [Bad consequence 1]
- [Bad consequence 2]

### Neutral
- [Neutral consequence 1]
- [Neutral consequence 2]

---

## Alternatives Considered

### Option 1: [Name]
[Brief description and why not chosen]

### Option 2: [Name]
[Brief description and why not chosen]

---

## Related Decisions

- [ADR-XXX]: [Related decision]
- [ADR-YYY]: [Related decision]

---

## Notes

[Any additional information]
```

---

## API Documentation Template

```markdown
# [API Name] Documentation

**Version:** v1.0
**Base URL:** `https://api.example.com/v1`
**Last Updated:** [Date]

---

## Overview

[Brief description of what this API does]

---

## Authentication

[Describe authentication mechanism]

```http
Authorization: Bearer <access_token>
```

[How to obtain tokens, token lifetime, refresh mechanism]

---

## Endpoints

### [Resource Name]

#### GET /[resource]

[Description of what this endpoint does]

**Request:**
```http
GET /api/v1/[resource]?param1=value1
Authorization: Bearer <token>
```

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `param1` | string | Yes | [Description] |
| `param2` | integer | No | [Description] |

**Response: 200 OK**
```json
{
  "data": [
    {
      "id": "123",
      "name": "Example"
    }
  ],
  "pagination": {
    "total": 100,
    "page": 1,
    "limit": 20
  }
}
```

**Error Responses:**
| Status | Error Code | Description |
|--------|------------|-------------|
| 400 | `INVALID_PARAM` | Parameter validation failed |
| 401 | `UNAUTHORIZED` | Invalid or expired token |
| 429 | `RATE_LIMIT` | Too many requests |

---

#### POST /[resource]

[Description]

**Request:**
```http
POST /api/v1/[resource]
Authorization: Bearer <token>
Content-Type: application/json

{
  "field1": "value1",
  "field2": "value2"
}
```

**Request Body:**
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `field1` | string | Yes | [Description] |
| `field2` | number | No | [Description] |

**Response: 201 Created**
```json
{
  "id": "456",
  "field1": "value1",
  "field2": "value2",
  "createdAt": "2025-11-14T10:30:00Z"
}
```

---

## Rate Limiting

[Describe rate limits]

| Endpoint | Limit | Window |
|----------|-------|--------|
| [Endpoint] | [Limit] | [Window] |

**Rate Limit Headers:**
```http
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 950
X-RateLimit-Reset: 1699965600
```

---

## Error Handling

All errors follow this format:
```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable message",
    "field": "fieldName",
    "details": {}
  }
}
```

### Common Error Codes
| Code | HTTP Status | Description |
|------|-------------|-------------|
| `INVALID_REQUEST` | 400 | Request validation failed |
| `UNAUTHORIZED` | 401 | Authentication required |
| `FORBIDDEN` | 403 | Insufficient permissions |
| `NOT_FOUND` | 404 | Resource not found |
| `RATE_LIMIT` | 429 | Rate limit exceeded |
| `SERVER_ERROR` | 500 | Internal server error |

---

## Webhooks

[If applicable, describe webhook functionality]

---

## Code Examples

### JavaScript
```javascript
const response = await fetch('https://api.example.com/v1/resource', {
  method: 'GET',
  headers: {
    'Authorization': `Bearer ${token}`,
  },
});

const data = await response.json();
```

### Python
```python
import requests

response = requests.get(
    'https://api.example.com/v1/resource',
    headers={'Authorization': f'Bearer {token}'}
)

data = response.json()
```

### cURL
```bash
curl -X GET https://api.example.com/v1/resource \
  -H "Authorization: Bearer $TOKEN"
```

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| v1.0 | [Date] | Initial release |
```

---

## Post-Mortem Template

```markdown
# Post-Mortem: [Incident Name]

**Date of Incident:** [YYYY-MM-DD]
**Duration:** [X hours/minutes]
**Severity:** [SEV-1 | SEV-2 | SEV-3]
**Author:** [Your Name]
**Participants:** [@person1, @person2]

---

## Executive Summary

[2-3 sentences summarizing the incident, impact, and resolution]

---

## Impact

- **Users Affected:** [Number or percentage]
- **Duration:** [Total downtime]
- **Revenue Impact:** [If applicable]
- **Systems Affected:** [List of systems]
- **Geographic Scope:** [Which regions]

---

## Timeline (All times in [Timezone])

| Time | Event |
|------|-------|
| HH:MM | [First signs of issue] |
| HH:MM | [Alerts triggered] |
| HH:MM | [Team notified] |
| HH:MM | [Investigation began] |
| HH:MM | [Root cause identified] |
| HH:MM | [Fix deployed] |
| HH:MM | [Service restored] |
| HH:MM | [Monitoring confirmed recovery] |

---

## Root Cause

### Technical Cause
[Detailed technical explanation of what went wrong]

### 5 Whys Analysis
1. **Why did [event] happen?** [Answer]
2. **Why did [answer from #1] happen?** [Answer]
3. **Why did [answer from #2] happen?** [Answer]
4. **Why did [answer from #3] happen?** [Answer]
5. **Why did [answer from #4] happen?** [Root cause]

---

## Detection

- **How was it detected:** [Monitoring, user report, etc.]
- **Time to detect:** [Time from start to detection]
- **What worked well:** [Effective detection mechanisms]
- **What could improve:** [Detection gaps]

---

## Response

- **Time to engage:** [Time from detection to team engagement]
- **Time to mitigate:** [Time from engagement to mitigation]
- **Time to resolve:** [Time from engagement to full resolution]

---

## What Went Well

- [Thing that helped during incident]
- [Effective practice or tool]
- [Good decision made]

---

## What Went Wrong

- [Problem during incident response]
- [Gap in process or tooling]
- [Ineffective practice]

---

## Action Items

### Prevent
- [ ] [Action to prevent recurrence] - Owner: [@person] - Due: [Date]
- [ ] [Another preventive action] - Owner: [@person] - Due: [Date]

### Detect
- [ ] [Action to detect faster next time] - Owner: [@person] - Due: [Date]
- [ ] [Monitoring improvement] - Owner: [@person] - Due: [Date]

### Respond
- [ ] [Action to respond faster] - Owner: [@person] - Due: [Date]
- [ ] [Process improvement] - Owner: [@person] - Due: [Date]

### Document
- [ ] [Documentation update] - Owner: [@person] - Due: [Date]

---

## Lessons Learned

- [Key lesson 1]
- [Key lesson 2]
- [Key lesson 3]

---

## Supporting Information

### Logs
[Key log excerpts]

### Metrics/Graphs
[Link to dashboards or embed graphs]

### Related Incidents
- [Previous similar incident]

---

## Follow-up

**Review Date:** [Date]
**Follow-up Owner:** [@person]
```

---

## Runbook Template

```markdown
# Runbook: [Service/Task Name]

**Service:** [Service name]
**Owner:** [@team or @person]
**Last Updated:** [Date]
**On-Call Escalation:** [Link to on-call schedule]

---

## Overview

[Brief description of what this service does and why this runbook exists]

---

## Service Architecture

```mermaid
[Simple architecture diagram]
```

---

## Prerequisites

- Access to [system/tool 1]
- Permissions: [required permissions]
- Tools: [required tools]

---

## Common Tasks

### Task 1: [Task Name]

**When to use:** [Situation]

**Steps:**
1. [Step 1]
   ```bash
   # Command if applicable
   ```
2. [Step 2]
3. [Step 3]

**Expected outcome:** [What should happen]

**If it fails:** [Troubleshooting steps]

---

### Task 2: [Task Name]

[Same structure]

---

## Monitoring & Alerts

### Key Metrics
| Metric | Dashboard | Normal Range | Alert Threshold |
|--------|-----------|--------------|-----------------|
| [Metric 1] | [Link] | [Range] | [Threshold] |
| [Metric 2] | [Link] | [Range] | [Threshold] |

### Alert Response

#### Alert: [Alert Name]
**Severity:** [HIGH | MEDIUM | LOW]
**Description:** [What this alert means]

**Immediate Actions:**
1. [First thing to check]
2. [Second thing to check]

**Resolution Steps:**
1. [Step 1]
2. [Step 2]

**Escalation:** [When and who to escalate to]

---

## Troubleshooting

### Problem: [Common Issue 1]
**Symptoms:**
- [Symptom 1]
- [Symptom 2]

**Diagnosis:**
```bash
# Commands to diagnose
```

**Solution:**
[How to fix]

---

### Problem: [Common Issue 2]
[Same structure]

---

## Emergency Procedures

### Service is Down
1. [Immediate action]
2. [Communication step]
3. [Recovery step]

### Data Loss Suspected
1. [Verification step]
2. [Containment step]
3. [Recovery step]

---

## Deployment

### Standard Deployment
```bash
# Deployment commands
```

### Rollback
```bash
# Rollback commands
```

---

## Configuration

### Environment Variables
| Variable | Purpose | Example |
|----------|---------|---------|
| `VAR_NAME` | [Purpose] | `value` |

### Configuration Files
- Location: [Path]
- Format: [YAML/JSON/etc]
- How to update: [Steps]

---

## Dependencies

| Service | Purpose | Contact |
|---------|---------|---------|
| [Service 1] | [What it provides] | [@team] |
| [Service 2] | [What it provides] | [@team] |

---

## Useful Commands

```bash
# View logs
[command]

# Check service status
[command]

# Restart service
[command]

# View metrics
[command]
```

---

## Links & Resources

- **Service Dashboard:** [Link]
- **Logs:** [Link]
- **Source Code:** [Link]
- **Design Doc:** [Link]
- **On-Call:** [Link]
```

---

## One-Pager Template

```markdown
# [Feature/Project Name]

**Owner:** [@person]
**Status:** [Planning | In Progress | Launched]
**Target Date:** [Date]
**Stakeholders:** [@person1, @person2]

---

## Problem

[2-3 sentences: What problem are we solving?]

---

## Solution

[2-3 sentences: What are we building?]

---

## Why Now

[1-2 sentences: Why is this important right now?]

---

## Success Metrics

- [Metric 1: Target]
- [Metric 2: Target]
- [Metric 3: Target]

---

## Timeline

- **Week 1-2:** [Milestone]
- **Week 3-4:** [Milestone]
- **Week 5-6:** [Launch]

---

## Risks

| Risk | Mitigation |
|------|------------|
| [Risk 1] | [How we'll handle it] |
| [Risk 2] | [How we'll handle it] |

---

## Resources Needed

- [Resource 1]
- [Resource 2]

---

## Open Questions

- [ ] [Question 1]
- [ ] [Question 2]
```
