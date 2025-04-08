class FireBaseError {
  final String errorCode;
  FireBaseError(this.errorCode);

  String getMessage() {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'Este e-mail já foi cadastrado.';
      case 'invalid-email':
        return 'E-mail inválido.';
      case 'operation-not-allowed':
        return 'O método de autenticaçao foi desabilitado no Firebase';
      case 'weak-password':
        return 'Senha muito fraca, digite pelo menos 6 carácteres';
      case 'user-disabled':
        return 'Usuário desabilitado';
      case 'user-not-found':
        return 'Usuário ou senha inválidos';
      case 'wrong-password':
        return 'Usuário ou senha inválidos';
      case 'invalid-credential':
        return 'Usuário ou senha inválidos';
      default:
        return 'Erro desconhecido... $errorCode';
    }
  }
}
