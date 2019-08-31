import json

from main import kandidaten, fragen, kategorien, antworten


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
            "frage_text": "Dies ist eine Dummy Frage für Testzwecke",
            "kategorie_name": "Umwelt"
        },
        {
            "id": 1,
            "frage_text": "Eine weitere Testfrage",
            "kategorie_name": "Umwelt"
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
	expected_result = [{
        {
            "id": 0,
            "kandidat_vorname": "Max",
            "kandidat_name": "Mustermann",
            "kandidat_email": "max.mustermann@yahoo.com"
            "frage_text": "Dies ist eine Dummy Frage für Testzwecke",
            "kategorie_name": "Umwelt",
            "antwort_text": "Lorem ipsum"
        },
        {
            "id": 1,
            "kandidat_vorname": "Max",
            "kandidat_name": "Mustermann",
            "kandidat_email": "max.mustermann@yahoo.com"
            "frage_text": "Eine weitere Testfrage"
            "kategorie_name": "Umwelt",
            "antwort_text": "Lorem ipsum..."
        }
    }]
	
	assert json.loads(antworten()) == expected_result
