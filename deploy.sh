#!/bin/bash

echo "🚀 Portfolio Deployment Script"
echo "================================"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Step 1: Push to GitHub
echo -e "${YELLOW}Step 1: Pushing to GitHub...${NC}"
echo ""

# Check if remote exists
if git remote | grep -q origin; then
    echo "Remote 'origin' already exists. Pushing..."
    git push -u origin main
else
    echo -e "${RED}Error: No remote repository configured.${NC}"
    echo "Please run:"
    echo "  git remote add origin https://github.com/sadaf-rad/portfolio.git"
    echo "  git push -u origin main"
    echo ""
    read -p "Press Enter to continue with the script setup..."
fi

echo ""
echo -e "${GREEN}✓ Code pushed to GitHub${NC}"
echo ""

# Step 2: Deploy Instructions
echo -e "${YELLOW}Step 2: Deploy Chatbot Backend to Render${NC}"
echo "=========================================="
echo ""
echo "1. Go to: https://dashboard.render.com/register"
echo "2. Sign up/Login (you can use your GitHub account)"
echo "3. Click 'New +' → 'Web Service'"
echo "4. Connect your GitHub repository: sadaf-rad/portfolio"
echo "5. Configure:"
echo "   • Name: portfolio-chatbot"
echo "   • Runtime: Python 3"
echo "   • Build Command: pip install -r requirements.txt"
echo "   • Start Command: python chatbot_api.py"
echo "6. Add Environment Variable:"
echo "   • Key: OPENROUTER_API_KEY"
echo "   • Value: [your API key]"
echo "7. Click 'Create Web Service'"
echo ""
echo "Your backend will be deployed at:"
echo "https://portfolio-chatbot-XXXX.onrender.com"
echo ""

read -p "Press Enter after you've deployed to Render and have your URL..."

# Step 3: Update API URL
echo ""
echo -e "${YELLOW}Step 3: Update Frontend API URL${NC}"
echo "================================="
echo ""
read -p "Enter your Render backend URL (e.g., https://portfolio-chatbot-XXXX.onrender.com): " BACKEND_URL

# Remove trailing slash if present
BACKEND_URL=${BACKEND_URL%/}

# Update script.js with the new API URL
sed -i.backup "s|const API_URL = 'http://localhost:5002/api/chat';|const API_URL = '${BACKEND_URL}/api/chat';|g" script.js

echo -e "${GREEN}✓ Updated script.js with backend URL${NC}"

# Commit and push changes
git add script.js
git commit -m "Update API URL to production backend"
git push origin main

echo ""
echo -e "${GREEN}✓ Changes pushed to GitHub${NC}"
echo ""

# Step 4: GitHub Pages
echo -e "${YELLOW}Step 4: Enable GitHub Pages${NC}"
echo "============================"
echo ""
echo "1. Go to: https://github.com/sadaf-rad/portfolio/settings/pages"
echo "2. Under 'Source':"
echo "   • Branch: main"
echo "   • Folder: / (root)"
echo "3. Click 'Save'"
echo "4. Wait 1-2 minutes for deployment"
echo ""
echo -e "${GREEN}Your portfolio will be live at:${NC}"
echo -e "${GREEN}🌐 https://sadaf-rad.github.io/portfolio/${NC}"
echo ""
echo "================================"
echo -e "${GREEN}✨ Deployment Complete! ✨${NC}"
echo "================================"
echo ""
echo "You can now share your portfolio:"
echo "• LinkedIn: Add to 'Contact Info' → Website"
echo "• CV Header: https://sadaf-rad.github.io/portfolio/"
echo "• Email Signature: Add as link"
echo ""
echo "All features are now live including:"
echo "✓ AI Chatbot"
echo "✓ Travel Map"
echo "✓ Responsive Design"
echo "✓ Dynamic Animations"
