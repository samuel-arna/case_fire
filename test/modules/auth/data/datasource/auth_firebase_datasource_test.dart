import 'package:case_fire/modules/auth/data/datasource/auth_firebase_datasource.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late AuthFirebaseDatasource datasource;
  late MockFirebaseAuth mockAuth;
  late MockUserCredential mockUserCredential;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    datasource = AuthFirebaseDatasource(firebaseAuth: mockAuth);
  });

  test('Deve fazer login com sucesso', () async {
    when(
      () => mockAuth.signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => mockUserCredential);

    final result = await datasource.loginFire('test@email.com', 'password');

    expect(result, isA<Right>());

    if (result.isRight) {
      expect(result.right, isA<UserCredential>());
    }
  });

  test('Deve retornar um erro ao tentar logar', () async {
    final exception = FirebaseAuthException(
      code: 'user-not-found',
      message: 'User not found.',
    );
    when(
      () => mockAuth.signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenThrow(exception);

    final result = await datasource.loginFire('test@email.com', 'password');
    expect(result, isA<Left>());
  });

  test('Deve fazer logout com sucesso', () async {
    when(() => mockAuth.signOut()).thenAnswer((_) async {});

    await datasource.logoutFire();

    verify(() => mockAuth.signOut()).called(1);
  });

  test('Deve retornar o usuário atual', () async {
    final mockUser = MockUser();
    when(() => mockAuth.currentUser).thenReturn(mockUser);

    final user = await datasource.getCurrentUser();

    expect(user, mockUser);
  });

  test('Deve retornar nulo se não houver usuário atual', () async {
    when(() => mockAuth.currentUser).thenReturn(null);

    final user = await datasource.getCurrentUser();

    expect(user, null);
  });
}

class MockUser extends Mock implements User {}
