import 'package:secondapp/repositories/posts/impl/json_placeholder_dio_repository.dart';
import 'package:dio/dio.dart';

class JsonPlaceholderCustomDio {
  final _dio = Dio();

  Dio get dio => _dio;

  JsonPlaceholderCustomDio() {
    _dio.options.baseUrl = "https://jsonplaceholder.typicode.com";
  }
}
