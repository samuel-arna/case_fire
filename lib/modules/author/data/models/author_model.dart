class AuthorModel {
  final String? foto;
  final String? nome;
  final int? idade;
  final List<dynamic>? gostos;
  final int? numPost;

  AuthorModel({this.foto, this.nome, this.idade, this.gostos, this.numPost});

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      foto: json['foto'] as String?,
      nome: json['nome'] as String?,
      idade: json['idade'] as int?,
      gostos: json['gostos'] as List<dynamic>?,
      numPost: json['num_post'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foto': foto,
      'nome': nome,
      'idade': idade,
      'gostos': gostos,
      'numPost': numPost,
    };
  }
}
