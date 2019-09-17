from flask import Flask

app = Flask(__name__)


@app.route('/api/')
def root():
    return "Candymat Data Backend"


@app.route('/api/fragen')
def fragen():
    with open('data/fragen.json', 'r') as json_file:
        return json_file.read()


@app.route('/api/kandidaten')
def kandidaten():
    with open('data/kandidaten.json', 'r') as json_file:
        return json_file.read()


@app.route('/api/kategorien')
def kategorien():
    with open('data/kategorien.json', 'r') as json_file:
        return json_file.read()
