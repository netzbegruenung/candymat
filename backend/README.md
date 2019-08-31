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
Observe dummy data for http://127.0.0.1:5000/kandidaten

#### For Windows  
```set set FLASK_APP=flask-server/main.py```  
```flask run```