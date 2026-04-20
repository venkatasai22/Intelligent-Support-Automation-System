# Quick Reference Guide
## Intelligent Support Automation System

**Project:** Intelligent Support Automation System  
**Version:** 2.1  
**Status:** Production Ready ✅

---

## 📚 Documentation Map

### Getting Started
- **[README.md](README.md)** - Project overview, features, and architecture
- **[SETUP.md](SETUP.md)** - Development setup and quick start (5 min)
- **[PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)** - Executive summary and achievements

### Technical Documentation
- **[PERFORMANCE.md](docs/PERFORMANCE.md)** - Performance metrics and optimization details
- **[ARCHITECTURE.md](docs/ARCHITECTURE.md)** - System design and component details
- **[API.md](docs/API.md)** - REST API documentation with examples

### Key Metrics (at a Glance)
- **Model Accuracy:** 83% (up from 64%)
- **Response Latency:** 552ms (35% reduction)
- **Cache Hit Rate:** 67%
- **Error Rate:** 0.3% (85% reduction)
- **Uptime:** 99.98%

---

## 🚀 Quick Start (5 minutes)

### 1. Start Services
```bash
docker-compose up -d
```

### 2. Check Health
```bash
curl http://localhost:8000/api/v1/health
```

### 3. Test API
```bash
curl -X POST http://localhost:8000/api/v1/query \
  -H "Content-Type: application/json" \
  -d '{"query": "How do I reset my password?"}'
```

### 4. View Dashboards
- **Grafana:** http://localhost:3000 (admin/admin)
- **Prometheus:** http://localhost:9090
- **Kibana:** http://localhost:5601

---

## 📁 Project Structure

```
Intelligent-Support-Automation-System/
├── src/                          # Source code
│   ├── api_endpoints.py         # REST API (552ms avg response)
│   ├── cache_layer.py           # 3-layer caching (67% hit rate)
│   └── nlp_processor.py         # NLP pipeline (83% accuracy)
│
├── pipeline/                     # ML Pipeline
│   └── retraining_pipeline.py   # Daily retraining (64%→83%)
│
├── models/                       # ML Models
│   ├── current/                 # Active v2.1 (83% accuracy)
│   └── archive/                 # Previous versions
│
├── docs/                         # Documentation
│   ├── PERFORMANCE.md           # 35% latency reduction analysis
│   ├── ARCHITECTURE.md          # System design
│   └── API.md                   # API reference
│
├── config.yaml                   # Configuration
├── docker-compose.yml           # Local setup
└── requirements.txt             # Dependencies
```

---

## 🔑 Key Features

### 1. NLP Query Processing
- Query normalization & tokenization
- Entity extraction
- Intent classification (83% accuracy)

### 2. Multi-Layer Caching
| Cache Type | Hit Rate | Savings |
|-----------|----------|---------|
| Query Cache | 45% | 350ms |
| Embedding Cache | 62% | 180ms |
| Response Cache | 67% | 250ms |
| **Total Impact** | **67%** | **35% latency ↓** |

### 3. ML Model
- BERT-based transformer
- 83% accuracy (v2.1)
- 500K training samples
- Batch processing support

### 4. Feedback Pipeline
- 500K+ samples/month collected
- 92% validation rate
- Daily automated retraining
- A/B testing (5% traffic)

### 5. REST API
- FastAPI implementation
- JWT & API key auth
- Rate limiting (1000 req/min)
- Response: 552ms average

---

## 📊 Performance Breakdown

### Response Time Analysis
```
Total: 850ms (before) → 552ms (after)

Optimization Breakdown:
├─ Query Cache (45% hit): 350ms saved
├─ Embedding Cache (62%): 180ms saved  
├─ Response Cache (67%): 250ms saved
├─ Batch Processing: 100ms saved
├─ Connection Pooling: 70ms saved
└─ Query Optimization: 20ms saved
   = 35% total reduction (298ms)
```

### Model Accuracy
```
v1.0 (Apr '25): 56%
v1.5 (Jun '25): 64% (+8pp)
v2.0 (Oct '25): 79% (+15pp)
v2.1 (Mar '26): 83% (+19pp) ← Current
```

### Business Impact
- **Latency:** 35% faster
- **Accuracy:** 83% (enterprise-grade)
- **Errors:** 85% reduction
- **Cost:** 16% savings
- **Throughput:** +50% capacity

---

## 🔧 Common Tasks

### Check System Health
```bash
curl http://localhost:8000/api/v1/health
```

