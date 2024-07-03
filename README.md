# DelishDish

- **Leckere Rezepte und mehr in deiner Hand!**

## DelishDish bietet eine Sammlung von köstlichen Rezepten, die dir helfen, beeindruckende Mahlzeiten zuzubereiten. 
## Darüber hinaus kannst du eine To-Do-Liste hinzufügen, um deine Einkaufslisten oder andere Aufgaben zu organisieren. 
## Perfekt für alle, die gerne kochen und ihre täglichen Aufgaben im Griff behalten möchten.




  
# In Figma designte Beispielansichten der DelishDish App

LoginView

<div style="display: flex; flex-wrap: wrap; gap: 10px;">
  <img src="./img/DelishDish - LoginView - Anmelden_1.png" style="height: 500px; object-fit: cover;">
  <img src="./img/DelishDish - LoginView - Registieren_2.png" style="height: 500px; object-fit: cover;">
</div>


### Weitere Ansichten
- RecipeListView
- RecipeListDetailsView
- FavouriteView
- ToDoView
- SettingsView

<div style="display: flex; flex-wrap: wrap; gap: 10px;">
  <img src="./img/DelsihDish - RecipesListView_3.png" style="height: 500px; object-fit: cover;">
  <img src="./img/DelishDish - RecpeListDetailsView - Ingredient_4.png" style="height: 500px; object-fit: cover;">
  <img src="./img/DelishDish - RecpeListDetailsView - Measure_5.png" style="height: 500px; object-fit: cover;">
  <img src="./img/DelishDish - RecpeListDetailsView - Instructions_6.png" style="height: 500px; object-fit: cover;">
  <img src="./img/DelishDish - RecpeListDetailsView - Instructions mit Favorite_7.png" style="height: 500px; object-fit: cover;">
  <img src="./img/DelsihDish - FavouriteView_8.png" style="height: 500px; object-fit: cover;">
  <img src="./img/DelsihDish - ToDoView_9.png" style="height: 500px; object-fit: cover;">
  <img src="./img/DelsihDish - ToDoView - Sheet_10.png" style="height: 500px; object-fit: cover;">
  <img src="./img/DelsihDish - SettingsView_11.png" style="height: 500px; object-fit: cover;">
</div>


## Features
Hier kommen alle geplanten Features der App rein mit dem Status, ob es bereits umgesetzt wurde.

- [ ] Benutzer können sich registrieren und anmelden
    
- [ ] Rezeptdaten durchsuchen und Rezepte speichern

- [ ] To-Do-Listen erstellen und verwalten

- [ ] Lieblingsrezepte Favoriten speichern



## Technischer Aufbau

#### Projektaufbau
In meinem Projekt habe ich die MVVM-Architektur verwendet. Die Ordnerstruktur sieht wie folgt 

 - DelishDishApp
 - Models
 - Views
 - ViewModels
 - Services


#### Datenspeicherung
- **Firebase**: Für die Authentifizierung und Speicherung von Benutzerinformationen.

#### Api Calls 
- **[TheMealDB](https://www.themealdb.com/api.php)** :  Für das abrufen der Rezepte und mehr.

#### 3rd-Party Frameworks
- **Firebase Authentication**: Für Benutzeranmeldung und registrierung.
- **Firebase Cloud Firestore**: Für die Speicherung und Verwaltung der Rezepte und Benutzerinformationen.
- **SwiftUI**: Für die Gestaltung der Benutzeroberfläche. 


## Ausblick

In Zukunft werde ich noch einige Ergänzungen vornehmen, um mein Projekt weiterzuentwickeln. Aktuell habe ich folgende Pläne:

Eine Liste, die die nächstgelegenen Märkte mit Namen und Adresse anzeigt, um die Zutaten der Rezepte zu beschaffen.
Eine Liste, die die Entfernung dieser Märkte von Ihrem Standort anzeigt.
Eine Funktion, die automatisch Apple Maps startet, um direkt zur ausgewählten Adresse zu navigieren.


