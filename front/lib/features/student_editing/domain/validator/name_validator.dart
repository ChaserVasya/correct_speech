class NameValidator {
  String? validate(String? input) {
    if (input == null) return 'Введите текст';
    if (input.isEmpty) return 'Введите текст';
    if (input.contains(' ')) return 'Текст не должен содержать пробелы';
    return null;
  }
}
