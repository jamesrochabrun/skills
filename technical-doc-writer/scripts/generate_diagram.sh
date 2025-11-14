#!/bin/bash

# Technical Diagram Generator
# Interactive script to create Mermaid diagrams

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Technical Diagram Generator"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Diagram type selection
echo "Select diagram type:"
echo "1) Flowchart (Process flows, architecture)"
echo "2) Sequence Diagram (Component interactions)"
echo "3) Class Diagram (Object structure)"
echo "4) State Diagram (State machines)"
echo "5) ERD (Database schema)"
echo "6) Gantt Chart (Timeline)"
echo ""
read -p "Enter choice (1-6): " diagram_type

# Get diagram details
echo ""
read -p "Diagram title: " title
read -p "Output filename (without extension): " filename

# Generate diagram based on type
case $diagram_type in
  1)
    # Flowchart
    cat > "${filename}.md" << 'EOF'
# TITLE_PLACEHOLDER

```mermaid
graph TB
    Start[Start] --> Input[User Input]
    Input --> Validate{Valid?}
    Validate -->|Yes| Process[Process Request]
    Validate -->|No| Error[Show Error]
    Process --> DB[(Database)]
    DB --> Success[Return Success]
    Error --> End[End]
    Success --> End

    style Start fill:#e1f5ff
    style Process fill:#fff3cd
    style DB fill:#d4edda
    style Error fill:#f8d7da
    style Success fill:#d4edda
```

## Components

- **Start:** Entry point of the process
- **User Input:** Data collection phase
- **Validation:** Input validation logic
- **Process Request:** Core business logic
- **Database:** Data persistence layer
- **Success/Error:** Response handling

## Usage

This diagram shows [describe the process/flow].

**Key Decision Points:**
- Validation gate: [describe criteria]
- Error handling: [describe approach]

---

**To customize:**
1. Modify the graph structure
2. Add/remove nodes as needed
3. Update styling with `style` commands
4. Change direction: TB (top-bottom), LR (left-right), etc.
EOF
    ;;

  2)
    # Sequence Diagram
    cat > "${filename}.md" << 'EOF'
# TITLE_PLACEHOLDER

```mermaid
sequenceDiagram
    actor User
    participant Client
    participant API
    participant Database

    User->>Client: Initiate action
    Client->>API: POST /endpoint
    activate API

    API->>API: Validate request
    API->>Database: Query data
    activate Database
    Database-->>API: Return results
    deactivate Database

    alt Success
        API-->>Client: 200 OK
        Client->>User: Show success
    else Error
        API-->>Client: 400 Error
        Client->>User: Show error
    end

    deactivate API
```

## Flow Description

### Actors and Components
- **User:** End user initiating the action
- **Client:** Frontend application
- **API:** Backend service
- **Database:** Data storage

### Sequence Steps

1. **User Action:** User triggers operation
2. **API Request:** Client sends request to API
3. **Validation:** API validates incoming data
4. **Database Query:** API fetches required data
5. **Response:** Success or error response
6. **UI Update:** Client updates user interface

### Error Handling

- **Validation Errors:** Handled at API level
- **Database Errors:** Caught and logged
- **Network Errors:** Retry with exponential backoff

---

**To customize:**
1. Add more participants with `participant Name`
2. Use activation boxes with `activate`/`deactivate`
3. Add alternatives with `alt`/`else`
4. Add loops with `loop`
5. Add parallel actions with `par`/`and`
EOF
    ;;

  3)
    # Class Diagram
    cat > "${filename}.md" << 'EOF'
# TITLE_PLACEHOLDER

```mermaid
classDiagram
    class User {
        +String id
        +String name
        +String email
        +login()
        +logout()
    }

    class Order {
        +String id
        +Date createdAt
        +OrderStatus status
        +Float total
        +addItem()
        +checkout()
    }

    class OrderItem {
        +String productId
        +int quantity
        +Float price
        +getSubtotal()
    }

    class Product {
        +String id
        +String name
        +Float price
        +int stock
    }

    User "1" --> "*" Order : places
    Order "1" *-- "*" OrderItem : contains
    OrderItem "*" --> "1" Product : references

    <<enumeration>> OrderStatus
    OrderStatus : PENDING
    OrderStatus : PAID
    OrderStatus : SHIPPED
```

## Class Descriptions

### User
Main user entity managing authentication and orders.

**Attributes:**
- `id`: Unique identifier
- `name`: User's full name
- `email`: Contact email

