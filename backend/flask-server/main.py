from flask import Flask
from flask import request
import json

app = Flask(__name__)


@app.route('/')
def root():
    return "Candymat Data Backend"


@app.route('/fragen/')
def fragen():
    with open('data/fragen.json', 'r', encoding="utf-8") as json_file:
        fragen = json.load(json_file)
        
    # Get the url Request Parameter "kat_id"
    kat_id = request.args.get('kat_id')
    
    if kat_id == None:
        return json.dumps(fragen)
    else:
        answer = []
        for frage in fragen:
            if json.dumps(frage["kategorie_id"] )== kat_id:
                answer.append(frage)
        return json.dumps(answer)


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
