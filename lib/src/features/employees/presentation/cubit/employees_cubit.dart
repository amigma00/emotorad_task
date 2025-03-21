import 'package:emotorad_task/src/features/employees/domain/entities/employee.dart';
import 'package:emotorad_task/src/features/employees/domain/usecases/add_employee.dart';
import 'package:emotorad_task/src/features/employees/domain/usecases/fetch_employees.dart';
import 'package:emotorad_task/src/features/employees/domain/usecases/remove_employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  final FetchEmployees _fetchEmployeesUseCase;
  final AddEmployee _addEmployee;
  final RemoveEmployee _removeEmployee;

  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  EmployeesCubit({
    required FetchEmployees fetchEmployeesUseCase,
    required AddEmployee addEmployee,
    required RemoveEmployee removeEmployee,
  })  : _fetchEmployeesUseCase = fetchEmployeesUseCase,
        _addEmployee = addEmployee,
        _removeEmployee = removeEmployee,
        super(EmployeesDataState()) {
    fetchEmployees();
  }

  fetchEmployees() async {
    final currentState = state as EmployeesDataState;
    emit(currentState.copyWith(isLoading: true));
    try {
      final employess = await _fetchEmployeesUseCase();

      emit(currentState.copyWith(isLoading: false, employees: employess));
    } catch (e) {
      emit(EmployeesDataState(error: e.toString()));
    }
  }

  addEmployee(String employeeName) async {
    final currentState = state as EmployeesDataState;
    emit(currentState.copyWith(isLoading: true));
    try {
      await _addEmployee(employeeName);
      emit(currentState.copyWith(isLoading: false));
      nameController.clear();
      fetchEmployees();
    } catch (e) {
      emit(EmployeesDataState(error: e.toString()));
    }
  }

  removeEmployee({required int rowIndex}) async {
    final currentState = state as EmployeesDataState;
    emit(currentState.copyWith(isLoading: true));
    try {
      await _removeEmployee(rowIndex);
      emit(currentState.copyWith(isLoading: false));
      fetchEmployees();
    } catch (e) {
      emit(EmployeesDataState(error: e.toString()));
    }
  }
}