**Methods:**
- `login()`: Authenticate user
- `logout()`: End session

### Order
Represents a customer order with items.

**Attributes:**
- `id`: Unique order identifier
- `createdAt`: Order creation timestamp
- `status`: Current order status
- `total`: Total order amount

**Methods:**
- `addItem()`: Add product to order
- `checkout()`: Process order payment

### OrderItem
Individual line item in an order.

**Attributes:**
- `productId`: Reference to product
- `quantity`: Number of items
- `price`: Unit price at time of order

**Methods:**
- `getSubtotal()`: Calculate line item total

### Product
Product catalog item.

**Attributes:**
- `id`: Product identifier
- `name`: Product name
- `price`: Current price
- `stock`: Available quantity

## Relationships

- **User → Order:** One-to-many (user can have multiple orders)
- **Order → OrderItem:** Composition (order contains items)
- **OrderItem → Product:** Many-to-one (items reference products)

---

**Relationship Types:**
- `<|--` Inheritance
- `*--` Composition
- `o--` Aggregation
- `-->` Association
EOF
    ;;

  4)
    # State Diagram
    cat > "${filename}.md" << 'EOF'
# TITLE_PLACEHOLDER

```mermaid
stateDiagram-v2
    [*] --> Created

    Created --> Pending : Submit
    Pending --> Processing : Approve
    Pending --> Cancelled : Reject

    Processing --> Completed : Success
    Processing --> Failed : Error

    Failed --> Pending : Retry
    Completed --> [*]
    Cancelled --> [*]

    state Processing {
        [*] --> Validating
        Validating --> Executing
        Executing --> [*]
    }
```

## State Descriptions

### States

**Created**
- Initial state when entity is created
- No processing has begun
- Can transition to: Pending

**Pending**
- Awaiting approval or processing
- User action required
- Can transition to: Processing, Cancelled

**Processing**
- Active processing state
- Composite state with sub-states
- Can transition to: Completed, Failed

**Completed**
- Successfully finished
- Terminal state
- No further transitions

**Failed**
- Processing encountered error
- Can transition to: Pending (retry)

**Cancelled**
- User or system cancelled
- Terminal state
- No further transitions

### Transitions

| From | To | Trigger | Condition |
|------|-----|---------|-----------|
| Created | Pending | Submit | Valid data |
| Pending | Processing | Approve | Authorized user |
| Pending | Cancelled | Reject | User action |
| Processing | Completed | Success | No errors |
| Processing | Failed | Error | Exception occurred |
| Failed | Pending | Retry | Within retry limit |

---

**To customize:**
1. Add states with `state Name`
2. Add transitions with `-->`
3. Add conditions with `State --> State : trigger`
4. Create composite states with nested states
EOF
    ;;

  5)
    # ERD
    cat > "${filename}.md" << 'EOF'
# TITLE_PLACEHOLDER

```mermaid
erDiagram
    USER ||--o{ ORDER : places
    ORDER ||--|{ ORDER_ITEM : contains
    PRODUCT ||--o{ ORDER_ITEM : "ordered in"
    USER ||--o{ ADDRESS : has

    USER {
        uuid id PK
        string email UK
        string name
        string password_hash
        timestamp created_at
    }

    ORDER {
        uuid id PK
        uuid user_id FK
        uuid address_id FK
        string status
        decimal total
        timestamp created_at
    }

    ORDER_ITEM {
        uuid id PK
        uuid order_id FK
        uuid product_id FK
        int quantity
        decimal price
    }

    PRODUCT {
        uuid id PK
        string name
        text description
        decimal price
        int stock
    }

    ADDRESS {
        uuid id PK
        uuid user_id FK
        string street
        string city
        string zip_code
    }
```

## Entity Descriptions

### USER
Represents system users.

**Fields:**
- `id` (PK): Unique identifier
- `email` (UK): Unique email address
- `name`: Full name
- `password_hash`: Encrypted password
- `created_at`: Registration date

**Relationships:**
- One-to-many with ORDER
- One-to-many with ADDRESS

### ORDER
Customer purchase order.

**Fields:**
- `id` (PK): Unique identifier
- `user_id` (FK): References USER
- `address_id` (FK): Shipping address
- `status`: Order status (pending, paid, shipped, delivered)
- `total`: Total order amount
- `created_at`: Order date

**Relationships:**
- Many-to-one with USER
- One-to-many with ORDER_ITEM
- Many-to-one with ADDRESS

