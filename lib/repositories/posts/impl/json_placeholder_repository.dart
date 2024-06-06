import 'dart:convert';

import 'package:secondapp/models/json_placeholder_model.dart';
import 'package:http/http.dart' as http;
import 'package:secondapp/repositories/posts/posts_repository.dart';

class JsonPlaceholderRepository implements PostsRepository {
  var posts = <JsonPlaceholderModel>[];

  @override
  Future<List<JsonPlaceholderModel>> getPosts() async {
    var result =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    if (result.statusCode == 200) {
      for (var post in jsonDecode(result.body)) {
        posts.add(JsonPlaceholderModel.fromJson(post));
      }
      print(posts);
      return posts;
    }
    return posts;
  }
}
