import 'package:case_fire/core/errors/failure.dart';
import 'package:case_fire/modules/post/data/datasources/post_placeholder_datasource.dart';
import 'package:case_fire/modules/post/domain/entities/post_entity.dart';
import 'package:case_fire/modules/post/domain/repositories/post_repository.dart';
import 'package:case_fire/modules/post/domain/usecases/get_posts_usecase.dart';
import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostPlaceholderDatasource extends Mock
    implements PostPlaceholderDatasource {}

void main() {
  late MockPostPlaceholderDatasource datasource;
  late PostRepositoryImpl repository;

  setUp(() {
    datasource = MockPostPlaceholderDatasource();
    repository = PostRepositoryImpl(datasource);
  });
  group('Testes get posts usecase', () {
    test('Deve receber uma lista de PostEntity', () async {
      final mockPosts = [
        {'userId': 1, 'id': 1, 'title': 'Title 1', 'body': 'Body 1'},
        {'userId': 2, 'id': 2, 'title': 'Title 2', 'body': 'Body 2'},
        {'userId': 3, 'id': 3, 'title': 'Title 3', 'body': 'Body 3'},
      ];

      when(() => datasource.getPosts()).thenAnswer((_) async => mockPosts);

      Either<Failure, List<PostEntity>> listPost =
          await GetPostsUseCase(repository).execute();

      expect(listPost.right.isNotEmpty, true);
      expect(listPost, isA<Either<Failure, List<PostEntity>>>());
      verify(() => datasource.getPosts()).called(1);
    });

    test('Deve apresentar um title vazio caso não declarado', () async {
      final mockPosts = [
        {'userId': 3, 'id': 3, 'body': 'Body 3'},
      ];

      when(() => datasource.getPosts()).thenAnswer((_) async => mockPosts);

      Either<Failure, List<PostEntity>> listPost =
          await GetPostsUseCase(repository).execute();
      PostEntity post = listPost.right.first;

      expect(listPost.right.isNotEmpty, true);
      expect(listPost, isA<Either<Failure, List<PostEntity>>>());
      expect(post.title, '');
      verify(() => datasource.getPosts()).called(1);
    });
  });
}
