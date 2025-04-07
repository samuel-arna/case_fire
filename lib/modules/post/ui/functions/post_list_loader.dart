import 'package:case_fire/modules/post/domain/entities/post_entity.dart';

class PostListLoader {
  List<PostEntity> loadMorePosts(
    List<PostEntity> allPosts,
    int offset,
    int limit,
  ) {
    if (offset + limit < allPosts.length) {
      return allPosts.sublist(0, offset + limit);
    } else {
      return allPosts.sublist(0, allPosts.length);
    }
  }
}