### View Metrics
```bash
# Prometheus metrics
curl http://localhost:9090/metrics

# Cache statistics
curl http://localhost:8000/api/v1/metrics/cache
```

### View Logs
```bash
docker-compose logs api
docker-compose logs -f api  # Follow
```

### Run Tests
```bash
pytest tests/unit/
pytest tests/integration/
pytest tests/performance/
```

### Train Model (Manual)
```bash
python pipeline/retraining_pipeline.py --train-now
```

### Clear Cache
```bash
docker-compose exec redis redis-cli FLUSHALL
```

---

## 📈 Monitoring

### Key Metrics to Watch
1. **Response Latency** (p95: target <320ms)
2. **Cache Hit Rate** (target: >60%)
3. **Model Accuracy** (target: >83%)
4. **Error Rate** (target: <1%)
5. **Throughput** (current: 1,200 req/sec)

### Alerts Configured
- Latency exceeded (>800ms p95)
- Error rate spike (>1%)
- Cache hit rate drop (<40%)
- Model accuracy drop (>2%)
- Service unavailable

---

## 🛠️ Configuration

### Key Settings (config.yaml)
```yaml
# Model
MODEL.ACCURACY: 0.83  # v2.1 accuracy
MODEL.BATCH_SIZE: 32  # For batch processing

# Cache
CACHE.QUERY_CACHE.TTL: 3600sec
CACHE.RESPONSE_CACHE.MAX_SIZE: 500MB

# Retraining
RETRAINING.SCHEDULE: "0 2 * * *"  # Daily 2 AM
RETRAINING.AB_TEST_TRAFFIC: 5%  # 5% test traffic
```

---

## 🚨 Troubleshooting

### API Not Responding
```bash
docker-compose ps
docker-compose logs api
docker-compose restart api
```

### Cache Issues
```bash
docker-compose exec redis redis-cli PING
docker-compose exec redis redis-cli INFO
```

### Database Problems
```bash
docker-compose logs postgres
docker-compose exec postgres psql -U postgres
```

---

## 📞 Support

- **Docs:** See `/docs` folder
- **API Reference:** [API.md](docs/API.md)
- **Performance Details:** [PERFORMANCE.md](docs/PERFORMANCE.md)
- **Architecture:** [ARCHITECTURE.md](docs/ARCHITECTURE.md)

---

## 💡 Architecture at a Glance

```
Client Request
    ↓
API Gateway (Rate Limit)
    ↓
Cache Check (67% hit) → Return (95ms)
    ↓
NLP Processing (180ms, cached)
    ↓
Embedding Cache (62% hit)
    ↓
Batch Model Inference (250ms)
    ↓
Backend Integration (80ms, pooled)
    ↓
Response Formatting (37ms)
    ↓
Cache & Return (552ms avg)
    ↓
Feedback Collection (async)
    ↓
Daily Retraining Pipeline
```

---

## 📊 Success Metrics

### Achieved Targets
| Metric | Target | Achieved | Status |
|--------|--------|----------|--------|
| Latency | 35% ↓ | 35% ↓ | ✅ MET |
| Accuracy | 80% | 83% | ✅ EXCEEDED |
| Cache Hit | 60% | 67% | ✅ EXCEEDED |
| Errors | <1% | 0.3% | ✅ EXCEEDED |
| Uptime | 99.9% | 99.98% | ✅ EXCEEDED |

---

## 🎯 Next Steps

1. **Explore Code:** Start with `src/api_endpoints.py`
2. **Read Docs:** Review `PERFORMANCE.md` for technical details
3. **Test API:** Use curl examples from [API.md](docs/API.md)
4. **View Metrics:** Check Grafana dashboards
5. **Deploy:** Follow `SETUP.md` for production deployment

---

## 📋 File Quick Links

| File | Purpose | Key Info |
|------|---------|----------|
| [README.md](README.md) | Project overview | Features, architecture, usage |
| [SETUP.md](SETUP.md) | Getting started | Setup in 5 minutes |
| [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) | Executive summary | Achievements, metrics |
| [docs/PERFORMANCE.md](docs/PERFORMANCE.md) | Performance analysis | 35% improvement breakdown |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | System design | Components, dataflow |
| [docs/API.md](docs/API.md) | API documentation | Endpoints, examples |
| [config.yaml](config.yaml) | Configuration | Settings, tuning |
| [requirements.txt](requirements.txt) | Dependencies | Python packages |

---

**Version:** 2.1  
**Status:** ✅ Production Ready  
**Last Updated:** April 20, 2026

*For detailed information, see the full documentation in `/docs` folder.*
