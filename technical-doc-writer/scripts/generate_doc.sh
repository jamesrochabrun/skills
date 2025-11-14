#!/bin/bash

# Technical Document Generator
# Interactive script to generate different types of technical documents

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📝 Technical Document Generator"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Document type selection
echo "Select document type:"
echo "1) Design Document"
echo "2) RFC (Request for Comments)"
echo "3) ADR (Architecture Decision Record)"
echo "4) API Documentation"
echo "5) Post-Mortem"
echo "6) Runbook"
echo "7) One-Pager"
echo ""
read -p "Enter choice (1-7): " doc_type

# Get document details
echo ""
read -p "Document title: " title
read -p "Author name: " author
read -p "Project/feature name: " project

# Generate document based on type
case $doc_type in
  1)
    doc_name="design-doc-$(echo $project | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
    cat > "${doc_name}.md" << 'EOF'
# Design Document: TITLE_PLACEHOLDER

**Author:** AUTHOR_PLACEHOLDER
**Date:** DATE_PLACEHOLDER
**Status:** Draft
**Reviewers:** [@reviewer1, @reviewer2]

---

## 1. Overview

### Purpose
[What is this document about? What problem are we solving?]

### Goals
- [Specific, measurable goal 1]
- [Specific, measurable goal 2]
- [Specific, measurable goal 3]

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
[Describe the existing system or solution. What do we have today?]

### Problem Statement
[What specific problem are we solving? Why is this important? Why now?]

### User Stories / Use Cases
- As a [user type], I want to [action] so that [benefit]
- As a [user type], I want to [action] so that [benefit]

---

## 3. Proposed Solution

### High-Level Overview
[2-3 paragraphs describing the proposed solution at a high level]

### Architecture Diagram
```mermaid
graph TB
    A[Component 1] --> B[Component 2]
    B --> C[Component 3]
```

### Key Components
#### Component 1
- **Purpose:** [What it does]
- **Technology:** [Tech stack]
- **Responsibilities:** [Key responsibilities]
- **Scale:** [Expected load]

#### Component 2
- **Purpose:** [What it does]
- **Technology:** [Tech stack]
- **Responsibilities:** [Key responsibilities]
- **Scale:** [Expected load]

---

## 4. Detailed Design

### Data Models
```typescript
interface ModelName {
  id: string;
  // Define data structure
}
```

### API Contracts
```http
POST /api/v1/resource
Content-Type: application/json

{
  "field": "value"
}

Response: 200 OK
{
  "id": "123",
  "field": "value"
}
```

### Algorithms / Core Logic
[Explain any complex algorithms or business logic]

