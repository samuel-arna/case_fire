import 'package:case_fire/modules/auth/data/datasource/auth_firebase_datasource.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<String, UserCredential>> login(String email, String password);
  Future<void> logout();
  Future<User?> getCurrentUser();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDatasource datasource;

  AuthRepositoryImpl({required this.datasource});

  @override
  Future<Either<String, UserCredential>> login(
    String email,
    String password,
  ) async {
    return await datasource.loginFire(email, password);
  }

  @override
  Future<void> logout() async {
    await datasource.logoutFire();
  }

  @override
  Future<User?> getCurrentUser() async {
    return await datasource.getCurrentUser();
  }
}
