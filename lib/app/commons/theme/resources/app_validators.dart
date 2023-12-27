mixin AppValidatorsMixin {
  String? isNotEmpty(String? value, [String? message]) {
    if (value == null || value.isEmpty) return message ?? 'Campo obrigatório';
    return null;
  }

  String? validateEmail(String? value, [String? message]) {
    final RegExp regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final format = regExp.hasMatch(value ?? '');
    if (!format) return message ?? 'Formato de email inválido (email@gmail.com)';
    return null;
  }

  String? validatePassword(String? value, [String? message]) {
    if ((value?.length ?? 0) < 6) {
      return message ?? 'A senha deve conter no mínimo 6 caracteres';
    }
    return null;
  }

  String? validateConfirmationPassword(String? confirmation, String password, [String? message]) {
    if (confirmation != password) {
      return message ?? 'Senha e confirmação de senha devem ser os mesmos';
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
