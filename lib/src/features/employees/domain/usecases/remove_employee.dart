import 'package:emotorad_task/src/features/employees/domain/repositories/repositories.dart';

class RemoveEmployee {
  final EmployeesRepository _repository;

  RemoveEmployee(this._repository);

  Future<void> call(int rowIndex) async {
    await _repository.removeEmployeeByRowIndex(rowIndex);
  }
}
