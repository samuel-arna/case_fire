import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<String, UserCredential>> login(String email, String password);
  Future<void> logout();
  Future<User?> getCurrentUser();
}
