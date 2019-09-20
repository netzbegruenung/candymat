# Candymat Backend

The backend providing the data and managing changing the data.

## Development setup
### Install
Run inside this folder
```
./dev-setup.sh
```

#### For conda users:
```conda create -n candymat-userapp-api python=3.7.4 flask=1.1.1```
```conda activate candymat-userapp-api```

### Run
Start the flask server locally under http://127.0.0.1:5000 with the follwing script:
```
./dev-start.sh
```
Observe dummy data for http://127.0.0.1:5000/api/kandidaten

#### For Windows
```set set FLASK_APP=flask-server/main.py```
```flask run```


# API Dokumentation
This is the API documentation for the candymat backend.
It documents all resources (soon to be) available.

## Overview
| Description | GET (all) | GET (single) | POST | PUT |
|---|---|---|---|---|
| candidates | /api/kandidaten | /api/kandidaten/3 | /api/kandidaten | /api/kandidaten/3 |
| categories for questions | /api/kategorien | /api/kategorien/2 | /api/kategorien | /api/kategorien/2 |
| questions | /api/fragen | /api/fragen/1 | /api/fragen | /api/fragen/1 |
| answers from all candidates | /api/antworten | | | |
| answers of a single candidate | /api/kandidaten/3/antworten | /api/kandidaten/3/antworten/2 | /api/kandidaten/3/antworten | /api/kandidaten/3/antworten/2 |

For some endpoints such as `/api/kandiaten` or `/answers` there are additional filter options.

## Kandidaten
### Get all candidates

#### Request
```
GET /api/kandidaten
```

#### Example Response
```
200 OK
Content-Type: application/json
```
```json
[
  {
    "id": 0,
    "login": "musterma",
    "vorname": "Max",
    "name": "Mustermann",
    "email": "max.mustermann@yahoo.com"
  },
  {
    "id": 1,
    "login": "musterer",
    "vorname": "Erika",
    "name": "Mustermann",
    "email": "erika.mustermann@yahoo.com"
  }
]
```

### Get the candidate with id `<id>` (not implemented yet)
#### Request
```
GET /api/kandidaten/<id>
```

#### Example Response
```
200 OK
Content-Type: application/json
```
```json
{
  "id": 0,
  "login": "musterma",
  "vorname": "Max",
  "name": "Mustermann",
  "email": "max.mustermann@yahoo.com"
}
```

### Get the canditates filtered by some key (not implemented yet)
In principle every available key can be used.
The filter consists of a key-value pair, e.g. `name=Mustermann`.
To concatenate filters, separeate them with `&`, e.g. `name=Mustermann&id=0`

#### Example Request
```
GET /api/kandidaten?name=Mustermann
```

#### Example Response
```
200 OK
Content-Type: application/json
```
```json
[
  {
    "id": 0,
    "login": "musterma",
    "vorname": "Max",
    "name": "Mustermann",
    "email": "max.mustermann@yahoo.com"
  },
  {
    "id": 1,
    "login": "musterer",
    "vorname": "Erika",
    "name": "Mustermann",
    "email": "erika.mustermann@yahoo.com"
  }
]
```

### Create a new candidate (not implemented yet)
#### Request
```
POST /api/kandidaten
Content-Type: application/json
```
```json
{
  "login": "musterki",
  "vorname": "Kind",
  "name": "Mustermann",
  "email": "kind.mustermann@yahoo.com"
}
```
Only `"login"` is required, the other keys are optional.
Additional `"key"`s (including `"id"`) are ignored.

#### Example Response
```
201 OK
Content-Type: application/json
```
```json
{
  "id": 2,
  "login": "musterki",
  "vorname": "Kind",
  "name": "Mustermann",
  "email": "kind.mustermann@yahoo.com"
}
```

### Alter information of the candidate with id `<id>` (not implemented yet)
#### Request
```
PUT /api/kandidaten/<id>
Content-Type: application/json
```
```json
{
  "email": "kind.mustermann@gmx.com"
}
```
The keys `"id"` and `"login"` are immutable.

#### Example Response
```
200 OK
Content-Type: application/json
```
```json
{
  "id": 2,
  "login": "musterki",
  "vorname": "Kind",
  "name": "Mustermann",
  "email": "kind.mustermann@gmx.com"
}
```

