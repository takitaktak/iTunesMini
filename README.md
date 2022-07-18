# iTunesMini
This app shows a list of items from the iTunes Search API, shows a detail view of each item, and marks items as their favorites.

## Screenshots
<p align="center">
  <img src="https://github.com/takitaktak/iTunesMini/raw/main/screenshots/recents_screen.png" width="20%" height="20%"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/takitaktak/iTunesMini/raw/main/screenshots/search_screen.png" width="20%" height="20%"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/takitaktak/iTunesMini/raw/main/screenshots/favorites_screen.png" width="20%" height="20%"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/takitaktak/iTunesMini/raw/main/screenshots/detail_screen.png" width="20%" height="20%"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>

## Architecture
This app implements the MVVM (Model-View-View-Model) structure.

### Roles
- Model - Represents the data in the app. Uses Realm objects to take advantage of notification changes.
- View Model - Focuses on business logic that basically drives the app (e.g. Decides what to do when a button is pressed).
- Views - Interacts with the corresponding view model to notify user events and update from data changes.
- Store - Responsible for doing the heavy lifting in the backend doing API requests and database transactions.

### Cons
- May become tedious to maintain due to the number of files.
- May have 'Massive'/'Fat' View Models if separation is not thought out (i.e. view models doing too much work like formatting data for presentation, and coordinating events between the views and backend).

### Improvements
## Dependency
## Known Issues

