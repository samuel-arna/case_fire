import 'package:case_fire/modules/auth/data/error/firebase_error.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseDatasource {
  final FirebaseAuth _auth;

  AuthFirebaseDatasource({required FirebaseAuth firebaseAuth})
    : _auth = firebaseAuth;

  Future<Either<String, UserCredential>> loginFire(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(FireBaseError(e.code).getMessage());
    } catch (e) {
      return const Left('Erro desconhecido');
    }
  }

  Future<void> logoutFire() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Erro durante o logout: $e");
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      return _auth.currentUser;
    } catch (e) {
      print("Erro ao pegar user: $e");
      return null;
    }
  }
}
