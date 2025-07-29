class ValidationUtils {
  static bool validateEmail(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool validatePassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  static bool validateName(String name) {
    return name.length >= 2 && !RegExp(r'[\d!@#\$%\^&\*\(\)]').hasMatch(name);
  }

  static bool validatePhone(String phone) {
    return RegExp(r'^\+?\d{10,15}$').hasMatch(phone);
  }

  static bool validateAge(DateTime birthDate) {
    final now = DateTime.now();
    final age = now.year - birthDate.year;
    return age >= 18;
  }
}
