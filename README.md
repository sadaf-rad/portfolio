# Sadaf Esmaili Rad - Personal Portfolio Website

A modern, professional portfolio website with an integrated AI chatbot powered by your resume data.

## Features

- 🎨 Modern, clean UI with professional design
- 🤖 AI-powered chatbot using OpenRouter API
- 📱 Fully responsive design
- ✨ Smooth animations and interactions
- 💬 Interactive chat interface
- 🎯 Professional profile sections

## Setup Instructions

### Prerequisites

- Python 3.8 or higher
- A modern web browser
- OpenRouter API key (get it free at https://openrouter.ai/keys)

### Installation

1. **Set your OpenRouter API key:**
   ```bash
   export OPENROUTER_API_KEY='your-api-key-here'
   ```
   
   To make it permanent, add it to your `~/.zshrc` or `~/.bash_profile`:
   ```bash
   echo 'export OPENROUTER_API_KEY="your-api-key-here"' >> ~/.zshrc
   source ~/.zshrc
   ```

2. **Start the chatbot API server:**
   ```bash
   ./start_chatbot.sh
   ```
   
   Or manually:
   ```bash
   # Create virtual environment
   python3 -m venv venv
   source venv/bin/activate
   
   # Install dependencies
   pip install -r requirements.txt
   
   # Start the server
   python chatbot_api.py
   ```

3. **Open the website:**
   - Open `index.html` in your browser, or
   - Run: `open index.html`

## How It Works

### Architecture

```
┌─────────────────┐         ┌──────────────────┐         ┌─────────────────┐
│   Browser       │         │   Flask API      │         │  OpenRouter AI  │
│  (index.html)   │ ◄─────► │ (chatbot_api.py) │ ◄─────► │   (Mistral 7B)  │
│                 │  HTTP   │                  │  API    │                 │
└─────────────────┘         └──────────────────┘         └─────────────────┘
                                     │
                                     │ Reads
                                     ▼
                            ┌──────────────────┐
                            │   About_Me.txt   │
                            │  (Your Resume)   │
                            └──────────────────┘
```

### Components

1. **Frontend (HTML/CSS/JS)**
   - Modern, professional design
   - Interactive chatbot UI
   - Smooth animations and effects
   - Particle background animation

2. **Backend (Flask API)**
   - Handles chat requests
   - Manages conversation history
   - Integrates with OpenRouter API
   - CORS enabled for local development

3. **AI Integration**
   - Uses Mistral 7B Instruct model (free tier)
   - Contextual responses based on your resume
   - Maintains conversation context
   - Natural, professional tone

## API Endpoints

### `POST /api/chat`
Send a message to the chatbot.

**Request:**
```json
{
  "message": "What are Sadaf's skills?",
  "session_id": "unique-session-id"
}
```

**Response:**
```json
{
  "response": "She specializes in Python, Machine Learning...",
  "session_id": "unique-session-id"
}
```

### `GET /api/health`
Check API server status.

**Response:**
```json
{
  "status": "ok",
  "api_configured": true
}
```

## Customization

### Update Your Information

Edit the content in these sections of `index.html`:
- **Hero Section**: Name, title, description
- **About Section**: Your bio and stats
- **Experience Section**: Your work history
- **Skills Section**: Your technical skills
- **Contact Section**: Your contact information

### Update Resume Data

The chatbot reads from `/Users/sadaf/Desktop/DataScience-RoadMap/cvchat/About_Me.txt`. Update that file with your latest information, and the chatbot will use it automatically.

### Styling

All styles are in `styles.css`. Key variables are defined in `:root`:
- Colors: `--primary-color`, `--accent-color`
- Spacing, shadows, and more

## Troubleshooting

### Chatbot not responding

1. Make sure the API server is running (you should see "Running on http://localhost:5000")
2. Check that `OPENROUTER_API_KEY` is set: `echo $OPENROUTER_API_KEY`
3. Check browser console for errors (F12 → Console)

### CORS errors

Make sure you're accessing the website through a proper HTTP server or file:// protocol. The API has CORS enabled for local development.

### API Key issues

Get a free API key at https://openrouter.ai/keys and set it:
```bash
export OPENROUTER_API_KEY='your-key-here'
```

## Technologies Used

- **Frontend**: HTML5, CSS3, JavaScript (ES6+)
- **Backend**: Python, Flask, Flask-CORS
- **AI**: OpenRouter API, Mistral 7B Instruct
- **Design**: Custom CSS with modern animations

## License

Personal portfolio website - all rights reserved.

## Contact

- Email: sadaf@example.com
- GitHub: [Your GitHub]
- LinkedIn: [Your LinkedIn]

---

Made with ❤️ by Sadaf Esmaili Rad
