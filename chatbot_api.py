import os
from flask import Flask, request, jsonify
from flask_cors import CORS
from openai import OpenAI

app = Flask(__name__)
CORS(app)  # Enable CORS for frontend communication

# Load resume content
try:
    # Try local file first, then fallback to original location
    try:
        with open("About_Me.txt", "r", encoding="utf-8") as f:
            resume_text = f.read()
    except FileNotFoundError:
        with open("/Users/sadaf/Desktop/DataScience-RoadMap/cvchat/About_Me.txt", "r", encoding="utf-8") as f:
            resume_text = f.read()
except FileNotFoundError:
    resume_text = "Resume file not found."

# Get OpenRouter API key
api_key = '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'

if not api_key:
    print("Warning: API key not configured")

# Initialize OpenAI client with OpenRouter
client = OpenAI(
    api_key=api_key,
    base_url="https://openrouter.ai/api/v1"
) if api_key else None

# Store conversation history per session
conversations = {}

SYSTEM_PROMPT = f"""You are answering questions in a formal yet natural way based on the following resume. Be creative and smart, and based on the information, answer some questions that may not be explicitly provided in the resume - you can make intelligent inferences. Be a bit funny but still professional, and showcase her creativity and intelligence without exaggerating. Use "she", "her", "Sadaf" naturally - don't mention her name in every sentence. Don't say "based on provided information" - be conversational, interactive, and human-like.

{resume_text}

Answer user questions briefly and directly, using only relevant information. Don't include unrelated details unless explicitly asked. If a question is unclear or not covered, reply with: "That's a great question! For more specific details about that, feel free to reach out to Sadaf directly through the contact section below." Keep responses concise and engaging."""

@app.route('/api/chat', methods=['POST'])
def chat():
    if not client:
        return jsonify({
            'error': 'API key not configured. Please set OPENROUTER_API_KEY environment variable.'
        }), 500
    
    try:
        data = request.json
        user_message = data.get('message', '')
        session_id = data.get('session_id', 'default')
        
        if not user_message:
            return jsonify({'error': 'No message provided'}), 400
        
        # Initialize conversation history for new sessions
        if session_id not in conversations:
            conversations[session_id] = [
                {"role": "system", "content": SYSTEM_PROMPT}
            ]
        
        # Add user message to conversation history
        conversations[session_id].append({"role": "user", "content": user_message})
        
        # Get response from OpenRouter
        response = client.chat.completions.create(
            model="mistralai/mistral-7b-instruct",
            messages=conversations[session_id],
            temperature=0.7,
            max_tokens=300
        )
        
        reply = response.choices[0].message.content
        
        # Clean up markdown formatting (remove underscores used for emphasis)
        reply = reply.replace('_', '')
        
        # Add assistant response to conversation history
        conversations[session_id].append({"role": "assistant", "content": reply})
        
        return jsonify({
            'response': reply,
            'session_id': session_id
        })
    
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/health', methods=['GET'])
def health():
    return jsonify({'status': 'ok', 'api_configured': client is not None})

if __name__ == '__main__':
    print("Starting chatbot API server...")
    print("Make sure OPENROUTER_API_KEY is set in your environment")
    port = int(os.environ.get('PORT', 5002))
    app.run(host='0.0.0.0', port=port, debug=False)

