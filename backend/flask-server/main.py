from flask import Flask, escape, request
import json
import os

app = Flask(__name__)

@app.route('/')
def root():
    return "Candymat Data Backend"


@app.route('/fragen')
def fragen():
    with open('data/fragen.json', 'r') as json_file:
        return json_file.read()


@app.route('/kandidaten')
def kandidaten():
    with open('data/kandidaten.json', 'r') as json_file:
        return json_file.read()
