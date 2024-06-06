import 'dart:convert';

import 'package:secondapp/models/comment_model.dart';
import 'package:http/http.dart' as http;
import 'package:secondapp/repositories/comments/comments_repository.dart';

class CommentsHttpRepository implements CommentsRepository {
  var comments = <CommentModel>[];

  @override
  Future<List<CommentModel>> getComments(int id) async {
    var result = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/posts/${id.toString()}/comments"));

    if (result.statusCode == 200) {
      for (var comment in jsonDecode(result.body)) {
        comments.add(CommentModel.fromJson(comment));
      }
      return comments;
    }

    return comments;
  }
}
