import 'package:intl/intl.dart';

extension CustomDateFormatting on DateTime {
  // Method to format DateTime as '24th Oct 2024'
  String toCustomFormattedString() {
    // Day suffix logic
    String daySuffix(int day) {
      if (day >= 11 && day <= 13) {
        return 'th';
      }
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    // Format the date
    String day = this.day.toString();
    String suffix = daySuffix(this.day);
    String month = DateFormat('MMM').format(this); // Short month format
    String year = this.year.toString();

    // Combine formatted parts
    return '$day$suffix $month $year';
  }
}
