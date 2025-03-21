import 'package:emotorad_task/src/features/employees/domain/entities/employee.dart';

abstract class EmployeesRepository {
  Future<List<Employee>> fetchEmployees();
  Future<void> addEmployee(String employeeName);
  Future<void> removeEmployeeByRowIndex(int rowIndex);
}
