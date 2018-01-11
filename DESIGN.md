# Programmeerproject

### Design Document 
###### Created by Jet van den Berg

## Het ontwerp van de app:
![](doc/Design%20Document.jpg)

## Utility modules, classes en functions:
#### Classes:
###### LoginViewController
- login button - login()
- sign up button - signup()
###### OverviewTableViewController
- [Animals]
###### DetailsViewController
- [ObjectDetails]
- addObject()
###### FavoritesTableViewController
- addObject()
- deleteObject()
###### AddObjectViewController
- addObject()
###### UsersOverviewTableViewController
- [Users]
###### UserDetailsTableViewController
- [UserDetails]
###### ChatViewController
- [ChatHistory]
- sendMessage()


#### Favorites Database:
* [favorites]
* addObject()
* deleteObject()

#### UsersDatabase:
* [users]
* [ChatHistory]
* sendMessage()

## API's en frameworks
* Lost, found, adoptable pets: https://data.sonomacounty.ca.gov/Government/Animal-Shelter-Intake-and-Outcome/924a-vesw (API: https://data.kingcounty.gov/resource/murn-chih.json)
* Animal Shelter Intake and Outcome API: https://data.kingcounty.gov/Pets/Lost-found-adoptable-pets/yaai-7frk (API: https://data.sonomacounty.ca.gov/resource/nzbr-wh3q.json)
* Dog CEO API: https://dog.ceo/dog-api/#all
* The Dog API: https://www.thedogapi.co.uk/
* Giphy API: https://developers.giphy.com/docs/

## Data sources
* Firebase Database
* Firebase Authentication
* Firebase Storage

## Database tables en fields (en types)
#### Favorites Database (Firebase Database en Firebase Storage:
CurrentUser (email):
* animal_id: String
* animal_type: String
* animal_breed: String
* animal_gender: String
* age: String
* city: String
* current_location: String
* link: URL

#### UsersDatabase:
User:
* id: String
* email: String
* password: String

#### ChatDatabase:
CurrentUser (email):
* user: String
* messageSent: String
* messageReceived: String
