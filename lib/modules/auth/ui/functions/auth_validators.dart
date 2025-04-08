class AuthValidators {
  bool emailValidator(String email) {
    if (email.isEmpty) {
      return false;
    }
    return true;
  }

  bool passValidator(String pass) {
    if (pass.isEmpty) {
      return false;
    }
    return true;
  }
}
