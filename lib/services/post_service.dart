import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../models/post.dart';

class PostService {
  static const String _url = 'https://jsonplaceholder.typicode.com/posts';

  static Box<Post> get _postsBox => Hive.box<Post>('postsBox');

  /// Fetches posts from the API and caches them in postsBox.
  /// If the network fails, returns the cached posts (offline support).
  static Future<List<Post>> getPosts() async {
    try {
      final response = await http
          .get(
            Uri.parse(_url),
            headers: const {
              'Accept': 'application/json',
              'User-Agent':
                  'Mozilla/5.0 (Linux; Android 14) AppleWebKit/537.36 '
                  '(KHTML, like Gecko) Chrome/120.0 Mobile Safari/537.36',
            },
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('Server error ${response.statusCode}');
      }

      final List<Post> posts = (json.decode(response.body) as List)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList();

      await _postsBox.clear();
      await _postsBox.putAll({for (final p in posts) p.id: p});
      return posts;
    } catch (e) {
      debugPrint('getPosts error: $e');
      if (_postsBox.isNotEmpty) {
        return _postsBox.values.toList();
      }
      rethrow;
    }
  }
}
