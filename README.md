# Posts & Favorites (Flutter + Hive)

**Student:** youssef mostafa  **ID:** 23010056

A Flutter app that loads posts from the JSONPlaceholder API, caches them in a
Hive box (`postsBox`) for offline use, and lets the user mark posts as
favorites in a separate Hive box (`favoritesBox`).

## Features

- Posts list loaded from `https://jsonplaceholder.typicode.com/posts`
- Pull-to-refresh and retry on error
- Offline support: cached posts are shown when there is no connection
- Star button on every post (filled = favorite, outlined = not favorite)
- Favorites screen opened from the AppBar, same card design as the posts list
- Friendly "No favorites yet" message when the box is empty
- Favorites persist across refreshes and app restarts, and work offline

## Why a separate box for favorites?

`PostService.getPosts()` calls `postsBox.clear()` on every refresh. If favorites
lived in `postsBox` they would be wiped. Also, a `HiveObject` can only live in
one box at a time, so `FavoritesService.toggleFavorite` saves a **copy** of the
post (`Post(id: ..., title: ..., body: ..., userId: ...)`) using the post id as
the key.

## Project structure

```
lib/
├── main.dart
├── models/
│   └── post.dart
├── services/
│   ├── post_service.dart
│   └── favorites_service.dart
├── screens/
│   ├── posts_screen.dart
│   └── favorites_screen.dart
└── widgets/
    └── post_card.dart
```

## How to run

```bash
flutter pub get
flutter run
```

Dependencies: `hive`, `hive_flutter`, `http`.

## Screenshots

### 1. Posts list
![Posts list](screenshots/01_posts_list.png)

### 2. Marking posts as favorites (filled star)
![Favorite stars](screenshots/02_favorite_stars.png)

### 3. Favorites screen
![Favorites screen](screenshots/03_favorites_screen.png)

### 4. Empty favorites ("No favorites yet")
![No favorites](screenshots/04_no_favorites.png)

### 5. Removing a favorite
![Remove favorite](screenshots/05_remove_favorite.png)

### 6. Offline proof (airplane mode, app reopened)
![Offline favorites](screenshots/06_offline_favorites.png)

The favorites were saved, the app was closed, airplane mode was turned on, and
the app was reopened. The favorites were still there.
