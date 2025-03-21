import 'package:intl/intl.dart';

class DateTimeUtil {
  static String getTime(DateTime date) {
    return DateFormat.jm().format(date);
  }

  static String calculateOvertime(DateTime checkInTime, DateTime checkOutTime,
      {int standardHours = 9}) {
    Duration totalWorked = checkOutTime.difference(checkInTime);
    int totalMinutes = totalWorked.inMinutes;
    int standardMinutes = standardHours * 60;

    if (totalMinutes > standardMinutes) {
      int overtimeMinutes = totalMinutes - standardMinutes;
      int overtimeHours = overtimeMinutes ~/ 60;
      int remainingMinutes = overtimeMinutes % 60;

      return "$overtimeHours h ${remainingMinutes > 0 ? '$remainingMinutes m' : ''}"
          .trim();
    }

    return "--";
  }
}
