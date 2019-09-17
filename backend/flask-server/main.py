from flask import Flask
from flask import request
import json

#########
# Helper Functions

def get_kat_n(k_id):
    with open('data/kategorien.json', 'r', encoding="utf-8") as json_file:
        kategorien = json.load(json_file)
        
        for kategorie in kategorien:
            if json.dumps(kategorie["id"]) == k_id:
                return kategorie["name"]


app = Flask(__name__)

@app.route('/api/')
def root():
    return "Candymat Data Backend"


@app.route('/api/fragen')
def fragen():
    with open('data/fragen.json', 'r', encoding="utf-8") as json_file:
        fragen = json.load(json_file)
        
    # Get the url Request Parameter "kat_id"
    kat_id = request.args.get('kat_id')
    
    if kat_id == None:
        answer = []
        
        for frage in fragen:
            frage.update({"kategorie_name": get_kat_n(json.dumps(frage["kategorie_id"]))})
            frage.pop("kategorie_id")
            answer.append(frage)
        return json.dumps(answer)
    else:
        answer = []
        for frage in fragen:
            if json.dumps(frage["kategorie_id"]) == kat_id:
                frage.update({"kategorie_name": get_kat_n(json.dumps(frage["kategorie_id"]))})
                frage.pop("kategorie_id")
                answer.append(frage)
        return json.dumps(answer)


@app.route('/api/kandidaten')
def kandidaten():
    with open('data/kandidaten.json', 'r') as json_file:
        return json_file.read()


@app.route('/api/kategorien')
def kategorien():
    with open('data/kategorien.json', 'r') as json_file:
        return json_file.read()

@app.route('/api/antworten')
def antworten():
    with open('data/antworten.json','r') as json_file:
	    return json_file.read()
