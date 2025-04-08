import 'package:case_fire/core/errors/failure.dart';
import 'package:case_fire/core/errors/generic_failure.dart';
import 'package:case_fire/modules/post/domain/entities/post_entity.dart';
import 'package:case_fire/modules/post/domain/repositories/post_repository.dart';
import 'package:either_dart/either.dart';

class GetPostsUseCase {
  final PostRepository repository;

  GetPostsUseCase(this.repository);

  Future<Either<Failure, List<PostEntity>>> execute() async {
    try {
      final posts = await repository.getPosts();
      final List<PostEntity> postEntities =
          posts.map((model) => PostEntity.fromModel(model)).toList();
      return Right(postEntities);
    } catch (e) {
      print('Erro na use case: $e');
      return Left(GenericFailure(message: e.toString()));
    }
  }
}
