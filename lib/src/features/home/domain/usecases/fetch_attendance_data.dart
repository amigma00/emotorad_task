import 'package:emotorad_task/src/features/home/domain/entities/employee_entry.dart';
import 'package:emotorad_task/src/features/home/domain/repositories/home_repository.dart';

class FetchAttendanceData {
  final HomeRepository _repository;

  FetchAttendanceData(this._repository);

  Future<List<EmployeeEntry>> call(String date) async {
    return await _repository.fetchAttendanceData(date);
  }
}
