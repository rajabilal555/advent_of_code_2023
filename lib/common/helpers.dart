bool isNumeric(String? s) {
  return double.tryParse(s ?? '') != null;
}

bool isSymbol(String? s) {
  return RegExp(r'[\=\`\[\]\;\\\/\,\_\~\!\(\)\^\*\#\+\$\@\&\-\%]')
      .hasMatch(s ?? '');
}

String safeGetString(List<String> list, int index) {
  if (index < 0 || index >= list.length) {
    return '';
  }
  return list[index];
}

extension CustomIterables on List<String> {
  Iterable<String> removeEmpty() {
    return where((element) => element.isNotEmpty);
  }
}

extension NumberMaps on Map<dynamic, int> {
  /// returns the value of the key or 0 if the key is not found
  int getOrZero(dynamic key) {
    return (this[key] ?? 0);
  }
}
