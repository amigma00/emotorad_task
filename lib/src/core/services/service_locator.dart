import 'package:emotorad_task/src/core/services/gsheeets_service.dart';
import 'package:emotorad_task/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupLocator() async {
//initialization

//others
  sl.registerSingleton<GoogleSheetsService>(GoogleSheetsService());

//DatSources
  // sl.registerLazySingleton<AddEditEmployeeLocalDataSource>(
  //   () => AddEditEmployeeLocalDataSource(),
  // );
  // sl.registerLazySingleton<HomeLocalDataSource>(
  //   () => HomeLocalDataSource(),
  // );

  // //Repositories
  // sl.registerLazySingleton<AddEditEmployeeRepository>(
  //   () => AddEditEmployeeRepositoryImp(
  //       localDataSource: sl<AddEditEmployeeLocalDataSource>()),
  // );
  // sl.registerLazySingleton<HomeRepository>(
  //   () => HomeRepositoryImp(localDataSource: sl<HomeLocalDataSource>()),
  // );

  // //Usecases
  // sl.registerLazySingleton<GetAddEditEmployeeUseCase>(
  //   () =>
  //       GetAddEditEmployeeUseCase(repository: sl<AddEditEmployeeRepository>()),
  // );
  // sl.registerLazySingleton<GetHomeUseCase>(
  //   () => GetHomeUseCase(repository: sl<HomeRepository>()),
  // );

  //Cubits
  sl.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
  // sl.registerLazySingleton<HomeCubit>(
  //   () => HomeCubit(getUsecase: sl<GetHomeUseCase>()),
  // );
}
