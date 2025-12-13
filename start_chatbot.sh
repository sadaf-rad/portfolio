#!/bin/bash

# Chatbot API Startup Script

echo "🚀 Starting Sadaf's Personal Website Chatbot API"
echo "================================================"
echo ""

# Check if OPENROUTER_API_KEY is set
if [ -z "$OPENROUTER_API_KEY" ]; then
    echo "⚠️  Warning: OPENROUTER_API_KEY environment variable is not set!"
    echo ""
    echo "To set your API key, run:"
    echo "export OPENROUTER_API_KEY='your-api-key-here'"
    echo ""
    echo "Get your free API key at: https://openrouter.ai/keys"
    echo ""
    read -p "Do you want to continue anyway? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Error: Python 3 is not installed"
    exit 1
fi

echo "📦 Checking dependencies..."

# Check if virtual environment exists, create if not
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Install requirements
echo "Installing requirements..."
pip install -q -r requirements.txt

echo ""
echo "✅ All dependencies installed"
echo ""
echo "🌐 Starting Flask API server on http://localhost:5000"
echo "📝 Make sure to open index.html in your browser"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Start the Flask app
python chatbot_api.py
