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

## Kandidaten
### Get all candidates

#### Request
```
GET /kandidaten
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
GET /kandidaten/<id>
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
GET /kandidaten?name=Mustermann
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
POST /kandidaten
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
PUT /kandidaten/<id>
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
