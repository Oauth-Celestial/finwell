import 'package:intl/intl.dart';

extension StringHelper on String {
  int get removeCommas {
    String value = replaceAll(",", "");
    return int.parse(value.isEmpty ? "0" : value);
  }

  static const _locale = 'en';

  // Method to format a string number as a decimal pattern
  String formatAsNumber() {
    return NumberFormat.decimalPattern(_locale)
        .format(int.parse(this.isEmpty ? "0" : this));
  }

  // Method to get the currency symbol for the locale
  String get currencySymbol {
    return NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  }
}
