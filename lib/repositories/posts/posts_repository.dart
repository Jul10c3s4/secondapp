import 'package:secondapp/models/json_placeholder_model.dart';

abstract class PostsRepository {
  Future<List<JsonPlaceholderModel>> getPosts();
}
