# Programmeerproject

### Process Book
###### Created by Jet van den Berg

# Week 2
## Dag 1
* Het design was de week ervoor gemaakt. De navigation flow was ook klaar. 
* Het bleek dat de gekozen API (https://data.kingcounty.gov/resource/murn-chih.json) niet een makkelijke API was om te lezen door de JSONDecoder. Met hulp van een student-assistent is er wel een begin gemaakt. 
* Ondertussen ook maar begonnen om Firebase op te zetten.

## Dag 2
* Het is uiteindelijk gelukt om de API in de app werkend te krijgen. 
* Nu moet er worden gekeken welke informatie het beste in de app getoond kan worden. 
* Ondertussen ook het inloggen en registeren in de app redelijk af gekregen, werkt echter nog niet optimaal.

## Dag 3
* Inloggen en registeren werkt nu optimaal, inclusief errors als de gebruiker niet correct inlogt.
* Bezig met collectionView in tableView te krijgen, zodat er horizontaal in een tableViewCell gescrolld kan worden.

## Dag 4
* CollectionViewCellen staan in tableViewCellen, nu de juiste data van de API erin krijgen.
* CollectionViewCellen aangepast qua layout

## Dag 5
* Loves-list wordt nu bijgewerkt met data, maar wordt helaas nog niet getoond in collectionViewCellen

# Week 3
## Dag 6
* Data wordt nu weergegeven in collectionViewCellen, ook de images. Zit nog wel een bug in als er verder horizontaal wordt gescrolld in tableViewCell. Ook de segue naar detailsscherm is nog buggy.

## Dag 7
* Horizontaal scrollen werkt nu optimaal. Ook images springen niet meer raar heen en weer in verschillende cellen.
* Segue werkt nu ook (weer). Door de aanpassing van een tableView naar collectionView werkte dat niet meer. Navigationflow is nu dus weer zoals het hoort.

## Dag 8
* Firebase is gekoppeld, er kunnen nu favorieten worden opgeslagen en teruggezet worden in de app. Nog niet alle data van een object wordt erin gezet, zoals de afbeelding, dat is iets voor volgende week, als er aan de details gewerkt moet worden.

## Dag 9/10
* Toch gelukt om afbeelding(URL) uit Firebase te laden en bij object te zetten.
* Dieren worden nu ingedeeld op animal_type, zodat honden bij 'Dogs', katten bij 'Cats' etc. komen te staan.
* Functionaliteiten gemaakt zoals kunnen bellen en mailen met dierenasiel, of website-link bekijken van specifiek dier (gegevens kloppen alleen nog niet)
* Gebruikers kunnen nu gezocht worden op e-mailadres in lijst met alle gebruikers
* Nieuwe API toegevoegd die willekeurige foto's van honden in moet laden, die als profielfoto moeten dienen van gebruikers, maar nog niet gelukt om die op goede manier in te laten.
* Detailsscherm van specifieke gebruiker gemaakt.

# Week 4
## Dag 11
* Lijst van gebruiker wordt nu op eigen account opgeslagen in Firebase.
* Gebruikers worden in aparte lijst in Firebase opgeslagen, en worden weergeven in Social, hun lijst wordt nog niet getoond in detailsView.
* Besloten dat een chat-functie niet meer haalbaar is, en dus geschrapt.

## Dag 12
* currentUser wordt niet in lijst in Social weergegeven, dus alleen andere gebruikers.
* Loves-lijst van een specifieke gebruiker is te bekijken.
* Remaining animals (vierde row Love Me!) uit app gehaald, omdat deze vrijwel geen data bevatten. 
* Gebruiker kan alleen registeren als beide tekstvelden ingevuld zijn. 
* Gebruiker kan eigen e-mail als 'accountnaam' zien.
* Tab bar icons gemaakt.
* Bezig met 'laatst gezocht' maken, dit komt nu wel in Firebase te staan, moet er alleen nog uitgelezen worden.
