import 'package:secondapp/models/comment_model.dart';
import 'package:secondapp/repositories/comments/comments_repository.dart';
import 'package:dio/dio.dart';
import 'package:secondapp/repositories/jsonplaceholder_custom_dio.dart';

class CommentsDioRepository implements CommentsRepository {
  var comments = <CommentModel>[];

  @override
  Future<List<CommentModel>> getComments(int id) async {
    var jsonPlaceholderCustomDio = JsonPlaceholderCustomDio();
    var result = await jsonPlaceholderCustomDio.dio
        .get("/posts/${id.toString()}/comments");

    if (result.statusCode == 200) {
      return (result.data as List)
          .map((comment) => CommentModel.fromJson(comment))
          .toList();
    }
    return comments;
  }
}
