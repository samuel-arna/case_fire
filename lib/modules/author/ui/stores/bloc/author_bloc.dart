import 'package:case_fire/modules/author/domain/usecases/get_author_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'author_event.dart';
import 'author_state.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  final GetAuthorUseCase getAuthorUseCase;

  AuthorBloc({required this.getAuthorUseCase}) : super(AuthorInitial()) {
    on<GetAuthorEvent>(_onGetAuthor);
  }

  Future<void> _onGetAuthor(
    GetAuthorEvent event,
    Emitter<AuthorState> emit,
  ) async {
    emit(AuthorLoading());
    final result = await getAuthorUseCase.execute(event.userId);
    result.fold(
      (failure) => emit(AuthorError(failure: failure)),
      (author) => emit(AuthorLoaded(author: author)),
    );
  }
}
