import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/post.dart';
import '../services/favorites_service.dart';

/// One card design shared by PostsScreen and FavoritesScreen.
class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 6, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(post.body, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
            // Rebuilds immediately whenever favoritesBox changes.
            ValueListenableBuilder<Box<Post>>(
              valueListenable: Hive.box<Post>('favoritesBox').listenable(),
              builder: (context, box, _) {
                final bool isFav = box.containsKey(post.id);
                return IconButton(
                  tooltip: isFav ? 'Remove from favorites' : 'Add to favorites',
                  icon: Icon(
                    isFav ? Icons.star : Icons.star_border,
                    color: isFav ? Colors.amber : Colors.grey,
                  ),
                  onPressed: () => FavoritesService.toggleFavorite(post),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
