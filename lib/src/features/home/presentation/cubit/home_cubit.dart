import 'package:emotorad_task/src/core/services/gsheeets_service.dart';
import 'package:emotorad_task/src/core/services/service_locator.dart';
import 'package:emotorad_task/src/models/employee_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  fetchGsheets({String? date}) async {
    date ??= DateTime.now().toString().split(' ')[0];
    emit(HomeLoading());
    try {
      final data = await sl<GoogleSheetsApis>().fetchAttendanceData(date);
      final dates = convertSheetDates(data);

      emit(HomeLoaded(data: dates));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  updateGsheet(EmployeeEntry entry, int row, String worksheet) async {
    emit(HomeLoading());
    try {
      final data = await sl<GoogleSheetsApis>()
          .updateAttendance(date: worksheet, entry: entry, row: row);
      if (data) {
        fetchGsheets(date: worksheet);
      }
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  void onCheckInOutTap(BuildContext context,
      {required EmployeeEntry empentry,
      required bool isChekIn,
      required int row,
      required String worksheet}) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then(
      (value) {
        if (value != null) {
          DateTime dateTime = isChekIn ? empentry.checkIn : empentry.checkOut;

          DateTime newDT = DateTime(dateTime.year, dateTime.month, dateTime.day,
              value.hour, value.minute);

          updateGsheet(empentry, row, worksheet);
        }
      },
    );
  }
}

List<EmployeeEntry> convertSheetDates(List<List<dynamic>> rows) {
  DateTime googleBaseDate = DateTime(1899, 12, 30);

  // return rows.map((row) {
  return rows.map((cell) {
    // var temp = double.tryParse(cell);
    // if (temp != null) {
    //   cell = temp;
    // }
    // if (cell is num) {
    //   // Convert serial number to DateTime
    //   return googleBaseDate
    //       .add(Duration(milliseconds: (cell * 86400000).round()));
    // }
    return EmployeeEntry(
        employeeName: cell[0],
        checkIn: googleBaseDate.add(
            Duration(milliseconds: (double.parse(cell[1]) * 86400000).round())),
        checkOut: googleBaseDate.add(Duration(
            milliseconds: (double.parse(cell[2]) * 86400000)
                .round()))); // Return as is if it's not a number
  }).toList();
  // }).toList();
}
