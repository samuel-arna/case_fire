import 'package:equatable/equatable.dart';

class AuthorEntity extends Equatable {
  final String? userPhotoUrl;
  final String? userName;
  final int? userAge;
  final List<String>? userGostos;
  final int? numPost;

  const AuthorEntity({
    this.userPhotoUrl,
    this.userName,
    this.userAge,
    this.userGostos,
    this.numPost,
  });

  @override
  List<Object?> get props => [
    userPhotoUrl,
    userName,
    userAge,
    userGostos,
    numPost,
  ];
}
