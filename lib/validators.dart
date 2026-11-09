
class Validators {
  static String? requiredField(
      String value, {
        String fieldName = 'Поле',
      }) {
    if (value.trim().isEmpty) {
      return '$fieldName обовʼязкове для заповнення';
    }
    return null;
  }

  static String? email(String value) {
    if (value.trim().isEmpty) {
      return 'Введіть електронну пошту';
    }

    final emailRegex = RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Введіть коректний email';
    }

    return null;
  }

  static String? password(String value) {
    if (value.isEmpty) {
      return 'Введіть пароль';
    }

    if (value.length < 7) {
      return 'Пароль повинен містити не менше 7 символів';
    }

    return null;
  }
}