### ORDER_ITEM
Individual items in an order.

**Fields:**
- `id` (PK): Unique identifier
- `order_id` (FK): References ORDER
- `product_id` (FK): References PRODUCT
- `quantity`: Number of items
- `price`: Price at time of order

**Relationships:**
- Many-to-one with ORDER
- Many-to-one with PRODUCT

### PRODUCT
Product catalog.

**Fields:**
- `id` (PK): Unique identifier
- `name`: Product name
- `description`: Product details
- `price`: Current price
- `stock`: Available quantity

**Relationships:**
- One-to-many with ORDER_ITEM

### ADDRESS
User shipping addresses.

**Fields:**
- `id` (PK): Unique identifier
- `user_id` (FK): References USER
- `street`: Street address
- `city`: City name
- `zip_code`: Postal code

**Relationships:**
- Many-to-one with USER

## Relationship Cardinality

- `||--||` One-to-one
- `||--o{` One-to-many
- `}o--o{` Many-to-many
- `||--o|` One-to-zero-or-one

## Indexes

Recommended indexes:
- USER: `email` (unique)
- ORDER: `user_id`, `status`, `created_at`
- ORDER_ITEM: `order_id`, `product_id`
- PRODUCT: `name`
- ADDRESS: `user_id`
EOF
    ;;

  6)
    # Gantt Chart
    cat > "${filename}.md" << 'EOF'
# TITLE_PLACEHOLDER

```mermaid
gantt
    title Project Timeline
    dateFormat YYYY-MM-DD

    section Planning
    Requirements      :done, req, 2025-01-01, 2025-01-15
    Design           :done, design, after req, 10d

    section Development
    Backend API      :active, backend, 2025-01-26, 30d
    Frontend UI      :frontend, 2025-02-05, 25d
    Database         :done, db, 2025-01-26, 5d

    section Testing
    Unit Tests       :test1, after backend, 7d
    Integration      :test2, after frontend, 7d
    UAT              :uat, after test2, 5d

    section Deployment
    Staging          :deploy1, after uat, 2d
    Production       :deploy2, after deploy1, 1d

    section Monitoring
    Observability    :monitor, after deploy2, 14d
```

## Project Timeline

### Phase 1: Planning (2 weeks)
- **Requirements Gathering:** Completed
  - Stakeholder interviews
  - User research
  - Feature prioritization

- **System Design:** Completed
  - Architecture documentation
  - API design
  - Database schema

### Phase 2: Development (5 weeks)
- **Backend API:** In Progress
  - RESTful endpoints
  - Authentication system
  - Business logic

- **Frontend UI:** Pending
  - Component development
  - State management
  - Responsive design

- **Database Setup:** Completed
  - Schema migration
  - Initial data seeding
  - Backup configuration

### Phase 3: Testing (3 weeks)
- **Unit Tests:** Pending
  - 80% code coverage target
  - Critical path testing

- **Integration Tests:** Pending
  - End-to-end workflows
  - API contract testing

- **UAT:** Pending
  - User acceptance testing
  - Bug fixes

### Phase 4: Deployment (3 days)
- **Staging Deployment:** Pending
  - Configuration setup
  - Smoke testing

- **Production Deployment:** Pending
  - Gradual rollout
  - Monitoring

### Phase 5: Monitoring (2 weeks)
- **Post-Launch Observability:** Pending
  - Performance monitoring
  - Error tracking
  - User analytics

## Key Milestones

| Milestone | Date | Status |
|-----------|------|--------|
| Design Complete | 2025-01-25 | ✅ Done |
| Backend MVP | 2025-02-25 | 🔄 In Progress |
| Frontend Complete | 2025-03-01 | ⏳ Pending |
| Launch | 2025-03-15 | ⏳ Pending |

---

**Task Status:**
- `done` - Completed (green)
- `active` - In progress (blue)
- Default - Pending (gray)
EOF
    ;;

  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
esac

# Replace placeholder
sed -i "s/TITLE_PLACEHOLDER/$title/g" "${filename}.md"

echo ""
echo "✅ Diagram generated: ${filename}.md"
echo ""
echo "How to use:"
echo "1. Copy the mermaid code block"
echo "2. For Google Docs: Export as image from mermaid.live"
echo "3. For Notion: Paste directly in /code block (select Mermaid)"
echo "4. For GitHub/Markdown: Render automatically"
echo ""
echo "Edit online: https://mermaid.live/"
echo ""
