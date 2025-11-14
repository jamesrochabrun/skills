# Technical Document Writer

**📝 Expert technical writing assistant for engineers creating documentation, diagrams, and presentations.**

Creates polished technical documents ready for Google Drive, Notion, Quip, and other platforms. Specializes in design docs, RFCs, ADRs, API documentation, architecture diagrams, and technical presentations.

---

## What This Skill Does

This skill helps engineers write clear, comprehensive technical documentation by:

1. **Generating structured documents** - Design docs, RFCs, ADRs, API docs, runbooks, post-mortems
2. **Creating diagrams** - Architecture diagrams, sequence diagrams, flowcharts, ERDs using Mermaid
3. **Building presentations** - Technical slides with diagrams and code examples
4. **Following best practices** - Industry-standard templates and writing guidelines
5. **Formatting for platforms** - Optimized for Google Drive, Notion, Quip, Confluence

---

## Document Types Supported

### Design Documents
Comprehensive system design with architecture, API contracts, data models, and trade-offs.

### RFCs (Request for Comments)
Proposals for significant changes with problem statements, solutions, and alternatives.

### ADRs (Architecture Decision Records)
Lightweight records of architectural decisions with context and consequences.

### API Documentation
Complete API specifications with endpoints, parameters, examples, and error codes.

### System Architecture
High-level system overviews with component diagrams and data flows.

### Runbooks & Operational Guides
Step-by-step procedures for operations, deployments, and incident response.

### Post-Mortems
Incident analysis with timeline, root cause, impact, and prevention measures.

---

## Quick Start Examples

### Example 1: Design Document for Notification System

"Using technical-doc-writer, create a design doc for a real-time notification system"

**Generated Document:**

```markdown
# Design Document: Real-Time Notification System

**Author:** Engineering Team
**Date:** 2025-11-14
**Status:** Proposed
**Reviewers:** @backend-team, @mobile-team

---

## 1. Overview

### Purpose
Design a scalable real-time notification system to deliver push notifications, in-app messages, and emails to users across web and mobile platforms.

### Goals
- Deliver notifications within 1 second for 99.9% of users
- Support 10M daily active users with 100M notifications/day
- Provide reliable delivery with retry mechanisms
- Enable rich notification content (text, images, actions)

### Non-Goals
- SMS notifications (future phase)
- Video notifications
- P2P messaging

---

## 2. Background & Context

### Current State
- Email notifications sent via cron jobs (15-minute delay)
- No push notifications for mobile apps
- Manual notification triggers for critical events

### Problem Statement
Users miss time-sensitive updates (messages, mentions, activity) due to delayed notifications. This impacts engagement and user experience.

---

## 3. Proposed Solution

### High-Level Architecture

```mermaid
graph TB
    A[Client Apps] -->|Subscribe| B[API Gateway]
    B --> C[Notification Service]
    C --> D[Message Queue]
    D --> E[Workers]
    E --> F[Push Provider]
    E --> G[Email Service]
    E --> H[WebSocket Server]
    F --> I[FCM/APNS]
    C --> J[(User Preferences DB)]
    C --> K[(Notification Store)]
    H --> A
```

### Components

#### Notification Service
- **Responsibility:** Central hub for creating and routing notifications
- **Technology:** Node.js microservice
- **Scale:** Horizontally scalable with load balancing

#### Message Queue
- **Responsibility:** Decouple notification creation from delivery
- **Technology:** AWS SQS or RabbitMQ
- **Capacity:** 10K messages/second

#### Workers
- **Responsibility:** Process queue messages and deliver notifications
- **Technology:** Node.js workers with auto-scaling
- **Scale:** 20-100 instances based on queue depth

#### Push Provider
- **Responsibility:** Deliver push notifications to mobile devices
- **Technology:** FCM (Android), APNS (iOS)
- **Fallback:** Exponential backoff with 3 retries

#### WebSocket Server
- **Responsibility:** Real-time delivery to web clients
- **Technology:** Socket.io with Redis adapter
- **Scale:** 10K concurrent connections per instance

---

## 4. Detailed Design

### Data Models

**Notification Schema:**
```typescript
interface Notification {
  id: string;
  userId: string;
  type: 'message' | 'mention' | 'like' | 'follow';
  title: string;
  body: string;
  imageUrl?: string;
  actionUrl?: string;
  priority: 'high' | 'normal' | 'low';
  createdAt: Date;
  deliveredAt?: Date;
  readAt?: Date;
}
```

**User Preferences Schema:**
```typescript
interface NotificationPreferences {
  userId: string;
  channels: {
    push: boolean;
    email: boolean;
    inApp: boolean;
  };
  types: {
    messages: boolean;
    mentions: boolean;
    likes: boolean;
    follows: boolean;
  };
  quietHours?: {
    start: string; // "22:00"
    end: string;   // "08:00"
  };
}
```

### API Contracts

**Create Notification:**
```http
POST /api/v1/notifications
Content-Type: application/json

