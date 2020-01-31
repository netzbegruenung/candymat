# Candymat - Wahl-o-Mat fuer Personalwahlen

## Development Setup

### Check-out repository
* [Install git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* `git clone https://github.com/netzbegruenung/candymat.git`
* To get the (external) user-app source:
  ```
  git submodule init
  git submodule update
  ```

### Start backend

* ```docker-compose up -d```
* Point browser to http://localhost:5000/graphiql for testing queries and documentation of nodes and http://localhost:5000/graphql for graphQL endpoint
