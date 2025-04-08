import 'package:case_fire/modules/post/domain/usecases/get_posts_usecase.dart';
import 'package:case_fire/modules/post/ui/stores/bloc/post_event.dart';
import 'package:case_fire/modules/post/ui/stores/bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsUseCase _getPostsUseCase;

  PostBloc({required GetPostsUseCase getPostsUseCase})
    : _getPostsUseCase = getPostsUseCase,
      super(PostInitial()) {
    on<GetPosts>(_getPostsToState);
  }

  Future<void> _getPostsToState(GetPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    final result = await _getPostsUseCase.execute();
    result.fold(
      (failure) => emit(PostError(failure.toString())),
      (posts) => emit(PostLoaded(posts)),
    );
  }
}
