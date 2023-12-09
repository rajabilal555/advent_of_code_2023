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
