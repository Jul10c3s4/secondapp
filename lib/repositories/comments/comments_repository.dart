import 'package:secondapp/models/comment_model.dart';

abstract class CommentsRepository {
  Future<List<CommentModel>> getComments(int id);
}
