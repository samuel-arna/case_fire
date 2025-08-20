import 'package:case_fire/modules/post/data/datasources/post_placeholder_datasource.dart';
import 'package:case_fire/modules/post/data/models/post_model.dart';
import 'package:case_fire/modules/post/data/repositories/post_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostPlaceholderDatasource extends Mock
    implements PostPlaceholderDatasource {}

void main() {
  group('Testes Post Repository', () {
    late MockPostPlaceholderDatasource mockDatasource;
    late PostRepositoryImpl repository;

    setUp(() {
      mockDatasource = MockPostPlaceholderDatasource();
      repository = PostRepositoryImpl(mockDatasource);
    });

    test('Deve pegar os posts', () async {
      final mockPosts = [
        {'userId': 1, 'id': 1, 'title': 'Title 1', 'body': 'Body 1'},
        {'userId': 2, 'id': 2, 'title': 'Title 2', 'body': 'Body 2'},
        {'userId': 3, 'id': 3, 'title': 'Title 3', 'body': 'Body 3'},
      ];

      when(() => mockDatasource.getPosts()).thenAnswer((_) async => mockPosts);

      List<PostModel> listPost = await repository.getPosts();

      expect(listPost, isNotEmpty);
      expect(listPost, isA<List<PostModel>>());
      verify(() => mockDatasource.getPosts()).called(1);
    });

    test('O post deve conter userId, id, title, body', () async {
      final mockPosts = [
        {'userId': 1, 'id': 1, 'title': 'Title 1', 'body': 'Body 1'},
      ];

      when(() => mockDatasource.getPosts()).thenAnswer((_) async => mockPosts);

      List<PostModel> listPost = await repository.getPosts();
      PostModel post = listPost.first;

      expect(listPost, isNotEmpty);
      expect(post.userId, isNotNull);
      expect(post.userId, isA<int>());
      expect(post.id, isNotNull);
      expect(post.id, isA<int>());
      expect(post.title, isNotNull);
      expect(post.title, isA<String>());
      expect(post.title!.isNotEmpty, true);
      expect(post.body, isNotNull);
      expect(post.body, isA<String>());
      expect(post.body!.isNotEmpty, true);
      verify(() => mockDatasource.getPosts()).called(1);
    });

    test('Deve receber um erro se o datasource falhar', () async {
      when(
        () => mockDatasource.getPosts(),
      ).thenThrow(Exception('Falha no datasource'));

      expect(() async => await repository.getPosts(), throwsException);
      verify(() => mockDatasource.getPosts()).called(1);
    });
  });
}
