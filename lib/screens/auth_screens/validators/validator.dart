class Validators {
  static String? validateEmail(String value) {
    final RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value.isEmpty) {
      return 'Enter Email';
    } else if (!regex.hasMatch(value)) {
      return 'Invalid Email';
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Enter password';
    } else if (value.length < 6) {
      return 'Minimum characters for password are 6';
    } else {
      return null;
    }
  }

  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'Enter username';
    } else if (value.length < 3) {
      return 'Invalid Name';
    } else {
      return null;
    }
  }

  static String? validateNumber(String value) {
    if (value.isEmpty) {
      return 'Fill this form';
    } else {
      return null;
    }
  }
}
