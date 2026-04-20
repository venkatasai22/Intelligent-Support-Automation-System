# API Documentation
## Intelligent Support Automation System

**API Version:** v1  
**Base URL:** `https://api.example.com/api/v1`  
**Authentication:** JWT Bearer Token or API Key

---

## Overview

The Intelligent Support Automation System API provides endpoints for:
- Submitting support queries and receiving AI-generated responses
- Collecting user feedback for continuous model improvement
- Retrieving system status and metrics
- Accessing model information and performance data

**Performance:** 
- Average response time: 552ms (35% reduction from baseline)
- 99th percentile: 580ms
- Query capacity: 1,200 req/sec

---

## Authentication

### API Key Authentication
Include API key in request header:
```bash
X-API-Key: key_your_api_key_here
```

### JWT Bearer Token
Include JWT token in Authorization header:
```bash
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

---

## Endpoints

### 1. Submit Query

**Endpoint:** `POST /query`

Submit a support query and receive an AI-generated response with feedback loop integration.

**Request:**
```json
{
  "query": "How do I reset my password?",
  "context": {
    "user_id": "user_12345",
    "category": "account_management",
    "language": "en"
  }
}
```

**Response:** (200 OK)
```json
{
  "response_id": "resp_abc123def456",
  "text": "To reset your password, go to the login page and click 'Forgot Password'. Enter your email address and follow the instructions sent to your inbox.",
  "confidence": 0.87,
  "category": "account_management",
  "response_time_ms": 145,
  "cached": true,
  "model_version": "2.1"
}
```

**Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| query | string | Yes | The user's support query |
| context | object | No | Additional context (user_id, language, category) |
| user_id | string | No | Identifier for user feedback tracking |

**Response Fields:**
| Field | Type | Description |
|-------|------|-------------|
| response_id | string | Unique identifier for tracking this response |
| text | string | The AI-generated response text |
| confidence | float | Confidence score (0.0-1.0) of the response |
| category | string | Classified query category |
| response_time_ms | number | Time taken to generate response |
| cached | boolean | Whether response was from cache |
| model_version | string | ML model version used |

**Examples:**

```bash
# Basic query
curl -X POST https://api.example.com/api/v1/query \
  -H "X-API-Key: key_your_key" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "How do I reset my password?"
  }'

# With context
curl -X POST https://api.example.com/api/v1/query \
  -H "X-API-Key: key_your_key" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "Why was I charged twice?",
    "context": {
      "user_id": "user_12345",
      "category": "billing"
    }
  }'
```

**Status Codes:**
- `200 OK` - Query processed successfully
- `400 Bad Request` - Invalid query format
- `401 Unauthorized` - Missing or invalid authentication
- `429 Too Many Requests` - Rate limit exceeded
- `500 Internal Server Error` - Server error

---

### 2. Get Cached Response

**Endpoint:** `GET /response/{response_id}`

Retrieve a response by its ID for followup or reference.

**Response:** (200 OK)
```json
{
  "response_id": "resp_abc123def456",
  "query": "How do I reset my password?",
  "text": "To reset your password...",
  "confidence": 0.87,
  "category": "account_management",
  "created_at": "2026-04-20T10:30:00Z",
  "feedback_received": false
}
```

---

### 3. Submit Feedback

**Endpoint:** `POST /feedback`

Submit user feedback on responses for model improvement. Feedback data drives the daily retraining pipeline.

**Request:**
```json
{
  "response_id": "resp_abc123def456",
  "rating": 5,
  "correction": "The actual password reset process also requires phone verification.",
  "comment": "Helpful but missing a step"
}
```

**Response:** (201 Created)
```json
{
  "feedback_id": "fb_xyz789abc012",
  "status": "received",
  "message": "Thank you for your feedback. This helps improve our AI system."
}
```

**Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| response_id | string | Yes | ID of the response being rated |
| rating | integer | Yes | Rating from 1-5 stars |
| correction | string | No | Correction to the response |
| comment | string | No | Additional feedback comment |

**Feedback Impact:**
- 5-star ratings used to reinforce successful responses
- Corrections (1-2 stars with correction) are high-value for retraining
- All feedback aggregated daily → retraining pipeline

**Examples:**

```bash
# Positive feedback
curl -X POST https://api.example.com/api/v1/feedback \
  -H "X-API-Key: key_your_key" \
  -H "Content-Type: application/json" \
  -d '{
    "response_id": "resp_abc123def456",
    "rating": 5,
    "comment": "Perfect, it worked!"
  }'

# Correction feedback
curl -X POST https://api.example.com/api/v1/feedback \
  -H "X-API-Key: key_your_key" \
  -H "Content-Type: application/json" \
  -d '{
    "response_id": "resp_abc123def456",
    "rating": 2,
    "correction": "The actual process is different for enterprise accounts"
  }'
