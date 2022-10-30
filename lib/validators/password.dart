///simple validation of password based on length.

class Password {
  Password(this.password);

  String password;

  static bool validate(String password) {
    if (password != '' && password.length >= 6 ) {
      return true;
    }
    return false;
  }
}
