import 'package:case_fire/modules/post/domain/entities/post_entity.dart';
import 'package:case_fire/modules/post/domain/repositories/post_repository.dart';

class GetPostsUseCase {
  final PostRepository repository;

  GetPostsUseCase(this.repository);

  Future<List<PostEntity>> execute() async {
    try {
      final posts = await repository.getPosts();

      return posts.map((model) => PostEntity.fromModel(model)).toList();
    } catch (e) {
      print('Erro na use case: $e');
      rethrow;
    }
  }
}