{
  "userId": "user_123",
  "type": "message",
  "title": "New message from John",
  "body": "Hey, how are you?",
  "actionUrl": "/messages/456",
  "priority": "high"
}

Response: 201 Created
{
  "id": "notif_789",
  "status": "queued"
}
```

**Get User Notifications:**
```http
GET /api/v1/notifications?userId=user_123&limit=20&cursor=abc123

Response: 200 OK
{
  "notifications": [...],
  "nextCursor": "xyz789"
}
```

### Sequence Diagram

```mermaid
sequenceDiagram
    participant C as Client
    participant API as API Gateway
    participant NS as Notification Service
    participant Q as Message Queue
    participant W as Worker
    participant FCM as FCM/APNS

    C->>API: POST /messages (triggers notification)
    API->>NS: createNotification()
    NS->>Q: enqueue(notification)
    NS-->>API: 201 Created
    API-->>C: Success

    Q->>W: dequeue(notification)
    W->>W: checkUserPreferences()
    W->>FCM: sendPush(notification)
    FCM->>C: Push notification delivered
    W->>NS: markAsDelivered()
```

---

## 5. Trade-offs & Alternatives

### Alternative 1: Direct Synchronous Delivery
**Pros:** Simpler architecture
**Cons:** Higher latency, no retry mechanism, poor fault tolerance
**Decision:** Rejected - doesn't meet scalability requirements

### Alternative 2: Third-Party Service (OneSignal, Pusher)
**Pros:** Faster implementation, managed infrastructure
**Cons:** Cost at scale ($5K+/month), vendor lock-in, limited customization
**Decision:** Deferred - build MVP in-house, evaluate at 5M users

### Trade-off: Queue vs. Pub/Sub
**Queue (SQS):** At-least-once delivery, simpler ordering
**Pub/Sub (SNS):** Fan-out to multiple consumers, higher complexity
**Decision:** Start with queue for simplicity, migrate to pub/sub if needed

---

## 6. Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| P99 Delivery Time | < 1 second | CloudWatch logs |
| Delivery Success Rate | > 99.5% | Application metrics |
| Queue Processing Rate | > 10K/sec | SQS metrics |
| WebSocket Connection Uptime | > 99.9% | Health checks |
| User Engagement (click-through) | > 15% | Analytics events |

---

## 7. Implementation Plan

### Phase 1: MVP (3 weeks)
- [ ] Build Notification Service API
- [ ] Implement SQS integration
- [ ] Create workers for push delivery
- [ ] Add FCM/APNS integration
- [ ] Basic user preferences

### Phase 2: Web Support (2 weeks)
- [ ] WebSocket server setup
- [ ] Real-time delivery to web clients
- [ ] In-app notification UI

### Phase 3: Advanced Features (3 weeks)
- [ ] Email delivery
- [ ] Quiet hours support
- [ ] Notification grouping
- [ ] Rich media support

### Phase 4: Scale & Optimize (2 weeks)
- [ ] Load testing (100K notifications/sec)
- [ ] Auto-scaling configuration
- [ ] Monitoring & alerting
- [ ] Performance optimization

---

## 8. Security & Privacy

- **Authentication:** JWT tokens for API access
- **Authorization:** User can only access their own notifications
- **Data Retention:** Notifications deleted after 90 days
- **PII Handling:** Encrypt notification content at rest
- **Rate Limiting:** 100 requests/minute per user

---

## 9. Operational Considerations

### Monitoring
- Queue depth alerts (> 10K messages)
- Delivery failure rate (> 1%)
- API latency (P99 > 500ms)
- Worker health checks

### Rollout Strategy
1. Deploy to staging with synthetic load testing
2. Canary deployment (5% of traffic)
3. Gradual rollout (25% → 50% → 100%)
4. Feature flag for instant rollback

### Disaster Recovery
- Multi-region SQS queues
- Database replication with 5-minute RPO
- Automatic worker failover
- Manual fallback to email-only mode

---

## 10. Open Questions

- [ ] Should we support notification scheduling?
- [ ] How do we handle offline users (delivery on next login)?
- [ ] Do we need notification sound customization?
- [ ] Should we batch notifications for high-volume users?

---

## 11. References

- [Google's Push Notification Best Practices](https://developers.google.com/web/fundamentals/push-notifications)
- [AWS SQS Documentation](https://docs.aws.amazon.com/sqs/)
- [FCM Architecture](https://firebase.google.com/docs/cloud-messaging)

---

**Next Steps:**
1. Schedule design review with architecture team
2. Create implementation tickets in Jira
3. Set up development environment
4. Begin Phase 1 implementation
```