### Sequence Diagrams
```mermaid
sequenceDiagram
    participant A
    participant B
    A->>B: Request
    B-->>A: Response
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

### Key Trade-offs
| Decision | Trade-off | Rationale |
|----------|-----------|-----------|
| [Decision] | [What we give up] | [Why it's worth it] |

---

## 6. Implementation Plan

### Phase 1: [Name] (Timeline)
- [ ] [Task 1]
- [ ] [Task 2]
- [ ] [Task 3]

### Phase 2: [Name] (Timeline)
- [ ] [Task 1]
- [ ] [Task 2]

### Dependencies
- [External dependency 1]
- [External dependency 2]

### Risks & Mitigations
| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| [Risk] | H/M/L | H/M/L | [How to mitigate] |

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
[How the system scales with increasing load]

### Disaster Recovery
- **RPO:** [Recovery Point Objective]
- **RTO:** [Recovery Time Objective]
- **Backup Strategy:** [Backup approach]

### Rollout Plan
1. [Deploy to staging]
2. [Canary deployment]
3. [Full rollout]

### Rollback Plan
[How to rollback if something goes wrong]

---

## 9. Testing Strategy

### Unit Tests
[Coverage expectations and key test cases]

### Integration Tests
[Key integration scenarios to test]

### Performance Tests
[Load testing approach and benchmarks]

---

## 10. Open Questions

- [ ] [Question 1]
- [ ] [Question 2]
- [ ] [Question 3]

---

## 11. References

- [Link 1 - Description]
- [Link 2 - Description]

---

**Next Steps:**
1. [Action item 1]
2. [Action item 2]
EOF
    ;;

  2)
    doc_name="rfc-$(echo $project | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
    cat > "${doc_name}.md" << 'EOF'
# RFC: TITLE_PLACEHOLDER

**Author:** AUTHOR_PLACEHOLDER
**Date:** DATE_PLACEHOLDER
**Status:** Draft
**Discussion:** [Link to discussion thread]

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
[Detailed design with examples]

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

### Do Nothing
[Consequences of not addressing the problem]

---

## Adoption Strategy

### Backward Compatibility
[How this maintains compatibility]

### Deprecation Strategy
[If deprecating old functionality]

### Communication Plan
[Who needs to know, when and how to communicate]

---

## Implementation Plan

### Estimated Effort
[Person-days or story points]

### Timeline
- **Start Date:** [Date]
- **Target Completion:** [Date]

### Team & Resources
- **Owner:** [@owner]
- **Contributors:** [@contributor1, @contributor2]

---

## Success Metrics

- [Metric 1: Target value]
- [Metric 2: Target value]
- [Metric 3: Target value]

---

## Unresolved Questions

- [ ] [Question 1]
- [ ] [Question 2]

---

## Related Work

- [Related RFC/design doc]
- [Similar implementations]
EOF
    ;;

  3)
    doc_name="adr-$(echo $project | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
    cat > "${doc_name}.md" << 'EOF'
# ADR: TITLE_PLACEHOLDER

**Date:** DATE_PLACEHOLDER
**Status:** Proposed
**Deciders:** AUTHOR_PLACEHOLDER

---

## Context

[Describe the context and problem statement. What forces are at play?
What architectural decision needs to be made? What are the constraints?]

### Technical Story
[Optional: Link to related ticket or story]

---

## Decision

[State the decision that was made. Use active voice: "We will..."]

We will [describe the decision in detail].

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
[Brief description of this alternative and why it was not chosen]

### Option 2: [Name]
[Brief description of this alternative and why it was not chosen]

---

## Related Decisions

- [ADR-XXX]: [Related decision]

---

## Notes

[Any additional information, implementation notes, or follow-up items]
EOF
    ;;

  4)
    doc_name="api-docs-$(echo $project | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
    cat > "${doc_name}.md" << 'EOF'
# API_NAME_PLACEHOLDER API Documentation

**Version:** v1.0
**Base URL:** `https://api.example.com/v1`
**Last Updated:** DATE_PLACEHOLDER

---

## Overview

[Brief description of what this API does and its main capabilities]

---

## Authentication

All API requests require authentication using Bearer tokens.

```http
Authorization: Bearer <access_token>
```

[Explain how to obtain tokens, token lifetime, and refresh mechanism]

---

## Endpoints

### Resource Operations

#### GET /resource

Retrieve a list of resources.

**Request:**
```http
GET /api/v1/resource?limit=20&offset=0
Authorization: Bearer <token>
```

**Query Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `limit` | integer | No | Number of items (default: 20, max: 100) |
| `offset` | integer | No | Pagination offset (default: 0) |

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
    "limit": 20,
    "offset": 0
  }
}
```

---

#### POST /resource

Create a new resource.

**Request:**
```http
POST /api/v1/resource
Authorization: Bearer <token>
Content-Type: application/json

{
  "name": "Example",
  "description": "Description"
}
```

**Request Body:**
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | Yes | Resource name |
| `description` | string | No | Resource description |

**Response: 201 Created**
```json
{
  "id": "456",
  "name": "Example",
  "description": "Description",
  "createdAt": "2025-11-14T10:30:00Z"
}
```

---

## Error Handling

All errors follow this structure:

```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable message",
    "field": "fieldName"
  }
}
```

### Common Error Codes

| Code | HTTP Status | Description |
|------|-------------|-------------|
| `INVALID_REQUEST` | 400 | Request validation failed |
| `UNAUTHORIZED` | 401 | Invalid or missing authentication |
| `FORBIDDEN` | 403 | Insufficient permissions |
| `NOT_FOUND` | 404 | Resource not found |
| `RATE_LIMIT` | 429 | Rate limit exceeded |
| `SERVER_ERROR` | 500 | Internal server error |

---

## Rate Limiting

| Endpoint | Limit | Window |
|----------|-------|--------|
| All endpoints | 1000 requests | 1 hour |

Rate limit information is included in response headers:

```http
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 950
X-RateLimit-Reset: 1699965600
```

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
console.log(data);
```

