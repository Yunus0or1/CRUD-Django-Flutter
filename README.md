# CRUD-Django-Flutter

## Requirements
Create an APP that stores user data
- Data is composed of first name, last name, address (stree, city, state and zip)
- The app should create the following User types (Parent, Child) The child cannot have an address and Must belong to a parent
- App should have API to:
	Delete user data
	Create user data
	Update user data
	
   ```
   Front end is developed in Flutter, Backend APIs are developed in Python-Django
   ```
## Backend System
 - Install Django reading this [link](https://github.com/Yunus0or1/Guidelines-How_TO/blob/master/Django%20Basic%20Installation.md)
 - MySQL database is used
 - Go to crud_django/crud_django/urls.py to find out all API end point
 - All APIs end point execution resource can be found in crud_django/crud_code/views.py
 - When the server is loaded for the first time, database commit is executed once which can be found crud_django/crud_django/urls.py last lines

## Frontend System
 - Install Flutter reading this [link](https://github.com/Yunus0or1/Guidelines-How_TO/blob/master/Flutter%20Guidelines.md)
 - Visit lib/src/pages and lib/router.dart to find out all the related codes.


**To be noted, if a parent is deleted all the corresponding childred will be deleted automatically**
