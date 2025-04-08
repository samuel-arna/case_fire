import 'package:case_fire/core/errors/failure.dart';
import 'package:case_fire/modules/author/domain/entities/author_entity.dart';
import 'package:case_fire/modules/author/domain/repositories/author_repository.dart';
import 'package:either_dart/either.dart';

class GetAuthorUseCase {
  final AuthorRepository repository;

  GetAuthorUseCase({required this.repository});

  Future<Either<Failure, AuthorEntity?>> execute(String userId) async {
    return await repository.getAuthor(userId);
  }
}
