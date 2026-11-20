import 'package:hive_flutter/hive_flutter.dart';

import '../models/post.dart';

class FavoritesService {
  static Box<Post> get _box => Hive.box<Post>('favoritesBox');

  /// Adds the post to favorites, or removes it if it is already there.
  static Future<void> toggleFavorite(Post post) async {
    if (_box.containsKey(post.id)) {
      await _box.delete(post.id);
    } else {
      // A HiveObject can live in only one box, so save a copy.
      final copy = Post(
        id: post.id,
        title: post.title,
        body: post.body,
        userId: post.userId,
      );
      await _box.put(post.id, copy);
    }
  }

  static bool isFavorite(int id) => _box.containsKey(id);

  static List<Post> getFavorites() => _box.values.toList();
}
