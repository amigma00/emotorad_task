// lib/features/home/domain/usecases/update_attendance.dart
import 'package:emotorad_task/src/features/home/domain/entities/employee_entry.dart';
import 'package:emotorad_task/src/features/home/domain/repositories/home_repository.dart';

class UpdateAttendance {
  final HomeRepository _repository;

  UpdateAttendance(this._repository);

  Future<bool> call({
    required String date,
    required EmployeeEntry entry,
    required int row,
  }) async {
    return await _repository.updateAttendance(
      date: date,
      entry: entry,
      row: row,
    );
  }
}
