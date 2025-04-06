import 'package:case_fire/modules/post/domain/entities/post_entity.dart';

abstract class PostState {
  const PostState();
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostEntity> posts;

  PostLoaded(this.posts);
}

class PostError extends PostState {
  final String error;

  PostError(this.error);
}
