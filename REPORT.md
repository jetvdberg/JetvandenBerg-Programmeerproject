# Report

### 'Love Me Adopt Me'
###### Created by Jet van den Berg

Deze app toont dieren uit een dierenasiel, die geadopteerd kunnen worden. Details over de dieren, gegevens van dierenasiel en andere gebruikers en hun lijsten kunnen bekeken worden.

<img src="https://github.com/jetvdberg/Programmeerproject/blob/master/doc/IMG_2391.PNG" width="500" height="790">

# Design review
Ik heb veelal dezelfde classes en functies gebruikt om de dieren te weergeven in de app.
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
- [LovesList]


## Process
Ik heb veel moeite gehad met het inladen van de API, omdat deze op een andere manier geschreven was dan hoe ik gewend was. Toen heb ik eerst de dingen gedaan die we eerder hebben geleerd uit de Resto-App, Grocr en mijn laatste app van Native App Studio.
Toen heb ik daarna besloten dat ik mijn 'home'-scherm op een andere manier wilde dan een saaie tableview, dus heb ik ervoor gekozen om een Netflix-achtige opstelling te maken, die ervoor zorgt dat er horizontaal en verticaal gescrolld kan worden in de rijen zelf. Dit heeft veel moeite gekost, maar was het zeker waard. De data in deze cellen krijgen, was daardoor wel een flinke uitdaging, maar is gelukkig allemaal op tijd gelukt.
Deze keer was het een stuk makkelijker om Firebase te gebruiken dan bij de vorige app, omdat ik het nu veel beter begreep. Dit scheelde veel tijd natuurlijk in het implementeren van Firebase. Ik heb toen ook besloten om niet meer een chat-functie eraan toe te voegen, omdat dit teveel werk zou zijn, en er nog genoeg andere dingen moesten gebeuren. Als laatse obstakel heb ik ondervonden dat het lastiger bleek dan gedacht om lijsten van andere gebruikers te bekijken, als er ook gezocht kan worden op gebruikers, en wanneer laatste bekeken lijsten ook nog bestaan. Hier heb ik langer aan gezeten dan gedacht, maar het is uiteindelijk gelukt.

Eigenlijk heb ik weinig anders gedaan dan in het Design Document, behalve de chat-functie eruit gehaald, en in plaats van het zelf toevoegen van een dier, juist contact kunnen opnemen met het dierenasiel. Ik denk dat dit een betere keuze is geweest, om juist de gebruiker te kunnen overtuigen om contact op te nemen met het dierenasiel en uiteindelijk een dier te adopteren.
