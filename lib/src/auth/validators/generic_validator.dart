class GenericaValidator {
  String? emailValidator(String? value) {
    final _value = value ?? '';
    if (_value.isEmpty) return 'Campo vazio';
    if (!RegExp(r'[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+').hasMatch(_value)) return 'Formato incorreto.';
    return null;
  }

  String? passwordValidator(String? value) {
    final _value = value ?? '';
    if (_value.isEmpty) return 'Campo vazio';
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    final _value = value ?? '';
    if (_value.isEmpty) return 'Campo vazio';
    return null;
  }
}
