import 'package:case_fire/modules/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  Future<void> execute() async {
    return await _authRepository.logout();
  }
}
