import 'package:emotorad_task/src/features/employees/domain/repositories/repositories.dart';

class AddEmployee {
  final EmployeesRepository _repository;

  AddEmployee(this._repository);

  Future<void> call(String employeeName) async {
    await _repository.addEmployee(employeeName);
  }
}
