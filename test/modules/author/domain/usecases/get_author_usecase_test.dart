import 'package:case_fire/core/errors/generic_failure.dart';
import 'package:case_fire/modules/author/domain/entities/author_entity.dart';
import 'package:case_fire/modules/author/domain/repositories/author_repository.dart';
import 'package:case_fire/modules/author/domain/usecases/get_author_usecase.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthorRepository extends Mock implements AuthorRepository {}

void main() {
  group('GetAuthorUseCase', () {
    late GetAuthorUseCase useCase;
    late MockAuthorRepository mockRepository;

    setUp(() {
      mockRepository = MockAuthorRepository();
      useCase = GetAuthorUseCase(repository: mockRepository);
    });

    const testUserId = '456';
    final testAuthorEntity = AuthorEntity(userName: 'Usuário Teste');
    final testFailure = GenericFailure(message: 'Erro do Repositório');

    test('deve chamar getAuthor no repositório', () async {
      when(
        () => mockRepository.getAuthor(testUserId),
      ).thenAnswer((_) async => Right(testAuthorEntity));

      await useCase.execute(testUserId);

      verify(() => mockRepository.getAuthor(testUserId)).called(1);
    });

    test(
      'Deve retornar Right com AuthorEntity quando o repositório retorna Right',
      () async {
        when(
          () => mockRepository.getAuthor(testUserId),
        ).thenAnswer((_) async => Right(testAuthorEntity));

        final result = await useCase.execute(testUserId);

        expect(result.isRight, true);
        result.fold(
          (falha) => fail('Deveria ser Right'),
          (autor) => expect(autor, equals(testAuthorEntity)),
        );
      },
    );

    test(
      'Deve retornar Left com Failure quando o repositório retorna Left',
      () async {
        when(
          () => mockRepository.getAuthor(testUserId),
        ).thenAnswer((_) async => Left(testFailure));

        final result = await useCase.execute(testUserId);

        expect(result.isLeft, true);
        result.fold((falha) {
          expect(falha, equals(testFailure));
        }, (autor) => fail('Deveria ser Left'));
      },
    );
  });
}