### Python
```python
import requests

response = requests.get(
    'https://api.example.com/v1/resource',
    headers={'Authorization': f'Bearer {token}'}
)

data = response.json()
print(data)
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
| v1.0 | DATE_PLACEHOLDER | Initial release |
EOF
    ;;

  5)
    doc_name="postmortem-$(echo $project | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
    cat > "${doc_name}.md" << 'EOF'
# Post-Mortem: TITLE_PLACEHOLDER

**Date of Incident:** DATE_PLACEHOLDER
**Duration:** [X hours/minutes]
**Severity:** [SEV-1 | SEV-2 | SEV-3]
**Author:** AUTHOR_PLACEHOLDER
**Participants:** [@person1, @person2]

---

## Executive Summary

[2-3 sentences summarizing: what happened, impact, and how it was resolved]

---

## Impact

- **Users Affected:** [Number or percentage]
- **Duration:** [Total downtime]
- **Revenue Impact:** [If applicable]
- **Systems Affected:** [List of systems]
- **Geographic Scope:** [Which regions]

---

## Timeline (All times in UTC)

| Time | Event |
|------|-------|
| 10:00 | [First signs of issue detected] |
| 10:05 | [Automated alerts triggered] |
| 10:10 | [Team notified and investigation began] |
| 10:25 | [Root cause identified] |
| 10:40 | [Fix deployed] |
| 10:50 | [Service fully restored] |
| 11:00 | [Monitoring confirmed recovery] |

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

- **How was it detected:** [Monitoring alert, user report, etc.]
- **Time to detect:** [Time from incident start to detection]
- **What worked well:** [Effective detection mechanisms]
- **What could improve:** [Detection gaps]

---

## Response

- **Time to engage:** [Time from detection to team engagement]
- **Time to mitigate:** [Time from engagement to mitigation]
- **Time to resolve:** [Time from engagement to full resolution]

---

## What Went Well

- [Thing that helped during incident response]
- [Effective practice or tool]
- [Good decision that was made]

---

## What Went Wrong

- [Problem during incident response]
- [Gap in process or tooling]
- [Communication issue]

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

### Key Logs
[Important log excerpts that helped diagnose the issue]

### Metrics
[Link to dashboards or important metrics]

### Related Incidents
- [Previous similar incident and ADR if applicable]

---

## Follow-up

**Review Date:** [Date]
**Follow-up Owner:** [@person]
EOF
    ;;

  6)
    doc_name="runbook-$(echo $project | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
    cat > "${doc_name}.md" << 'EOF'
# Runbook: SERVICE_NAME_PLACEHOLDER

**Service:** SERVICE_NAME_PLACEHOLDER
**Owner:** [@team or @person]
**Last Updated:** DATE_PLACEHOLDER
**On-Call:** [Link to on-call schedule]

---

## Overview

[Brief description of what this service does and when to use this runbook]

---

## Service Architecture

```mermaid
graph TB
    A[Component 1] --> B[Component 2]
    B --> C[Database]
```

---

## Prerequisites

- Access to: [systems/tools needed]
- Permissions: [required permissions]
- Tools: [kubectl, aws-cli, etc.]

---

## Common Tasks

### Start/Stop Service

**To start:**
```bash
# Commands to start the service
```

**To stop:**
```bash
# Commands to stop the service
```

**Expected outcome:** [What should happen]

---

### Check Service Health

```bash
# Health check command
curl https://service.example.com/health
```

**Healthy response:**
```json
{
  "status": "healthy",
  "version": "1.2.3"
}
```

---

## Monitoring & Alerts

### Key Metrics

| Metric | Dashboard | Normal Range | Alert Threshold |
|--------|-----------|--------------|-----------------|
| CPU Usage | [Link] | 20-40% | >80% |
| Memory | [Link] | 2-4GB | >6GB |
| Request Rate | [Link] | 1K-5K/min | >10K/min |

---

### Alert Response

#### Alert: High Error Rate

**Severity:** HIGH
**Description:** Error rate exceeded 5% for 5 minutes

**Immediate Actions:**
1. Check service logs for errors
2. Verify upstream dependencies are healthy
3. Check recent deployments

**Resolution Steps:**
1. [Step 1]
2. [Step 2]

**Escalation:** If unresolved in 15 minutes, page on-call architect

---

## Troubleshooting

### Problem: Service Not Responding

**Symptoms:**
- Health check failing
- No logs being generated
- High latency

**Diagnosis:**
```bash
# Check if service is running
ps aux | grep service-name

