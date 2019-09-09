#!/usr/bin/env bash

source venv/bin/activate

env FLASK_APP=flask-server/main.py flask run
