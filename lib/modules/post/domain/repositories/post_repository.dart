import 'package:case_fire/modules/post/data/models/post_model.dart';

abstract class PostRepository {
  Future<List<PostModel>> getPosts();
}
