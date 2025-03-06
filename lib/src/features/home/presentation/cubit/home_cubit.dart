import 'package:emotorad_task/src/core/services/gsheeets_service.dart';
import 'package:emotorad_task/src/core/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  fetchGsheets({String? date}) async {
    date ??= DateTime.now().toString();
    emit(HomeLoading());
    try {
      final data = await sl<GoogleSheetsService>().fetchAttendanceData(date);
      // print(data);
      emit(HomeLoaded(data: data));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  updateGsheet() async {
    emit(HomeLoading());
    try {
      // final data = await sl<GoogleSheetsService>().updateAttendance();
      // print(data);
      // emit(HomeLoaded(data: data));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
