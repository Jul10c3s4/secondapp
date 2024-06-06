import 'dart:convert';

import 'package:secondapp/models/json_placeholder_model.dart';
import 'package:secondapp/repositories/jsonplaceholder_custom_dio.dart';
import 'package:secondapp/repositories/posts/posts_repository.dart';
import 'package:dio/dio.dart';

class JsonPlaceholderDioRepository implements PostsRepository {
  var posts = <JsonPlaceholderModel>[];

  @override
  Future<List<JsonPlaceholderModel>> getPosts() async {
    var jsonPlaceholderCustomDio = JsonPlaceholderCustomDio();

    var result = await jsonPlaceholderCustomDio.dio.get("/posts");

    if (result.statusCode == 200) {
      return (result.data as List)
          .map((post) => JsonPlaceholderModel.fromJson(post))
          .toList();
      /*for (var post in jsonDecode(result.data)) {
        posts.add(JsonPlaceholderModel.fromJson(post));
      }
      return posts;*/
    }
    return posts;
  }
}
