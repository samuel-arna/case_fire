import 'package:case_fire/modules/post/data/datasources/post_placeholder_datasource.dart';
import 'package:case_fire/modules/post/data/models/post_model.dart';
import 'package:case_fire/modules/post/domain/repositories/post_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Deve pegar os posts', () async {
    var datasource = PostPlaceholderDatasource();
    var repository = PostRepositoryImpl(datasource);
    List<PostModel> listPost = await repository.getPosts();
    expect(listPost.isNotEmpty, true);
  });
  test('Os posts devem conter userId, id, title, body', () async {
    var datasource = PostPlaceholderDatasource();
    var repository = PostRepositoryImpl(datasource);
    List<PostModel> listPost = await repository.getPosts();
    PostModel post = listPost.first;
    expect(post.userId, isNotNull);
    expect(post.id, isNotNull);
    expect(post.title, isNotNull);
    expect(post.body, isNotNull);
  });
}
