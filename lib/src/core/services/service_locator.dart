import 'package:emotorad_task/src/core/services/gsheeets_service.dart';
import 'package:emotorad_task/src/core/services/shared_services.dart';
import 'package:emotorad_task/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

setupSf() async {
  final sharedPref = await SharedPrefService.init();
  sl.registerSingleton<SharedPref>(SharedPref(sharedPref));
  debugPrintStack(label: 'SF initialized');
}

setupGS() async {
  final gSheet = await GoogleSheetsService.initialize();
  sl.registerSingleton<GoogleSheetsApis>(GoogleSheetsApis(gSheet));
}

Future<void> setupLocator() async {
//initialization
  await setupSf();
  await setupGS();
//others

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
