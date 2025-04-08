import 'package:case_fire/core/errors/failure.dart';
import 'package:case_fire/modules/author/domain/entities/author_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AuthorState extends Equatable {
  const AuthorState();

  @override
  List<Object> get props => [];
}

class AuthorInitial extends AuthorState {}

class AuthorLoading extends AuthorState {}

class AuthorLoaded extends AuthorState {
  final AuthorEntity? author;

  const AuthorLoaded({this.author});

  @override
  List<Object> get props => [author ?? 'null'];
}

class AuthorError extends AuthorState {
  final Failure failure;

  const AuthorError({required this.failure});

  @override
  List<Object> get props => [failure];
}
