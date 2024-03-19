class Validators {
  static bool isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  static bool isValidIBAN(String value) {
    final RegExp ibanRegex = RegExp(
      "^(?:[A-Za-z]{2}[A-Z0-9]{22}|\\d{14}|03\\d{9}|\\+923\\d{9})\$",
    );
    return value.isNotEmpty && ibanRegex.hasMatch(value);
  }
}
