# Programmeerproject

### Process Book
###### Created by Jet van den Berg

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

## Dag 6
* Data wordt nu weergegeven in collectionViewCellen, ook de images. Zit nog wel een bug in als er verder horizontaal wordt gescrolld in tableViewCell. Ook de segue naar detailsscherm is nog buggy.

## Dag 7
* Horizontaal scrollen werkt nu optimaal. Ook images springen niet meer raar heen en weer in verschillende cellen.
* Segue werkt nu ook (weer). Door de aanpassing van een tableView naar collectionView werkte dat niet meer. Navigationflow is nu dus weer zoals het hoort.
