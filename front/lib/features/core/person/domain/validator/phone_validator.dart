class PhoneValidator {
  final _phoneLength = '8' '111' '222' '33' '44'.length;

  String? validate(String? input) {
    if (input == null) return 'Заполните номер';
    if (input.isEmpty) return 'Заполните номер';
    if (input.runes.first != '8'.runes.single) return 'Номер должен начинаться с 8';
    if (input.length != _phoneLength) return 'Номер должен содержать $_phoneLength символов';
    if (input.contains(RegExp(r'\D'))) return 'Номер должен содержать только цифры';
    return null;
  }
}
