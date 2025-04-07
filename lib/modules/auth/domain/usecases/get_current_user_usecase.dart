import 'package:case_fire/modules/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetCurrentUserUseCase {
  final AuthRepository _authRepository;

  GetCurrentUserUseCase(this._authRepository);

  Future<User?> execute() async {
    return await _authRepository.getCurrentUser();
  }
}
