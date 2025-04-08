import 'package:equatable/equatable.dart';

abstract class AuthorEvent extends Equatable {
  const AuthorEvent();

  @override
  List<Object> get props => [];
}

class GetAuthorEvent extends AuthorEvent {
  final String userId;

  const GetAuthorEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}