---

## Example 2: Architecture Diagram for Microservices

"Using technical-doc-writer, create an architecture diagram for a microservices e-commerce system"

**Generated Diagram:**

```mermaid
graph TB
    subgraph "Client Layer"
        WEB[Web App]
        MOBILE[Mobile App]
    end

    subgraph "API Gateway Layer"
        GW[API Gateway<br/>Kong/AWS API Gateway]
    end

    subgraph "Microservices"
        USER[User Service<br/>Node.js]
        PRODUCT[Product Service<br/>Go]
        CART[Cart Service<br/>Node.js]
        ORDER[Order Service<br/>Java]
        PAYMENT[Payment Service<br/>Python]
        INVENTORY[Inventory Service<br/>Go]
        NOTIFICATION[Notification Service<br/>Node.js]
    end

    subgraph "Data Layer"
        USERDB[(User DB<br/>PostgreSQL)]
        PRODUCTDB[(Product DB<br/>MongoDB)]
        CARTDB[(Cart Cache<br/>Redis)]
        ORDERDB[(Order DB<br/>PostgreSQL)]
        INVENTORYDB[(Inventory DB<br/>PostgreSQL)]
    end

    subgraph "Message Queue"
        QUEUE[RabbitMQ/Kafka]
    end

    subgraph "External Services"
        STRIPE[Stripe API]
        EMAIL[SendGrid]
        ANALYTICS[Google Analytics]
    end

    WEB --> GW
    MOBILE --> GW

    GW --> USER
    GW --> PRODUCT
    GW --> CART
    GW --> ORDER

    USER --> USERDB
    PRODUCT --> PRODUCTDB
    CART --> CARTDB
    ORDER --> ORDERDB
    ORDER --> QUEUE

    QUEUE --> PAYMENT
    QUEUE --> INVENTORY
    QUEUE --> NOTIFICATION

    PAYMENT --> STRIPE
    INVENTORY --> INVENTORYDB
    NOTIFICATION --> EMAIL

    ORDER --> ANALYTICS

    style WEB fill:#e1f5ff
    style MOBILE fill:#e1f5ff
    style GW fill:#fff3cd
    style QUEUE fill:#d4edda
```

---

## Example 3: API Documentation

"Using technical-doc-writer, create API docs for a user authentication endpoint"

**Generated Documentation:**

```markdown
# Authentication API

## Overview
RESTful API for user authentication and session management.

**Base URL:** `https://api.example.com/v1`

**Authentication:** Bearer token in Authorization header

---

## Endpoints

### POST /auth/register

Create a new user account.

**Request:**
```http
POST /auth/register
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "SecureP@ss123",
  "firstName": "John",
  "lastName": "Doe"
}
```

**Response: 201 Created**
```json
{
  "userId": "usr_1a2b3c4d",
  "email": "user@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "createdAt": "2025-11-14T10:30:00Z",
  "accessToken": "eyJhbGciOiJIUzI1NiIs...",
  "refreshToken": "v1.MRxXbxLq..."
}
```

