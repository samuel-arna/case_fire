import 'package:case_fire/core/errors/generic_failure.dart';
import 'package:case_fire/modules/author/data/datasources/author_firestore_datasource.dart';
import 'package:case_fire/modules/author/data/models/author_model.dart';
import 'package:case_fire/modules/author/data/repositories/author_repository_impl.dart';
import 'package:case_fire/modules/author/domain/entities/author_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthorFirestoreDatasource extends Mock
    implements AuthorFirestoreDatasource {}

void main() {
  group('Testes Author Repository', () {
    late MockAuthorFirestoreDatasource mockDatasource;
    late AuthorRepositoryImpl repository;

    setUp(() {
      mockDatasource = MockAuthorFirestoreDatasource();
      repository = AuthorRepositoryImpl(
        authorFirestoreDatasource: mockDatasource,
      );
    });

    const testUserId = '123';

    final testAuthorModel = AuthorModel(
      foto: 'test_url',
      nome: 'Nome Teste',
      idade: 30,
      gostos: ['ler', 'codificar'],
      numPost: 10,
    );

    final testAuthorEntity = AuthorEntity(
      userPhotoUrl: 'test_url',
      userName: 'Nome Teste',
      userAge: 30,
      userGostos: ['ler', 'codificar'],
      numPost: 10,
    );

    test(
      'deve retornar Right com AuthorEntity quando o datasource retorna um AuthorModel válido',
      () async {
        when(
          () => mockDatasource.getAuthorInfo(testUserId),
        ).thenAnswer((_) async => testAuthorModel);

        final result = await repository.getAuthor(testUserId);

        expect(result.isRight, true);
        result.fold((falha) => fail('Deveria ser Right'), (autor) {
          expect(autor, equals(testAuthorEntity));
        });
        verify(() => mockDatasource.getAuthorInfo(testUserId)).called(1);
      },
    );

    test(
      'deve retornar Right com null quando o datasource retorna null',
      () async {
        when(
          () => mockDatasource.getAuthorInfo(testUserId),
        ).thenAnswer((_) async => null);

        final result = await repository.getAuthor(testUserId);

        expect(result.isRight, true);
        result.fold((falha) => fail('Deveria ser Right'), (autor) {
          expect(autor, isNull);
        });
        verify(() => mockDatasource.getAuthorInfo(testUserId)).called(1);
      },
    );

    test(
      'deve retornar Left com Failure quando o datasource lança uma exceção',
      () async {
        when(
          () => mockDatasource.getAuthorInfo(testUserId),
        ).thenThrow(Exception('Erro do Firestore'));

        final result = await repository.getAuthor(testUserId);

        expect(result.isLeft, true);
        result.fold((falha) {
          expect(falha, isA<GenericFailure>());
          expect(falha.message, 'Exception: Erro do Firestore');
        }, (autor) => fail('Deveria ser Left'));
        verify(() => mockDatasource.getAuthorInfo(testUserId)).called(1);
      },
    );
  });
}
