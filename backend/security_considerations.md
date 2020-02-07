## Basic security

Testing the security of the backend is substantial for obvious reasons. Write automated penetration tests.
There should be testcases for


| table      | editor | candidate | user(v) | user | other |
|------------|--------|-----------|---------|------|-------|
| person     | sdU    | sDU       | sDU     |      |       |
| account    | S      | S         | S       | S    |       | not sure about this
| answer     | s      | sDUI      | s       |      |       |
| question   | sdui   | s         | s       |      |       |
| categories | sdui   | s         | s       |      |       |


| function     | editor | candidate | user(v) | user | other |
|--------------|--------|-----------|---------|------|-------|
| register     |        |           |         |      | E     |
| authenticate | E      | E         | E       | E    |       |
| change pw    | E      | E         | E       |      |       |
| change role  | e      |           |         |      |       |

where
* s: select
* d: delete
* u: update
* i: insert
* e: execute

An uppercase version of the above letters means that the operation is only possible on rows directly related to the user id, e.g. a candidate can only delete, update and insert the own answer(s).

## Passwords
DO NOT LOG THE PASSWORDS
postgres logging conf may need adoption to NOT log passwords in plain text. 
