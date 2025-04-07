import 'package:case_fire/modules/auth/data/datasource/auth_firebase_datasource.dart';
import 'package:case_fire/modules/auth/domain/repositories/auth_repository.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthFirebaseDatasource extends Mock
    implements AuthFirebaseDatasource {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthFirebaseDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockAuthFirebaseDatasource();
    repository = AuthRepositoryImpl(datasource: mockDatasource);
  });

  group('Testes do auth repository', () {
    const testEmail = 'teste@email.com';
    const testPassword = 'senha123';

    test('Login deve chamar datasource.loginFire e retornar sucesso', () async {
      final mockUserCredential = MockUserCredential();
      when(
        () => mockDatasource.loginFire(testEmail, testPassword),
      ).thenAnswer((_) async => Right(mockUserCredential));

      final result = await repository.login(testEmail, testPassword);

      expect(result, isA<Right>());
      expect(result.right, mockUserCredential);
      verify(() => mockDatasource.loginFire(testEmail, testPassword)).called(1);
    });

    test(
      'login deve retornar mensagem de erro se datasource.loginFire falhar',
      () async {
        const errorMessage = 'Falha no login';
        when(
          () => mockDatasource.loginFire(testEmail, testPassword),
        ).thenAnswer((_) async => Left(errorMessage));

        final result = await repository.login(testEmail, testPassword);

        expect(result, isA<Left>());
        expect(result.left, errorMessage);
        verify(
          () => mockDatasource.loginFire(testEmail, testPassword),
        ).called(1);
      },
    );

    test('logout deve chamar datasource.logoutFire', () async {
      when(() => mockDatasource.logoutFire()).thenAnswer((_) async {});

      await repository.logout();

      verify(() => mockDatasource.logoutFire()).called(1);
    });

    test(
      'getCurrentUser deve chamar datasource.getCurrentUser e retornar seu resultado',
      () async {
        final mockUser = MockUser();
        when(
          () => mockDatasource.getCurrentUser(),
        ).thenAnswer((_) async => mockUser);

        final result = await repository.getCurrentUser();

        expect(result, mockUser);
        verify(() => mockDatasource.getCurrentUser()).called(1);
      },
    );

    test(
      'getCurrentUser deve retornar null se datasource.getCurrentUser retornar null',
      () async {
        when(
          () => mockDatasource.getCurrentUser(),
        ).thenAnswer((_) async => null);

        final result = await repository.getCurrentUser();

        expect(result, null);
        verify(() => mockDatasource.getCurrentUser()).called(1);
      },
    );
  });
}
