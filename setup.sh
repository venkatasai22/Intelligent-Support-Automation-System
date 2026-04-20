#!/bin/bash
# Project Setup Script - Intelligent Support Automation System
# Run this to set up the project locally

set -e

echo "=========================================="
echo "Intelligent Support Automation System"
echo "Setup Script v2.1"
echo "=========================================="
echo ""

# Check Docker
echo "✓ Checking Docker..."
if ! command -v docker &> /dev/null; then
    echo "✗ Docker is not installed. Please install Docker."
    exit 1
fi
echo "✓ Docker found: $(docker --version)"

# Check Docker Compose
echo "✓ Checking Docker Compose..."
if ! command -v docker-compose &> /dev/null; then
    echo "✗ Docker Compose is not installed. Please install Docker Compose."
    exit 1
fi
echo "✓ Docker Compose found: $(docker-compose --version)"

echo ""
echo "=========================================="
echo "Starting Services..."
echo "=========================================="
echo ""

# Start services
echo "Starting Docker containers..."
docker-compose up -d

echo ""
echo "Waiting for services to be healthy..."
sleep 5

# Check API health
echo "✓ Checking API..."
API_HEALTH=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8000/api/v1/health)
if [ $API_HEALTH -eq 200 ]; then
    echo "✓ API is healthy"
else
    echo "✗ API health check failed (HTTP $API_HEALTH)"
fi

echo ""
echo "=========================================="
echo "Service URLs"
echo "=========================================="
echo ""
echo "API:        http://localhost:8000"
echo "Prometheus: http://localhost:9090"
echo "Grafana:    http://localhost:3000 (admin/admin)"
echo "Kibana:     http://localhost:5601"
echo "PostgreSQL: localhost:5432"
echo "Redis:      localhost:6379"
echo ""

echo "=========================================="
echo "Next Steps"
echo "=========================================="
echo ""
echo "1. Test the API:"
echo "   curl -X POST http://localhost:8000/api/v1/query \\"
echo "     -H 'Content-Type: application/json' \\"
echo "     -d '{\"query\": \"How do I reset my password?\"}'"
echo ""
echo "2. View dashboards:"
echo "   - Grafana:    http://localhost:3000"
echo "   - Prometheus: http://localhost:9090"
echo ""
echo "3. Run tests:"
echo "   python -m pytest tests/"
echo ""
echo "4. View logs:"
echo "   docker-compose logs -f api"
echo ""
echo "5. Read documentation:"
echo "   - QUICKSTART.md    - Quick reference"
echo "   - SETUP.md         - Detailed setup"
echo "   - PERFORMANCE.md   - Performance metrics"
echo "   - API.md           - API documentation"
echo ""

echo "=========================================="
echo "✓ Setup Complete!"
echo "=========================================="
