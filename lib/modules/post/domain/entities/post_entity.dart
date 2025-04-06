import 'package:case_fire/modules/post/data/models/post_model.dart';

class PostEntity {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostEntity({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostEntity.fromModel(PostModel model) {
    return PostEntity(
      userId: model.userId ?? 0,
      id: model.id ?? 0,
      title: model.title ?? '',
      body: model.body ?? '',
    );
  }
}
