from flask import Flask, jsonify

app = Flask(__name__)

@app.get("/")
def home():
    return "<h1>Hello from YOUR-NAME</h1><p>Version 1</p>"

@app.get("/healthz")
def healthz():
    return jsonify(status="ok")
