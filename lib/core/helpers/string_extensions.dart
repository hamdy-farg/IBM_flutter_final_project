extension ExString on String {
  bool get isValidEmail {
    final emailRegExp =
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidName {
    // This regex ensures no invalid characters are present in a name
    final firstRegExp =
        RegExp(r'^[^.!@#<>?":_\`~;\[\]|=\-+()\*&^%1234567890]+$');
    return firstRegExp.hasMatch(this);
  }
}
