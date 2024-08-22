
<h1 align="center">DelishDish</h1>

<p align="center">
  <img src="./img/Delish-Dish Logo.png" alt="DelishDish Logo" style="height: 150px; object-fit: cover;">
</p>



<p align="center">
  <strong><span style="font-size: 1.5em;">Leckere Rezepte und mehr in deiner Hand!</span></strong>
</p>




DelishDish bietet dir leckere Rezepte, mit denen du beeindruckende Gerichte zubereiten kannst, und du kannst diese Rezepte zu deinen Favoriten hinzufügen. Außerdem kannst du eine To-Do-Liste erstellen, um deine Aufgaben zu organisieren. Ideal für alle, die gerne kochen und ihr tägliches Leben organisiert halten möchten. Wenn du bestimmte Rezepte nicht findest oder nach speziellen Rezepten suchst, kannst du sie mit der KI-gestützten Rezeptsuche finden. Die App stellt dir einen KI-Assistenten zur Verfügung. Du kannst die wöchentlichen und täglichen Angebote der Supermärkte verfolgen und deine Einkaufsliste erstellen. Um deine Einkaufsliste zu erstellen, kannst du ToDo verwenden und die Liste, die du erstellt hast, mit den E-Mail-Adressen der registrierten DelishDish-Nutzer teilen.


#
  
<h1 align="center">Die Ansichten der DelishDish-App</h1>




<p align="center">• SplashScreenView</p>


<p align="center">
  <img src="./img/SplashScreenView .gif" alt="SplashScreenView" style="width: 240px;">
</p>


#


- AuthentificationView  
- RegistrierenView
- LoginView



<div style="display: flex; flex-wrap: wrap; gap: 10px;">
  <img src="./img/AuthentificationView.png" style="height: 500px; object-fit: cover;">
  <img src="./img/RegistrierenView.png" style="height: 500px; object-fit: cover;">
  <img src="./img/LoginView.png" style="height: 500px; object-fit: cover;">
</div>

#
- RecipesListView
- RecipesDetailsView
- FavouriteView



<div style="display: flex; flex-wrap: wrap; gap: 10px;">
  <img src="./img/RecipesListView.png" style="height: 500px; object-fit: cover;">
  <img src="./img/RecipesDetailsView.png" style="height: 500px; object-fit: cover;">
  <img src="./img/FavouriteView.png" style="height: 500px; object-fit: cover;">
</div>

#


- ProfileView
- RecipesAIView
- ToDoListView

<div style="display: flex; flex-wrap: wrap; gap: 10px;">
  <img src="./img/ProfileView.png" style="height: 500px; object-fit: cover;">
  <img src="./img/RecipesAIView.png" style="height: 500px; object-fit: cover;">
  <img src="./img/ToDoListView.png" style="height: 500px; object-fit: cover;">
</div>

#

- MarketAngebotenListView
  
<div style="display: flex; flex-wrap: wrap; gap: 10px;">
  <img src="./img/MarketAngebotenListView.png" style="height: 500px; object-fit: cover;">
  <img src="./img/MarketAngebotenListView1.png" style="height: 500px; object-fit: cover;">
</div>

#
  

## Features
#### Hier sind alle geplanten Features der App aufgelistet, zusammen mit dem Status ihrer Umsetzung. Diese Liste zeigt die Aktionen, die in der App durchgeführt werden können, oder die Möglichkeiten, die den Benutzern zur Verfügung stehen.

#
  - [ ] **Benutzer können sich registrieren und anmelden**: Sie können ein Konto erstellen und sich in der App anmelden.

  - [ ] **Benutzer können Rezepte anzeigen und durchsuchen**: Sie können Rezepte einsehen und über eine Suchfunktion finden.

  - [ ] **Benutzer können Lieblingsrezepte zu Favoriten hinzufügen und später schnell darauf zugreifen.**

  - [ ] **Benutzer können den KI-Assistenten nach fehlenden oder speziellen Rezepten fragen.**

  - [ ] **Benutzer können To-Do-Listen erstellen und mit anderen teilen.**

  - [ ] **Benutzer können Angebotsseiten von Supermärkten anzeigen und Produkte zur To-Do-Liste hinzufügen.**

#

## Technischer Aufbau

#### Projektaufbau
In meinem Projekt habe ich die MVVM-Architektur verwendet. Die Ordnerstruktur sieht wie folgt 

 - DelishDishApp
 - Repository
 - Models
 - Views
 - ViewModels


#### Datenspeicherung
- **Firebase**: Für die Authentifizierung und Speicherung von Benutzerinformationen.
- **Firebase**: Speichert die To-Do-Listen der Benutzer und ermöglicht es, diese Listen in Echtzeit untereinander zu teilen.

#### Api Calls 
- **[TheMealDB](https://www.themealdb.com/api.php)** :  Zum Abrufen von Rezepten und zum Anzeigen der Zubereitung auf YouTube.
- **[OpenAi-Api](https://platform.openai.com/docs/api-reference/introduction)** : Wird verwendet, um einen Rezepte-Generator zu erstellen.

#### 3rd-Party Frameworks
- **Firebase Authentication**: Für Benutzeranmeldung und registrierung.
- **Firebase Firestore Database**: Wird verwendet, um To-Do-Listen der Rezepte und Benutzerinformationen zu speichern und zu verwalten.


## Ausblick

In Zukunft werde ich noch einige Ergänzungen vornehmen, um mein Projekt weiterzuentwickeln. Aktuell habe ich folgende Pläne:

Ich möchte eine API integrieren, die ich selbst erstellt habe und die Tausende von Rezepten auflistet. 
Diese API wird ständig aktualisiert und neue Rezepte werden hinzugefügt. 
Außerdem möchte ich eine Liste der nächstgelegenen Supermärkte in Deutschland erstellen, basierend auf dem Standort der Nutzer. 
Wenn die Nutzer auf diese Supermärkte in der Liste klicken, können sie den Weg zum ausgewählten Supermarkt über Apple Maps finden. 
Darüber hinaus möchte ich eine Ansicht hinzufügen, die täglich, wenn die App geöffnet wird, 10 zufällig ausgewählte Rezepte des Tages anzeigt. 
Diese Funktion wird den Nutzern die Auswahl eines Rezepts erleichtern.

