

// lib/core/repositories/home_repository_impl.dart
import 'package:emotorad_task/src/features/home/data/sources/home_remote_data_source.dart';
import 'package:emotorad_task/src/features/home/domain/entities/employee_entry.dart';
import 'package:emotorad_task/src/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource _dataSource;

  HomeRepositoryImpl(this._dataSource);

  @override
  Future<List<String>> fetchSheetNames() async {
    return await _dataSource.fetchSheetNames();
  }

  @override
  Future<List<EmployeeEntry>> fetchAttendanceData(String date) async {
    final data = await _dataSource.fetchAttendanceData(date);
    return _convertSheetDates(data);
  }

  @override
  Future<bool> updateAttendance({
    required String date,
    required EmployeeEntry entry,
    required int row,
  }) async {
    return await _dataSource.updateAttendance(
      date: date,
      entry: entry,
      row: row,
    );
  }

  List<EmployeeEntry> _convertSheetDates(List<List<dynamic>> rows) {
    DateTime googleBaseDate = DateTime(1899, 12, 30);

    return rows.map((cell) {
      return EmployeeEntry(
        employeeName: cell[0],
        checkIn: googleBaseDate.add(
            Duration(milliseconds: (double.parse(cell[1]) * 86400000).round())),
        checkOut: googleBaseDate.add(
            Duration(milliseconds: (double.parse(cell[2]) * 86400000).round())),
        isPresent: bool.tryParse(cell[3]) ?? true,
      );
    }).toList();
  }
}