import 'package:case_fire/core/debugger/app_debug.dart';
import 'package:dio/dio.dart';

class PostPlaceholderDatasource {
  final Dio client;

  PostPlaceholderDatasource({Dio? dio}) : client = dio ?? Dio();

  Future<List<dynamic>> getPosts() async {
    try {
      final response = await client.get(
        'https://jsonplaceholder.typicode.com/posts',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data;
      } else {
        throw Exception('Falha ao pegar posts, erro: ${response.statusCode}');
      }
    } catch (e) {
      AppDebug(message: 'Falha ao pegar posts: $e');
      rethrow;
    }
  }
}
