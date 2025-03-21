import 'package:emotorad_task/src/features/employees/data/sources/employees_data_source.dart';
import 'package:emotorad_task/src/features/employees/domain/entities/employee.dart';
import 'package:emotorad_task/src/features/employees/domain/repositories/repositories.dart';

class EmployeesRepositoryImpl implements EmployeesRepository {
  final EmployeesDataSource _dataSource;

  EmployeesRepositoryImpl(this._dataSource);

  @override
  Future<List<Employee>> fetchEmployees() async {
    return await _dataSource.fetchEmployees();
  }

  @override
  Future<void> addEmployee(String employeeName) async {
    await _dataSource.addEmployee(employeeName);
  }

  @override
  Future<void> removeEmployeeByRowIndex(int rowIndex) async {
    await _dataSource.removeEmployeeByRowIndex(rowIndex);
  }
}
