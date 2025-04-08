class PostModel {
  final int id;
  final String title;
  final String body;
  final int userId;
  final String? userPhotoUrl;
  final String? userName;
  final int? userAge;
  final List<String>? userGostos;
  final int? numPost;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    this.userPhotoUrl,
    this.userName,
    this.userAge,
    this.userGostos,
    this.numPost,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      userId: json['userId'] as int,
      userPhotoUrl: json['foto'] as String?,
      userName: json['nome'] as String?,
      userAge: json['idade'] as int?,
      userGostos: (json['gostos'] as List<dynamic>?)?.cast<String>(),
      numPost: json['num_post'] as int?,
    );
  }
}