```

**Status Codes:**
- `201 Created` - Feedback recorded successfully
- `400 Bad Request` - Invalid feedback format
- `401 Unauthorized` - Missing or invalid authentication
- `404 Not Found` - Response ID not found

---

### 4. List Available Models

**Endpoint:** `GET /models`

Get information about available ML models and their performance metrics.

**Response:** (200 OK)
```json
{
  "current": {
    "name": "bert-support-v2.1",
    "version": "2.1",
    "accuracy": 0.83,
    "training_samples": 500000,
    "last_updated": "2026-03-15",
    "release_date": "2026-03-20",
    "description": "Current production model with 83% accuracy"
  },
  "previous": [
    {
      "name": "bert-support-v2.0",
      "version": "2.0",
      "accuracy": 0.79,
      "release_date": "2025-10-15",
      "archived": false
    },
    {
      "name": "bert-support-v1.5",
      "version": "1.5",
      "accuracy": 0.64,
      "release_date": "2025-06-15",
      "archived": true
    }
  ]
}
```

**Model Performance History:**
| Version | Accuracy | Release Date | Status |
|---------|----------|--------------|--------|
| v1.0 | 56% | 2025-04-15 | Archived |
| v1.5 | 64% | 2025-06-15 | Archived |
| v2.0 | 79% | 2025-10-15 | Available |
| v2.1 | 83% | 2026-03-20 | Current |

---

### 5. Health Check

**Endpoint:** `GET /health`

Check system health and component status.

**Response:** (200 OK)
```json
{
  "status": "healthy",
  "timestamp": "2026-04-20T10:35:42Z",
  "version": "2.1",
  "components": {
    "api": "healthy",
    "database": "healthy",
    "cache": "healthy",
    "model_service": "healthy"
  },
  "metrics": {
    "uptime_hours": 720,
    "queries_processed": 18576000,
    "avg_response_time_ms": 552,
    "error_rate": 0.003
  }
}
```

---

## Rate Limiting

API requests are rate limited per API key:

| Limit Type | Limit | Window |
|-----------|-------|--------|
| Requests/Minute | 1,000 | 1 minute |
| Requests/Hour | 50,000 | 1 hour |
| Requests/Day | 1,000,000 | 1 day |

**Rate Limit Headers:**
```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 987
X-RateLimit-Reset: 1682000400
```

When rate limit exceeded:
```json
{
  "error": "Rate limit exceeded",
  "retry_after_seconds": 60
}
```

---

## Error Handling

### Common Error Responses

**400 Bad Request**
```json
{
  "error": "BadRequest",
  "message": "Query cannot be empty",
  "timestamp": "2026-04-20T10:35:42Z"
}
```

**401 Unauthorized**
```json
{
  "error": "Unauthorized",
  "message": "Invalid API key",
  "timestamp": "2026-04-20T10:35:42Z"
}
```

**429 Too Many Requests**
```json
{
  "error": "RateLimitExceeded",
  "message": "Rate limit exceeded",
  "retry_after_seconds": 60,
  "timestamp": "2026-04-20T10:35:42Z"
}
```

**500 Internal Server Error**
```json
{
  "error": "InternalServerError",
  "message": "An unexpected error occurred",
  "request_id": "req_abc123",
  "timestamp": "2026-04-20T10:35:42Z"
}
```

---

## Response Codes

### Success
- `200 OK` - Request successful
- `201 Created` - Resource created
- `204 No Content` - Request successful, no content

### Client Error
- `400 Bad Request` - Invalid request format
- `401 Unauthorized` - Authentication required
- `403 Forbidden` - Access denied
- `404 Not Found` - Resource not found
- `429 Too Many Requests` - Rate limit exceeded

### Server Error
- `500 Internal Server Error` - Server error
- `502 Bad Gateway` - Gateway error
- `503 Service Unavailable` - Service temporarily down

---

## Query Categories

The system classifies queries into these categories:

| Category | Examples | Accuracy |
|----------|----------|----------|
| Account Management | password reset, profile update | 88% |
| Billing & Payments | billing questions, subscriptions | 81% |
| Technical Support | error troubleshooting, performance | 79% |
| General Knowledge | product information, policies | 87% |
| Product Features | feature usage, capabilities | 84% |

---

## Performance Metrics

### Response Times (Percentiles)

```
p50:  145ms  (median)
p95:  320ms
p99:  580ms  (max expected)
avg:  552ms
```

***Cache Impact:**
- With cache hit: 95ms
- Without cache: 850ms
- Cache reduces latency by: 288ms (34%)

### Throughput

- Single instance: 180 req/sec
- Cluster (standard): 1,200 req/sec
- Maximum sustainable: 1,200 req/sec

### Uptime

- Target SLA: 99.95%
- Current uptime: 99.98%
- Last incident: 45 days ago

---

## Integration Examples

### Python
```python
import requests

api_key = "key_your_api_key_here"
base_url = "https://api.example.com/api/v1"

# Submit query
response = requests.post(
    f"{base_url}/query",
    headers={"X-API-Key": api_key},
    json={
        "query": "How do I cancel my subscription?",
        "context": {"user_id": "user_12345"}
    }
)

result = response.json()
print(f"Response: {result['text']}")
print(f"Confidence: {result['confidence']:.2%}")

# Submit feedback
requests.post(
    f"{base_url}/feedback",
    headers={"X-API-Key": api_key},
    json={
        "response_id": result['response_id'],
        "rating": 5
    }
)
```

### JavaScript/Node.js
```javascript
const apiKey = "key_your_api_key_here";
const baseUrl = "https://api.example.com/api/v1";

async function getResponse(query) {
  const response = await fetch(`${baseUrl}/query`, {
    method: "POST",
    headers: {
      "X-API-Key": apiKey,
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      query: query,
      context: { user_id: "user_12345" }
    })
  });
  
  return response.json();
}

const result = await getResponse("How do I update my payment method?");
console.log(`Response: ${result.text}`);
```

---

## Support

For API support, issues, or questions:
- Email: api-support@example.com
- Documentation: https://docs.example.com
- Status Page: https://status.example.com

---

**Last Updated:** April 20, 2026  
**API Version:** v1.0  
**Current Model:** v2.1 (83% accuracy)
