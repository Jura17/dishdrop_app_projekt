# DishDrop 🥘

DishDrop ist eine moderne offline-first Rezept-App, entwickelt mit Flutter. Sie ermöglicht das komfortable Speichern, Organisieren und Vorschlagen von Rezepten sowie das Erstellen von Einkaufslisten – alles lokal und blitzschnell durch die Nutzung von ObjectBox.


## Features 🚀

### Kochbuch 📚
- Rezepte mit Titel, Bild, Kategorie, Zubereitungszeit, Kochzeit, Schwierigkeitsgrad, Tags, Zutaten, Schritten und Notizen
- Zuweisung zu 6 Kategorien (z. B. “Main Courses”, “Salads”, etc.)
- Favoritenfunktion & Zähler, wie oft ein Rezept gekocht wurde
- Servings Picker zur automatischen Mengenanpassung
- Direktes Erstellen von Einkaufsisten aus den Zutaten eines Rezepts

<table>
<tr>
<td><img src="assets/images/categories_screenshot.png" width="200"></td>
<td><img src="assets/images/recipe_grid_view_screenshot.png" width="200"></td>
<td><img src="assets/images/recipe_details_top_screenshot.png" width="200"></td>
<td><img src="assets/images/recipe_details_bottom_screenshot.png" width="200"></td>
</tr>
<tr>
<td colspan="4" >Von der Kategorieansicht bishin zur Rezeptdetailansicht</td>
</tr>
</table>

<p></p>

<table>
<tr>
<td><img src="assets/images/searchbar_screenshot.png" width="200"></td>
</tr>
<tr>
<td>Eine zusätzliche Suchleiste am oberen Bildschirm, inkl. Filterung nach Favoriten/Nicht-Favoriten</td>
</tr>
</table>

<p></p>

<table>
<tr>
<td><img src="assets/images/edit_recipe_screenshot.png" width="200"></td>
<td><img src="assets/images/edit_recipe_ingredients_screenshot.png" width="200"></td>
</tr>
<tr>
<td colspan="2" >Bearbeitung eines Rezepts.</td>
</tr>
</table>


### Einkaufslisten 🛒
- Zwei Typen: Allzweckliste & rezeptgebundene Liste
- Einkaufsartikel können abgehakt und gelöscht werden

<table>
<tr>
<td><img src="assets/images/recipe_shopping_list_screenshot.png" width="200"></td>
<td><img src="assets/images/all_purpose_list_screenshot.png" width="200"></td>
</tr>
<tr>
<td colspan="2" >Rezeptgebundene List (links) und Allzweckliste (rechts)</td>
</tr>
</table>


### Vorschlagsfunktion 🎲
- Intelligente Rezeptvorschläge basierend auf Nutzerpräferenzen (z. B. Zeit, Kategorie, Favoriten)
- Alternativ: “Just give me something”-Button für schnelle Inspiration
- Integrierte Suchfunktion mit Filteroptionen

<table>
<tr>
<td><img src="assets/images/recommendation_screen_1_screenshot.png" width="200"></td>
<td><img src="assets/images/recommendation_screen_2_screenshot.png" width="200"></td>
<td><img src="assets/images/recommendation_card_screenshot.png" width="200"></td>
</tr>
<tr>
<td colspan="3" >Nach nur ein paar kurzen Fragen bekommt der Nutzer ein Rezept vorgeschlagen. Parameter, die auf kein vorhandenes Rezept zutreffen, werden ausgegraut.</td>
</table>

## Technologiestack/Packages 🧱
- Flutter: Cross-Plattform UI-Toolkit
- Dart: Programmiersprache für Flutter
- ObjectBox: High-performance local NoSQL-Datenbank
- GoRouter: Flutter-Navigation mit deklarativen Routen
- Provider: State Management
- Shared Preferences: Speicherung einfacher Daten
- Image Picker: Bilder aus Galerie laden
- Flutter Gen: Automatisiertes Asset-Handling
- Flutter Launcher Icons: Eigene App-Icons
    
👉 Vollständige Liste: siehe pubspec.yaml


## Projektstruktur 🗂️

Das Projekt folgt einer modularen Struktur, inspiriert vom Layer-First-Prinzip (z. B. Trennung von UI, Daten, Logik).
<pre>
<code>
lib/
├── core/              → UI-Theming und Hilfsfunktionen (z. B. Farben, Textstyles, Utils)
├── data/              → Datenmodelle, Provider, Repositories, ObjectBox-Datenbank
├── ui/                → Screens und Widgets, teilweise nach Features gruppiert
│   ├── screens/       → Hauptansichten (Rezepte, Empfehlungen, Einkaufsliste)
│   ├── widgets/       → Wiederverwendbare UI-Komponenten, gruppiert nach Kontext/Feature
├── gen/               → Automatisch generierte Assets via flutter_gen
├── dish_drop_app.dart → Einstiegspunkt für App-Setup
└── main.dart          → App-Startpunkt (runApp)

</code>	
</pre>


## To Do / Weiteres Potenzial 📝
- User Authentication (für ObjectBox Sync)
- Settings screen (in Bearbeitung)
- Deployment auf Android
- Light Mode/Dark Mode Einstellung
- Timer inkl. Stay-Awake-Funktion (lässt Bildschirm angeschalten)
- Zutaten gruppieren (z. B. Zutaten für Braten, Zutaten für Soße, usw.)
- Fotos für einzelne Kochschritte zur besseren Veranschaulichung
- Speech-To-Text-Funktion, um auch bei längeren Texten die Hände frei zum Kochen zu haben
