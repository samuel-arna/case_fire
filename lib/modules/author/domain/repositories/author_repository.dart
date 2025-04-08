import 'package:case_fire/core/errors/failure.dart';
import 'package:case_fire/modules/author/domain/entities/author_entity.dart';
import 'package:either_dart/either.dart';

abstract class AuthorRepository {
  Future<Either<Failure, AuthorEntity?>> getAuthor(String userId);
}
