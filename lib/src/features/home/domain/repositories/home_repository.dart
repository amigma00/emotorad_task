import 'package:emotorad_task/src/features/home/domain/entities/employee_entry.dart';

abstract class HomeRepository {
  Future<List<String>> fetchSheetNames();
  Future<List<EmployeeEntry>> fetchAttendanceData(String date);
  Future<bool> updateAttendance({
    required String date,
    required EmployeeEntry entry,
    required int row,
  });
}
