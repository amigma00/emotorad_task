// lib/core/services/service_locator.dart
import 'package:emotorad_task/src/core/services/gsheeets_service.dart';
import 'package:emotorad_task/src/features/employees/data/implements/implements.dart';
import 'package:emotorad_task/src/features/employees/data/sources/employees_data_source.dart';
import 'package:emotorad_task/src/features/employees/domain/repositories/repositories.dart';
import 'package:emotorad_task/src/features/home/data/implements/home_repository_impl.dart';
import 'package:emotorad_task/src/features/home/data/sources/home_remote_data_source.dart';
import 'package:emotorad_task/src/features/home/domain/repositories/home_repository.dart';
import 'package:emotorad_task/src/features/home/domain/usecases/fetch_attendance_data.dart';
import 'package:emotorad_task/src/features/home/domain/usecases/fetch_sheet_names.dart';
import 'package:emotorad_task/src/features/home/domain/usecases/update_attendance.dart';
import 'package:emotorad_task/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:emotorad_task/src/features/employees/domain/usecases/fetch_employees.dart';
import 'package:emotorad_task/src/features/employees/domain/usecases/add_employee.dart';
import 'package:emotorad_task/src/features/employees/domain/usecases/remove_employee.dart';
import 'package:emotorad_task/src/features/employees/presentation/cubit/employees_cubit.dart';

final sl = GetIt.instance;
setupGS() async {
  final gSheet = await GoogleSheetsService.initialize();
  sl.registerSingleton<GoogleSheetsApis>(GoogleSheetsApis(gSheet));
}

Future<void> setupLocator() async {
  await setupGS();

  // Data sources
  sl.registerLazySingleton<HomeDataSource>(
    () => HomeRemoteDataSource(sl<GoogleSheetsApis>()),
  );

  sl.registerLazySingleton<EmployeesDataSource>(
    () => EmployeesRemoteDataSource(sl<GoogleSheetsApis>()),
  );

  // Repositories
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl<HomeDataSource>()),
  );

  sl.registerLazySingleton<EmployeesRepository>(
    () => EmployeesRepositoryImpl(sl<EmployeesDataSource>()),
  );

  // Use cases
  //Home
  sl.registerLazySingleton(() => FetchSheetNames(sl<HomeRepository>()));
  sl.registerLazySingleton(() => FetchAttendanceData(sl<HomeRepository>()));
  sl.registerLazySingleton(() => UpdateAttendance(sl<HomeRepository>()));
//Employees
  sl.registerLazySingleton(() => FetchEmployees(sl<EmployeesRepository>()));
  sl.registerLazySingleton(() => AddEmployee(sl<EmployeesRepository>()));
  sl.registerLazySingleton(() => RemoveEmployee(sl<EmployeesRepository>()));

  // Cubit
  sl.registerFactory(
    () => HomeCubit(
      fetchSheetNames: sl<FetchSheetNames>(),
      fetchAttendanceData: sl<FetchAttendanceData>(),
      updateAttendance: sl<UpdateAttendance>(),
    ),
  );

  sl.registerFactory(
    () => EmployeesCubit(
      fetchEmployeesUseCase: sl<FetchEmployees>(),
      addEmployee: sl<AddEmployee>(),
      removeEmployee: sl<RemoveEmployee>(),
    ),
  );
}
