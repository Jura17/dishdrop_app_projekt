# DishDrop 🥘

DishDrop ist eine moderne offline-first Rezept-App, entwickelt mit Flutter. Sie ermöglicht das komfortable Speichern, Organisieren und Vorschlagen von Rezepten sowie das Erstellen von Einkaufslisten – alles lokal und blitzschnell durch die Nutzung von ObjectBox.


## Features 🚀

### Kochbuch 📚
- Rezepte mit Titel, Bild, Kategorie, Zubereitungszeit, Kochzeit, Schwierigkeitsgrad, Tags, Zutaten, Schritten und Notizen
- Zuweisung zu 6 Kategorien (z. B. “Main Courses”, “Salads”, etc.)
- Favoritenfunktion & Zähler, wie oft ein Rezept gekocht wurde
- Servings Picker zur automatischen Mengenanpassung
- Direktes Erstellen von Einkaufsisten aus den Zutaten eines Rezepts

![Rezeptkategorien](<Simulator Screenshot - iPhone 16 Plus - 2025-06-03 at 12.58.54.png>)![Rezeptdetailansicht 1](<Simulator Screenshot - iPhone 16 Plus - 2025-06-03 at 12.59.59.png>)


- zusätzliche Suchleiste am oberen Bildschirm, inkl. Filterung nach Favoriten/Nicht-Favoriten

![Rezeptdetailansicht 2](<Simulator Screenshot - iPhone 16 Plus - 2025-06-03 at 13.00.12.png>)![Suchfunktion](<Simulator Screenshot - iPhone 16 Plus - 2025-06-03 at 13.01.08.png>)

![Rezept bearbeiten 1](<Simulator Screenshot - iPhone 16 Plus - 2025-06-03 at 13.05.48.png>)![Rezept bearbeiten 2](<Simulator Screenshot - iPhone 16 Plus - 2025-06-03 at 13.06.00.png>)

### Einkaufslisten 🛒
- Zwei Typen: Allzweckliste & rezeptgebundene Liste
- Einkaufsartikel können abgehakt und gelöscht werden

![rezeptgebundene Einkaufsliste](<Simulator Screenshot - iPhone 16 Plus - 2025-06-03 at 13.04.54.png>)![Allzweckliste](<Simulator Screenshot - iPhone 16 Plus - 2025-06-03 at 13.04.48.png>)


### Vorschlagsfunktion 🎲
- Intelligente Rezeptvorschläge basierend auf Nutzerpräferenzen (z. B. Zeit, Kategorie, Favoriten)
- Alternativ: “Just give me something”-Button für schnelle Inspiration
- Integrierte Suchfunktion mit Filteroptionen

![Vorschlagsbildschirm](<Simulator Screenshot - iPhone 16 Plus - 2025-06-03 at 13.01.39.png>)![Rezeptvorschlag](<Simulator Screenshot - iPhone 16 Plus - 2025-06-03 at 13.02.25.png>)


## Technologiestack/Packages 🧱
- Flutter: Cross-Plattform UI-Toolkit
- Dart: Programmiersprache für Flutter
- ObjectBox: High-performance local NoSQL-Datenbank
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
- Deployment auf Android
- Dark Mode
- Timer inkl. Stay-Awake-Funktion
- Zutaten gruppieren (z. B. Zutaten für Braten, Zutaten für Soße, usw.)
- Fotos für einzelne Kochschritte zur besseren Veranschaulichung
- Speech-To-Text-Funktion, um auch bei längeren Texten die Hände frei zum Kochen zu haben
