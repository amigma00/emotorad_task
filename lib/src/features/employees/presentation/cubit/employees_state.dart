part of 'employees_cubit.dart';

@immutable
abstract class EmployeesState {}

class EmployeesDataState extends EmployeesState {
  final bool isLoading;
  final List<Employee> employees;

  final String? error;

  EmployeesDataState({
    this.isLoading = false,
    this.employees = const [],
    this.error,
  });

  EmployeesDataState copyWith({
    bool? isLoading,
    List<Employee>? employees,
    String? error,
  }) {
    return EmployeesDataState(
      isLoading: isLoading ?? this.isLoading,
      employees: employees ?? this.employees,
      error: error,
    );
  }
}

class HomeErrorState extends EmployeesState {
  final String error;
  HomeErrorState({required this.error});
}
