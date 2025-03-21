import 'package:emotorad_task/src/core/services/gsheeets_service.dart';
import 'package:emotorad_task/src/features/home/domain/entities/employee_entry.dart';

abstract class HomeDataSource {
  Future<List<String>> fetchSheetNames();
  Future<List<List<dynamic>>> fetchAttendanceData(String date);
  Future<bool> updateAttendance({
    required String date,
    required EmployeeEntry entry,
    required int row,
  });
}

class HomeRemoteDataSource implements HomeDataSource {
  final GoogleSheetsApis _googleSheetsApis;

  HomeRemoteDataSource(this._googleSheetsApis);

  @override
  Future<List<String>> fetchSheetNames() async {
    return await _googleSheetsApis.fetchSheetNames();
  }

  @override
  Future<List<List<dynamic>>> fetchAttendanceData(String date) async {
    return await _googleSheetsApis.fetchAttendanceData(date);
  }

  @override
  Future<bool> updateAttendance({
    required String date,
    required EmployeeEntry entry,
    required int row,
  }) async {
    return await _googleSheetsApis.updateAttendance(
      date: date,
      entry: entry,
      row: row,
    );
  }
}
