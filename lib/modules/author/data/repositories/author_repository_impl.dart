import 'package:case_fire/core/errors/failure.dart';
import 'package:case_fire/core/errors/generic_failure.dart';
import 'package:case_fire/modules/author/data/datasources/author_firestore_datasource.dart';
import 'package:case_fire/modules/author/domain/entities/author_entity.dart';
import 'package:case_fire/modules/author/domain/repositories/author_repository.dart';
import 'package:either_dart/either.dart';

class AuthorRepositoryImpl implements AuthorRepository {
  final AuthorFirestoreDatasource authorFirestoreDatasource;

  AuthorRepositoryImpl({required this.authorFirestoreDatasource});

  @override
  Future<Either<Failure, AuthorEntity?>> getAuthor(String userId) async {
    try {
      final authorModel = await authorFirestoreDatasource.getAuthorInfo(userId);
      final authorEntity =
          authorModel != null
              ? AuthorEntity(
                userPhotoUrl: authorModel.foto,
                userName: authorModel.nome,
                userAge: authorModel.idade,
                userGostos: authorModel.gostos?.cast<String>(),
                numPost: authorModel.numPost,
              )
              : null;
      return Right(authorEntity);
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }
}
