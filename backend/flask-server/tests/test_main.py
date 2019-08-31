import json

from main import kandidaten, fragen, kategorien


def test_kandidaten():
    expected_result = [
        {
            "id": 0,
            "vorname": "Max",
            "name": "Mustermann",
            "email": "max.mustermann@yahoo.com"
        },
        {
            "id": 1,
            "vorname": "Erika",
            "name": "Mustermann",
            "email": "erika.mustermann@yahoo.com"
        }
    ]
    assert json.loads(kandidaten()) == expected_result


def test_fragen():
    expected_result = [
        {
            "id": 0,
            "text": "Dies ist eine Dummy Frage für Testzwecke",
            "kategorie_id": 0
        }
    ]

    assert json.loads(fragen()) == expected_result


def test_kategorien():
    expected_result = [{
        "id": 0,
        "name": "Umwelt"
    }, {
        "id": 1,
        "name": "Soziales"
    }]

    assert json.loads(kategorien()) == expected_result

def test_antworten():
	expected_result = ["test"]
	
	assert json.loads(antworten()) == expected_result
