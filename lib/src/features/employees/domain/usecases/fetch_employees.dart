import 'package:emotorad_task/src/features/employees/domain/entities/employee.dart';
import 'package:emotorad_task/src/features/employees/domain/repositories/repositories.dart';

class FetchEmployees {
  final EmployeesRepository _repository;

  FetchEmployees(this._repository);

  Future<List<Employee>> call() async {
    return await _repository.fetchEmployees();
  }
}