**Error Responses:**

| Status Code | Error Code | Description |
|-------------|------------|-------------|
| 400 | `INVALID_EMAIL` | Email format is invalid |
| 400 | `WEAK_PASSWORD` | Password doesn't meet requirements |
| 409 | `EMAIL_EXISTS` | Email already registered |
| 429 | `RATE_LIMIT` | Too many registration attempts |

**Example Error:**
```json
{
  "error": {
    "code": "EMAIL_EXISTS",
    "message": "An account with this email already exists",
    "field": "email"
  }
}
```

**Password Requirements:**
- Minimum 8 characters
- At least one uppercase letter
- At least one lowercase letter
- At least one number
- At least one special character

---

### POST /auth/login

Authenticate user and receive access token.

**Request:**
```http
POST /auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "SecureP@ss123"
}
```

**Response: 200 OK**
```json
{
  "userId": "usr_1a2b3c4d",
  "accessToken": "eyJhbGciOiJIUzI1NiIs...",
  "refreshToken": "v1.MRxXbxLq...",
  "expiresIn": 3600
}
```

**Error Responses:**

| Status Code | Error Code | Description |
|-------------|------------|-------------|
| 401 | `INVALID_CREDENTIALS` | Email or password is incorrect |
| 403 | `ACCOUNT_LOCKED` | Account locked due to failed attempts |
| 429 | `RATE_LIMIT` | Too many login attempts |

---

### POST /auth/refresh

Refresh access token using refresh token.

**Request:**
```http
POST /auth/refresh
Content-Type: application/json

{
  "refreshToken": "v1.MRxXbxLq..."
}
```

**Response: 200 OK**
```json
{
  "accessToken": "eyJhbGciOiJIUzI1NiIs...",
  "expiresIn": 3600
}
```

---

### POST /auth/logout

Invalidate current session.

**Request:**
```http
POST /auth/logout
Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
```

**Response: 204 No Content**

---

## Rate Limiting

All authentication endpoints are rate-limited to prevent abuse:

| Endpoint | Limit | Window |
|----------|-------|--------|
| `/auth/register` | 5 requests | 1 hour |
| `/auth/login` | 10 requests | 15 minutes |
| `/auth/refresh` | 20 requests | 1 hour |

**Rate Limit Headers:**
```http
X-RateLimit-Limit: 10
X-RateLimit-Remaining: 7
X-RateLimit-Reset: 1699965600
```

---

## Security

- All endpoints require HTTPS
- Passwords hashed with bcrypt (cost factor 12)
- Access tokens expire in 1 hour
- Refresh tokens expire in 30 days
- CSRF protection via SameSite cookies
- Account locked after 5 failed login attempts (15-minute lockout)

---

## Code Examples

**JavaScript/TypeScript:**
```typescript
async function login(email: string, password: string) {
  const response = await fetch('https://api.example.com/v1/auth/login', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ email, password }),
  });

  if (!response.ok) {
    const error = await response.json();
    throw new Error(error.error.message);
  }

  const data = await response.json();
  localStorage.setItem('accessToken', data.accessToken);
  localStorage.setItem('refreshToken', data.refreshToken);

  return data;
}
```

**Python:**
```python
import requests

def login(email: str, password: str) -> dict:
    response = requests.post(
        'https://api.example.com/v1/auth/login',
        json={'email': email, 'password': password}
    )
    response.raise_for_status()
    data = response.json()

    # Store tokens securely
    return data
```