# Check logs
tail -f /var/log/service.log
```

**Solution:**
[How to fix the issue]

---

## Emergency Procedures

### Service is Down

1. Verify the issue (check monitoring)
2. Check if it's a planned maintenance
3. Attempt service restart
4. If restart fails, rollback to previous version
5. Notify stakeholders

### Data Loss Suspected

1. **DO NOT** restart services
2. Immediately page database team
3. Check backup status
4. Document timeline

---

## Configuration

### Environment Variables

| Variable | Purpose | Example |
|----------|---------|---------|
| `DB_HOST` | Database host | `db.example.com` |
| `API_KEY` | External API key | `sk_live_xxx` |

### Configuration Files

- **Location:** `/etc/service/config.yaml`
- **Format:** YAML
- **Reload:** Requires service restart

---

## Useful Commands

```bash
# View recent logs
tail -n 100 /var/log/service.log

# Check service status
systemctl status service-name

# Restart service
systemctl restart service-name

# View real-time metrics
watch -n 1 'curl localhost:9090/metrics'
```

---

## Links & Resources

- **Dashboard:** [Link]
- **Logs:** [Link]
- **Source Code:** [Link]
- **Design Doc:** [Link]
EOF
    ;;

  7)
    doc_name="onepager-$(echo $project | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
    cat > "${doc_name}.md" << 'EOF'
# PROJECT_NAME_PLACEHOLDER

**Owner:** AUTHOR_PLACEHOLDER
**Status:** Planning
**Target Date:** [Date]

---

## Problem

[2-3 sentences: What problem are we solving? What's the pain point?]

**Impact:** [Quantify the problem]

---

## Solution

[2-3 sentences: What are we building? How does it solve the problem?]

---

## Why Now

[1-2 sentences: Why is this important right now? What's the urgency?]

---

## Success Metrics

- **Metric 1:** [Target value]
- **Metric 2:** [Target value]
- **Metric 3:** [Target value]

---

## Timeline

- **Week 1-2:** [Milestone 1]
- **Week 3-4:** [Milestone 2]
- **Week 5-6:** [Launch]

---

## Risks & Mitigations

| Risk | Mitigation |
|------|------------|
| [Risk 1] | [How we'll handle it] |
| [Risk 2] | [How we'll handle it] |

---

## Resources Needed

- [Engineering: X people]
- [Design: Y people]
- [External dependencies]

---

## Open Questions

- [ ] [Question 1]
- [ ] [Question 2]
EOF
    ;;

  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
esac

# Replace placeholders
sed -i "s/TITLE_PLACEHOLDER/$title/g" "${doc_name}.md"
sed -i "s/AUTHOR_PLACEHOLDER/$author/g" "${doc_name}.md"
sed -i "s/PROJECT_NAME_PLACEHOLDER/$project/g" "${doc_name}.md"
sed -i "s/SERVICE_NAME_PLACEHOLDER/$project/g" "${doc_name}.md"
sed -i "s/API_NAME_PLACEHOLDER/$project/g" "${doc_name}.md"
sed -i "s/DATE_PLACEHOLDER/$(date +%Y-%m-%d)/g" "${doc_name}.md"

echo ""
echo "✅ Document generated: ${doc_name}.md"
echo ""
echo "Next steps:"
echo "1. Open ${doc_name}.md in your editor"
echo "2. Fill in the template sections"
echo "3. Add diagrams and examples"
echo "4. Review and share with your team"
echo ""
