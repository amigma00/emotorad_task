// lib/core/datasources/remote/employees_remote_data_source.dart
import 'package:emotorad_task/src/core/services/gsheeets_service.dart';
import 'package:emotorad_task/src/features/employees/domain/entities/employee.dart';

abstract class EmployeesDataSource {
  Future<List<Employee>> fetchEmployees();
  Future<void> addEmployee(String employeeName);
  Future<void> removeEmployeeByRowIndex(int rowIndex);
}

class EmployeesRemoteDataSource implements EmployeesDataSource {
  final GoogleSheetsApis _googleSheetsApis;

  EmployeesRemoteDataSource(this._googleSheetsApis);

  @override
  Future<List<Employee>> fetchEmployees() async {
    final data = await _googleSheetsApis.fetchEmployees();
    return data.map((name) => Employee(name: name)).toList();
  }

  @override
  Future<void> addEmployee(String employeeName) async {
    await _googleSheetsApis.addEmployees(employeeName: employeeName);
  }

  @override
  Future<void> removeEmployeeByRowIndex(int rowIndex) async {
    await _googleSheetsApis.removeEmployeeByRowIndex(rowIndex: rowIndex);
  }
}
