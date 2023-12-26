mixin AppValidatorsMixin {
  String? isNotEmpty(String? value, [String? message]) {
    if (value == null || value.isEmpty) return message ?? 'Campor requerido';
    return null;
  }

  String? validateEmail(String? value, [String? message]) {
    final RegExp regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final format = regExp.hasMatch(value ?? '');
    if (!format) return message ?? 'Formato invalido (email@gmail.com)';
    return null;
  }

  String? validatePasswordRules(String? value, [String? message]) {
    RegExp regExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\-])[A-Za-z\d!@#$%^&*()_+{}\[\]:;<>,.?~\\-]+$',
    );
    final format = regExp.hasMatch(value ?? '');
    if (!format) {
      return message ?? 'Debe tener números, letras y caracteres especiales';
    }
    return null;
  }

  String? validatePassword(String? value, [String? message]) {
    if ((value?.length ?? 0) < 8) {
      return message ?? 'Minimo requerido: 8 caracteres';
    }
    return null;
  }

  String? validateConfirmationPassword(String? confirmation, String password,
      [String? message]) {
    if (confirmation != password) {
      return message ?? 'Las contraseñas deben ser las mismas';
    }
    return null;
  }

  String? validateConfirmationCode(String? value, [String? message]) {
    if ((value?.length ?? 0) != 6) {
      return message ?? 'El código debe tener 6 caracteres';
    }
    return null;
  }

  String? combineValidations(List<String? Function()> validators) {
    for (final validator in validators) {
      final result = validator();
      if (result != null) return result;
    }
    return null;
  }
}
