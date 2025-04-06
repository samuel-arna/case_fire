import 'package:case_fire/modules/post/domain/entities/post_entity.dart';
import 'package:case_fire/modules/post/domain/repositories/post_repository.dart';
import 'package:case_fire/modules/post/domain/usecases/get_posts_usecase.dart';
import 'package:case_fire/modules/post/ui/stores/bloc/post_event.dart';
import 'package:case_fire/modules/post/ui/stores/bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsUseCase _getPostsUseCase;

  PostBloc(PostRepository postRepository)
    : _getPostsUseCase = GetPostsUseCase(postRepository),
      super(PostInitial()) {
    on<GetPosts>(_getPostsToState);
  }

  Future<void> _getPostsToState(GetPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final List<PostEntity> posts = await _getPostsUseCase.execute();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
