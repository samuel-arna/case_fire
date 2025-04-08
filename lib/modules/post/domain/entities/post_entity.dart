import 'package:case_fire/modules/post/data/models/post_model.dart';

class PostEntity {
  final int id;
  final String title;
  final String body;
  final int userId;
  final String? userPhotoUrl;
  final String? userName;
  final int? userAge;
  final List<String>? userGostos;
  final int? numPost;

  PostEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    this.userPhotoUrl,
    this.userName,
    this.userAge,
    this.userGostos,
    this.numPost,
  });

  factory PostEntity.fromModel(PostModel model) {
    return PostEntity(
      id: model.id,
      title: model.title,
      body: model.body,
      userId: model.userId,
      userPhotoUrl: model.userPhotoUrl,
      userName: model.userName,
      userAge: model.userAge,
      userGostos: model.userGostos,
      numPost: model.numPost,
    );
  }
}
