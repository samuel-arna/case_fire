import 'package:case_fire/core/debugger/app_debug.dart';
import 'package:case_fire/modules/post/data/datasources/post_placeholder_datasource.dart';
import 'package:case_fire/modules/post/data/models/post_model.dart';
import 'package:case_fire/modules/post/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostPlaceholderDatasource datasource;

  PostRepositoryImpl(this.datasource);

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      var posts = await datasource.getPosts();
      return posts.map((json) => PostModel.fromJson(json)).toList();
    } catch (e) {
      AppDebug(message: 'Erro no repositório: $e');
      rethrow;
    }
  }
}
