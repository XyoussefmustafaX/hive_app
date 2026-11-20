import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/post.dart';
import '../widgets/post_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: ValueListenableBuilder<Box<Post>>(
        valueListenable: Hive.box<Post>('favoritesBox').listenable(),
        builder: (context, box, _) {
          final favorites = box.values.toList();

          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                'No favorites yet',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) =>
                PostCard(post: favorites[index]),
          );
        },
      ),
    );
  }
}