**cURL:**
```bash
curl -X POST https://api.example.com/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"SecureP@ss123"}'
```
```

---

## Example 4: Sequence Diagram for Payment Flow

"Using technical-doc-writer, create a sequence diagram for a payment processing flow"

**Generated Diagram:**

```mermaid
sequenceDiagram
    participant U as User
    participant C as Client App
    participant API as API Gateway
    participant O as Order Service
    participant P as Payment Service
    participant S as Stripe
    participant I as Inventory Service
    participant N as Notification Service

    U->>C: Click "Place Order"
    C->>API: POST /orders
    API->>O: createOrder()
    O->>O: Validate cart items
    O->>O: Calculate total
    O->>API: Order created (pending)
    API->>C: Order ID

    C->>U: Show payment form
    U->>C: Enter card details
    C->>S: Tokenize card
    S-->>C: Payment token

    C->>API: POST /orders/:id/pay
    API->>P: processPayment(orderId, token)
    P->>S: Charge card

    alt Payment successful
        S-->>P: Payment confirmed
        P->>O: updateOrderStatus(paid)
        O->>I: decrementInventory()
        I-->>O: Inventory updated
        O->>N: sendConfirmationEmail()
        P-->>API: 200 OK
        API-->>C: Payment successful
        C->>U: Show success message
    else Payment failed
        S-->>P: Payment declined
        P->>O: updateOrderStatus(failed)
        P-->>API: 402 Payment Required
        API-->>C: Payment failed
        C->>U: Show error message
    end
```

---

## Diagram Types Supported

### Architecture Diagrams
System components and their relationships using flowcharts.

### Sequence Diagrams
Interaction between components over time.

### Flowcharts
Process flows and decision trees.

### ERD (Entity-Relationship Diagrams)
Database schema and relationships.

### State Diagrams
State machines and transitions.

### Gantt Charts
Project timelines and dependencies.

### Class Diagrams
Object-oriented system structure.

---

## Usage

### Generate a Design Document
```
"Using technical-doc-writer, create a design doc for [feature/system]"
```

### Generate a Diagram
```
"Using technical-doc-writer, create a [diagram type] showing [description]"
```

### Generate API Documentation
```
"Using technical-doc-writer, document the API for [feature]"
```

### Generate a Presentation
```
"Using technical-doc-writer, create slides about [topic]"
```

### Generate an RFC
```
"Using technical-doc-writer, write an RFC for [proposal]"
```

---

## Best Practices Applied

### Writing Guidelines
- **Clarity:** Simple language, avoid jargon
- **Structure:** Consistent formatting and sections
- **Completeness:** All necessary information included
- **Conciseness:** No unnecessary details
- **Visuals:** Diagrams to illustrate complex concepts

### Document Standards
- **Metadata:** Author, date, status, reviewers
- **Versioning:** Track changes and decisions
- **Cross-references:** Link to related documents
- **Examples:** Code samples and use cases
- **Metrics:** Measurable success criteria

### Diagram Principles
- **Simplicity:** Show only relevant information
- **Consistency:** Use standard notation
- **Clarity:** Clear labels and legends
- **Hierarchy:** Organize by layers/levels
- **Color coding:** Meaningful visual grouping

---

## Platform Compatibility

### Google Docs
- Paste markdown as formatted text
- Use mermaid-to-image converter for diagrams
- Add table of contents for navigation

### Notion
- Paste markdown directly (native support)
- Mermaid diagrams render automatically
- Use callout blocks for highlights

### Quip
- Convert markdown to HTML for formatting
- Export diagrams as images
- Use spreadsheets for tables

### Confluence
- Use Confluence markdown macro
- Install Mermaid plugin for diagrams
- Create page templates for consistency

---

## Helper Scripts

### generate_doc.sh
Interactive script to generate different document types with templates.

### generate_diagram.sh
Create diagrams with predefined styles and export options.

### generate_slides.sh
Build technical presentations with code examples and diagrams.

---

## Reference Materials

See the `/references` directory for:
- **writing_best_practices.md** - Technical writing guidelines and tips
- **templates.md** - Complete templates for all document types
- **diagrams.md** - Diagram examples and Mermaid syntax guide
- **presentation_guide.md** - Slide structure and visual design tips

---

## Examples of Generated Documents

You can ask the skill to generate any of these document types:

1. **Design Documents** - Full system design with architecture
2. **RFCs** - Proposals with problem statements and solutions
3. **ADRs** - Architecture decision records with context
4. **API Docs** - Complete API reference with examples
5. **Runbooks** - Operational procedures and troubleshooting
6. **Post-Mortems** - Incident analysis and prevention
7. **Onboarding Guides** - New engineer documentation
8. **System Overviews** - High-level architecture documentation
9. **Technical Proposals** - Feature proposals with estimates
10. **Migration Guides** - Step-by-step migration procedures

---

**Ready to create professional technical documentation? Just ask!**