## Kategorien
### Get all categories

#### Request
```
GET /api/kategorien
```

#### Example Response
```
200 OK
Content-Type: application/json
```
```json
[
  {
    "id": 0,
    "name": "Umwelt"
  },
  {
    "id": 1,
    "name": "Soziales"
  }
]
```

### Get the category with id `<id>` (not implemented yet)
#### Request
```
GET /api/kategorien/<id>
```

#### Example Response
```
200 OK
Content-Type: application/json
```
```json
{
  "id": 0,
  "name": "Umwelt",
}
```

### Create a new category (not implemented yet)
#### Request
```
POST /api/kategorien
Content-Type: application/json
```
```json
{
  "name": "Digitales",
}
```

#### Example Response
```
201 OK
Content-Type: application/json
```
```json
{
  "id": 2,
  "name": "Digitales",
}
```

## Fragen
### Get all questions

#### Request
```
GET /api/fragen
```

#### Example Response
```
200 OK
Content-Type: application/json
```
```json
[
  {
    "id": 0,
    "text": "Dies ist eine Dummy Frage für Testzwecke",
    "kategorie": {
      "id": 0,
      "name": "Umwelt"
    }
  },
  {
    "id": 1,
    "text": "Eine weitere Testfrage",
    "kategorie": {
      "id": 1,
      "name": "Soziales"
    }
  }
]
```

### Get the question with id `<id>` (not implemented yet)
#### Request
```
GET /api/fragen/<id>
```

#### Example Response
```
200 OK
Content-Type: application/json
```
```json
{
  "id": 1,
  "text": "Eine weitere Testfrage",
  "kategorie": {
    "id": 0,
    "name": "Soziales"
  }
}
```

### Get questions filtered by category (not implemented yet)
#### Request
```
GET /api/fragen?kategorie=<category_id>
```

#### Example Response
```
200 OK
Content-Type: application/json
```
```json
[
  {
    "id": 0,
    "text": "Dies ist eine Dummy Frage für Testzwecke",
    "kategorie": {
      "id": 0,
      "name": "Umwelt"
    }
  }
]
```

### Create a new question (not implemented yet)
#### Request
```
POST /api/fragen
Content-Type: application/json
```
```json
{
  "text": "Dies ist noch eine Dummy Frage für Testzwecke",
  "kategorie_id": 0,
}
```

#### Example Response
```
201 OK
Content-Type: application/json
```
```json
{
  "id": 2,
  "text": "Dies ist noch eine Dummy Frage für Testzwecke",
  "kategorie": {
      "id": 0,
      "name": "Umwelt"
  }
}
```

### Alter the question with id `<id>` (not implemented yet)
#### Request
```
PUT /api/fragen/<id>
Content-Type: application/json
```
```json
{
  "text": "Dies ist eine geaenderte Dummy Frage",
  "kategorie_id": 0,
}
```

#### Example Response
```
200 OK
Content-Type: application/json
```
```json
{
  "id": 2,
  "text": "Dies ist eine geaenderte Dummy Frage",
  "kategorie": {
      "id": 3,
      "name": "Digitales"
  }
}
```

## Antworten
This represents the answers of the candidates to the questions.
Each answer consists of two parts:
1. The position: `-1`, `0`, `1` (negative, neutral, positive)
2. The statement: Some (optional) additional context the candidate gave on the question.

### Get all answers from every candidate

#### Request
```
GET /api/antworten
```

#### Example Response
```
200 OK
Content-Type: application/json
```
```json
[
  {
    "id": 0,
    "kandidat": {
      "id": 0,
      "login": "musterma",
      "vorname": "Max",
      "name": "Mustermann",
      "email": "max.mustermann@yahoo.com"
    },
    "frage": {
      "id": 0,
      "text": "Dies ist eine Dummy Frage für Testzwecke",
      "kategorie": {
        "id": 0,
        "name": "Umwelt"
      }
    },
    "position": -1,
    "statement": "Lorem ipsum"
  },
  {
    "id": 1,
    "kandidat": {
      "id": 0,
      "login": "musterma",
      "vorname": "Max",
      "name": "Mustermann",
      "email": "max.mustermann@yahoo.com"
    },
    "frage": {
      "id": 1,
      "text": "Eine weitere Testfrage",
      "kategorie": {
        "id": 1,
        "name": "Soziales"
      }
    },
    "position": 1,
    "statement": "Lorem ipsum"
  }
]
```

