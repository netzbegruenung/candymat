from flask import Flask

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


@app.route('/kategorien')
def kategorien():
    with open('data/kategorien.json', 'r') as json_file:
        return json_file.read()

@app.route('/antworten')
def antworten():
    with open('data/antworten.json','r') as json_file:
	    return json_file.read()
