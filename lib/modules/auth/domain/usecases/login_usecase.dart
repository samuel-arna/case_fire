import 'package:case_fire/modules/auth/domain/repositories/auth_repository.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<Either<String, UserCredential>> execute(
    String email,
    String password,
  ) async {
    return await _authRepository.login(email, password);
  }
}