### Get answers filtered by question and/or candidate (not implemented yet)
To filter for a question with id `<question_id>` append `?frage=<question_id>` to the URI.
To filter for a candidate with id `<candidate_id>` to key-value pair is `kandidat=<candidate_id>`.
To use both filters at the same time concatinate them with an `&`.
The ordering of the filters in unimportant.


#### Example Request
```
GET /api/antworten?frage=1&kandidat=0
```

#### Example Response
```
200 OK
Content-Type: application/json
```
```json
[
  {
    "id": 1,
    "kandidat": {
      "id": 0,
      "login": "musterma",
      "vorname": "Max",
      "name": "Mustermann",
      "email": "max.mustermann@yahoo.com"
    },
    "frage": {
      "id": 1,
      "text": "Eine weitere Testfrage",
      "kategorie": {
        "id": 1,
        "name": "Soziales"
      }
    },
    "position": 1,
    "statement": "Lorem ipsum"
  },
]
```

### Get answers of candidate with id `<candidate_id>`(not implemented yet)
To get the answers of a single candidate it is also possible to use the API endpoint `/api/kandidaten/<candidate_id>/answers`.
This reflects the philosophy that answers belong first and foremost to the candidate.
There is a difference in the response though:
The `"kandidat"` key is missing.

It is possible to get the answer for a specific question with the respective querry parameter,
e.g. `/api/kandidaten/<candidate_id>/antworten?frage=0`

#### Example Request
```
GET /kandidaten/<candidate_id>/antworten
```

#### Example Response
```
200 OK
Content-Type: application/json
```
```json
[
  {
    "id": 0,
    "frage": {
      "id": 0,
      "text": "Dies ist eine Dummy Frage für Testzwecke",
      "kategorie": {
        "id": 0,
        "name": "Umwelt"
      }
    },
    "position": -1,
    "statement": "Lorem ipsum"
  },
  {
    "id": 1,
    "frage": {
      "id": 1,
      "text": "Eine weitere Testfrage",
      "kategorie": {
        "id": 1,
        "name": "Soziales"
      }
    },
    "position": 1,
    "statement": "Lorem ipsum"
  }
]
```

### Get the answer with id `<answer_id>` of candidate with id `<candidate_id>` (not implemented yet)
#### Request
```
GET /api/kandiaten/<candidate_id>/antworten/<answer_id>
```

#### Example Response
```
200 OK
Content-Type: application/json
```
```json
{
  "id": 0,
  "frage": {
    "id": 0,
    "text": "Dies ist eine Dummy Frage für Testzwecke",
    "kategorie": {
      "id": 0,
      "name": "Umwelt"
    }
  },
  "position": -1,
  "statement": "Lorem ipsum"
}
```

### Create a new answer for candidate with id <candidate_id> (not implemented yet)
#### Request
```
POST /api/kandidaten/<candidate_id>/antworten
Content-Type: application/json
```
```json
{
  "question_id": 2,
  "position": 1,
  "statement": "Lorem ipsum ....."
}
```
The key `"statement"` is optional.

#### Example Response
```
201 OK
Content-Type: application/json
```
```json
{
  "id": 3,
  "frage": {
    "id": 2,
    "text": "Dies ist noch eine Dummy Frage für Testzwecke",
    "kategorie": {
      "id": 0,
      "name": "Umwelt"
    }
  },
  "position": 1,
  "statement": "Lorem ipsum ....."
}
```

### Alter the answer with id <answer_id> of candidate with the id `<candidate_id>` (not implemented yet)
#### Request
```
PUT /api/kandidaten/<candidate_id>/antworten/<answer_id>
Content-Type: application/json
```
```json
{
  "position": 0,
  "statement": "Hab's mir anders ueberlegt..."
}
```

#### Example Response
```
200 OK
Content-Type: application/json
```
```json
{
  "id": 3,
  "frage": {
    "id": 2,
    "text": "Dies ist noch eine Dummy Frage für Testzwecke",
    "kategorie": {
      "id": 0,
      "name": "Umwelt"
    }
  },
  "position": 0,
  "statement": "Hab's mir anders ueberlegt..."
}
```
