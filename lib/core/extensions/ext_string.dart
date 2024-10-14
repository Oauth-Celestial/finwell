extension StringHelper on String {
  int get removeCommas {
    String value = replaceAll(",", "");
    return int.parse(value.isEmpty ? "0" : value);
  }
}
