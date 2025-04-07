import 'package:case_fire/modules/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:case_fire/modules/auth/domain/usecases/login_usecase.dart';
import 'package:case_fire/modules/auth/domain/usecases/logout_usecase.dart';
import 'package:case_fire/modules/auth/ui/stores/bloc/auth_event.dart';
import 'package:case_fire/modules/auth/ui/stores/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  }) : _loginUseCase = loginUseCase,
       _logoutUseCase = logoutUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       super(AuthInitial()) {
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
    on<GetCurrentUser>(_onGetCurrentUser);
  }

  Future<void> _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _loginUseCase.execute(event.email, event.password);
    result.fold(
      (errorMessage) => emit(AuthFailure(errorMessage: errorMessage)),
      (userCredential) => emit(AuthSuccess(user: userCredential.user)),
    );
  }

  Future<void> _onLogout(Logout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _logoutUseCase.execute();
    emit(AuthLoggedOut());
  }

  Future<void> _onGetCurrentUser(
    GetCurrentUser event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final user = await _getCurrentUserUseCase.execute();
    if (user != null) {
      emit(AuthSuccess(user: user));
    } else {
      emit(AuthLoggedOut());
    }
  }
}
