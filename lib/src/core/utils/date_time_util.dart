import 'package:intl/intl.dart';

class DateTimeUtil {
  static String getTime(DateTime date) {
    return DateFormat.jm().format(date);
  }

  static double calculateOvertime(DateTime checkOutTime,
      {int standardHour = 18, int standardMinute = 0}) {
    DateTime standardTime = DateTime(checkOutTime.year, checkOutTime.month,
        checkOutTime.day, standardHour, standardMinute, 0);

    if (checkOutTime.isAfter(standardTime)) {
      Duration overtime = checkOutTime.difference(standardTime);
      return overtime.inMinutes / 60.0; // Convert minutes to decimal hours
    }

    return 0.0; // No overtime
  }
}
