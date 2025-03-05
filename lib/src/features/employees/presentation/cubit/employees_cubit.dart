
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:meta/meta.dart';

  part 'employees_state.dart';
  
  class EmployeesCubit extends Cubit<EmployeesState> {
    EmployeesCubit() : super(EmployeesInitial());
  }
  