## 🚀 Deployment Instructions

### Option 1: GitHub Pages (Static Site Only)

Your portfolio is ready to deploy to GitHub Pages! The chatbot will need separate hosting.

**Steps:**

1. **Create GitHub Repository**
   - Go to https://github.com/new
   - Name: `portfolio`
   - Description: "Personal portfolio website with AI chatbot"
   - Visibility: **Public** (required for free GitHub Pages)
   - **Don't** initialize with README
   - Click "Create repository"

2. **Push Your Code**
   ```bash
   cd /Users/sadaf/Desktop/test
   git remote add origin https://github.com/sadaf-rad/portfolio.git
   git push -u origin sadaf
   ```

3. **Enable GitHub Pages**
   - Go to repository Settings → Pages
   - Source: Deploy from branch `sadaf`
   - Folder: `/ (root)`
   - Save
   
4. **Access Your Site**
   - Live at: `https://sadaf-rad.github.io/portfolio/`
   - May take 1-2 minutes to deploy

---

### Option 2: Deploy Chatbot Backend

The chatbot requires a backend server. Here are free hosting options:

#### A. Render.com (Recommended)

1. Create account at https://render.com
2. New → Web Service
3. Connect your GitHub repository
4. Settings:
   - Build Command: `pip install -r requirements.txt`
   - Start Command: `python chatbot_api.py`
   - Add Environment Variable: `OPENROUTER_API_KEY`
5. Deploy
6. Update `script.js` line ~300:
   ```javascript
   const API_URL = 'https://your-app.onrender.com/api/chat';
   ```

#### B. Railway.app

1. Sign up at https://railway.app
2. New Project → Deploy from GitHub
3. Add Environment Variable: `OPENROUTER_API_KEY`
4. Railway auto-detects Python and deploys
5. Update API_URL in script.js

#### C. Vercel (Serverless)

1. Install Vercel CLI: `npm i -g vercel`
2. Create `api/chat.py` (serverless function)
3. Run: `vercel --prod`
4. Add environment variables in Vercel dashboard

---

### Option 3: Full Stack Hosting

Deploy everything together:

**Netlify:**
- Connect GitHub repo
- Build settings: none (static site)
- Deploy
- Use Netlify Functions for backend

**Heroku:**
```bash
heroku create sadaf-portfolio
heroku config:set OPENROUTER_API_KEY=your-key
git push heroku sadaf:main
```

---

### 📋 Pre-Deployment Checklist

- [ ] Remove or secure API key from `chatbot_api.py`
- [ ] Test site locally one more time
- [ ] Update contact email if needed
- [ ] Verify all links work
- [ ] Check mobile responsiveness
- [ ] Update README with live URL

---

### 🔧 Configuration Files

For GitHub Pages deployment, you may want to add:

**`CNAME` file** (if using custom domain):
```
yourdomain.com
```

**`.nojekyll` file** (prevents Jekyll processing):
```bash
touch .nojekyll
git add .nojekyll
git commit -m "Add .nojekyll"
```

---

### 🛠️ Troubleshooting

**Chatbot not working on GitHub Pages?**
- GitHub Pages only hosts static files
- Deploy backend separately (see Option 2)

**404 errors?**
- Ensure repository is public
- Check GitHub Pages settings
- Verify branch name is correct

**Styles not loading?**
- Check file paths are relative
- Clear browser cache

---

### 🎯 Quick Start

If you just want to get it live quickly:

1. Create repo on GitHub
2. Push code (commands above)
3. Enable GitHub Pages in repo settings
4. Share: `https://sadaf-rad.github.io/portfolio/`

*Note: Chatbot will be disabled until backend is deployed separately*
