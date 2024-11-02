import 'package:intl/intl.dart';

extension CustomDateFormatting on DateTime {
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

  // Method to format DateTime as '24th Oct 2024'
  String toCustomFormattedString() {
    // Day suffix logic

    // Format the date
    String day = this.day.toString();
    String suffix = daySuffix(this.day);
    String month = DateFormat('MMM').format(this); // Short month format
    String year = this.year.toString();

    // Combine formatted parts
    return '$day$suffix $month $year';
  }

  String formatDateTimeWithAmPm() {
    // Define the suffix for the day
    String suffix = daySuffix(this.day);

    // Format the date and time
    String formattedDate =
        DateFormat("d'$suffix' MMM yyyy 'at' h:mm a").format(this);
    return formattedDate;
  }
}
