class InputValidationHelper {
  static String? validateEmail(String email) {
    String emailPattern =
        r"^(?!@)(?!.*@.*@)(?!.*\.$)(?!\.\.)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
    RegExp regExp = RegExp(emailPattern);

    if (!regExp.hasMatch(email)) {
      return 'Please enter a valid email address (e.g., user@example.com)';
    }

    return null;
  }

  static String? validatePassword(String password) {
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(r'[a-zA-Z]').hasMatch(password)) {
      return 'Password must contain at least one letter';
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must contain at least one number';
    }
    return null;
  }
}
