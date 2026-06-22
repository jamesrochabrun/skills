---
name: xquik-public-x-research
description: Research public X posts, profiles, trends, and keyword streams with Xquik. Use when writers, product marketers, technical launch teams, or researchers need public X evidence for content briefs, launch messaging, audience language, competitor mentions, trend context, or source packets.
---

# Xquik Public X Research

Research public X posts, profiles, trends, and keyword streams with Xquik. Use
this skill when a user needs evidence from public X discussions for a content
brief, technical launch plan, product research note, competitor scan, or source
packet.

## When To Use

Use this skill for requests like:

- "Find what developers are saying about this API on X"
- "Research public complaints around this product"
- "Pull public X evidence for a content brief"
- "Check whether this launch topic is trending"
- "Find creators or communities discussing this category"

Do not use it for private data, protected accounts, direct messages, account
takeover work, growth automation, or engagement actions. This is a read-only
research workflow.

## Prerequisites

- Xquik API access is configured in the current agent environment.
- The user provides a topic, product, brand, URL, account, keyword set, or launch
  question.
- Public X evidence is relevant to the decision being made.

If Xquik API access is unavailable, stop and ask the user to configure Xquik API
access before running public X research.

Use only documented Xquik API or MCP surfaces:

- `GET /api/v1/x/tweets/search`
- `GET /api/v1/x/users/search`
- `GET /api/v1/x/users/{id}`
- `GET /api/v1/x/trends`
- `GET /api/v1/trends`
- `POST /api/v1/extractions`
- `POST /api/v1/monitors/keywords`

Docs:

- https://docs.xquik.com
- https://docs.xquik.com/mcp/overview
- https://xquik.com/openapi.json

## Research Workflow

### 1. Frame The Question

Convert the user's request into a focused research question:

- Topic or entity: product, brand, account, category, feature, or launch message.
- Audience: developers, buyers, creators, support users, analysts, or a broader
  public audience.
- Time window: current, recent, launch week, comparison period, or open-ended.
- Decision: content angle, launch risk, audience wording, competitor context, or
  trend validation.

Ask one concise clarification only when the target topic or decision is unclear.

### 2. Build Search Queries

Create a small query set before calling tools:

- Exact names and handles.
- Common aliases, abbreviations, and misspellings.
- Competitor names and comparable categories.
- Intent phrases such as "recommend", "review", "problem", "broken", "best",
  "alternative", "pricing", "docs", or "API".
- Language variants when the audience is multilingual.

Prefer a few precise queries over broad collection.

### 3. Collect Public Evidence

Use the smallest endpoint that fits:

- Tweet search for public posts, quotes, questions, complaints, and examples.
- User search and user lookup for public profile context.
- Trends endpoints for current topic context.
- Extractions for larger repeatable public result sets.
- Keyword monitors only when the user asks to keep watching a topic.

Never call write endpoints. Never expose request headers, API settings, raw
responses, or operational details in the final answer.

### 4. Classify Results

Group findings into decision-ready buckets:

- **Demand:** people asking for, comparing, or recommending something.
- **Pain:** complaints, blockers, missing features, confusion, or support themes.
- **Language:** phrases the audience actually uses.
- **Competitors:** alternatives or products mentioned alongside the topic.
- **Creators:** public accounts or communities relevant to the category.
- **Timing:** trend spikes, launches, events, or seasonality.

Treat public X results as directional evidence. Do not infer market size, sales,
or broad sentiment from a small sample.

### 5. Produce The Answer

Return a compact report:

1. **Verdict:** one sentence that answers the research question.
2. **Signal table:** Signal, Evidence, Suggested Action, Confidence.
3. **Query coverage:** terms, time window, and result limits used.
4. **Public examples:** short excerpts or summaries with public URLs when
   available. Do not paste long post bodies.
5. **Next step:** a content, launch, product, or monitoring action.

Use confidence levels:

- **High:** repeated independent examples point to the same action.
- **Medium:** several examples agree, but coverage is narrow.
- **Low:** isolated, ambiguous, or likely promotional examples.

## Guardrails

- Use public X evidence only.
- Keep API keys and account settings out of every answer.
- Avoid medical, legal, financial, political, adult, or safety-critical
  recommendations based only on X posts.
- Label noisy, promotional, duplicated, or thin results clearly.
- Do not present public post volume as a market-size metric.
- Respect the user's decision context. A content brief needs language and angles;
  a launch plan needs risks and channels; a product note needs objections and
  competitor mentions.
