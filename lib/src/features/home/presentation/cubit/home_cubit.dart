import 'package:emotorad_task/src/features/home/domain/entities/employee_entry.dart';
import 'package:emotorad_task/src/features/home/domain/usecases/fetch_attendance_data.dart';
import 'package:emotorad_task/src/features/home/domain/usecases/fetch_sheet_names.dart';
import 'package:emotorad_task/src/features/home/domain/usecases/update_attendance.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FetchSheetNames _fetchSheetNames;
  final FetchAttendanceData _fetchAttendanceData;
  final UpdateAttendance _updateAttendance;

  String dropValue = '';

  HomeCubit({
    required FetchSheetNames fetchSheetNames,
    required FetchAttendanceData fetchAttendanceData,
    required UpdateAttendance updateAttendance,
  })  : _fetchSheetNames = fetchSheetNames,
        _fetchAttendanceData = fetchAttendanceData,
        _updateAttendance = updateAttendance,
        super(HomeDataState()) {
    loadData();
  }

  loadData() async {
    await fetchDates();
    await fetchGsheets();
  }

  fetchDates() async {
    final currentState = state as HomeDataState;

    emit(currentState.copyWith(isLoading: true));

    try {
      final sheetNames = await _fetchSheetNames();
      sheetNames.remove('employees');
      dropValue = sheetNames.last;
      final currentState = state as HomeDataState;
      emit(currentState.copyWith(isLoading: false, dropDowns: sheetNames));
    } catch (e) {
      emit(HomeDataState(error: e.toString()));
    }
  }

  fetchGsheets({String? date}) async {
    final currentState = state as HomeDataState;

    date ??= dropValue;
    emit(currentState.copyWith(isLoading: true));

    try {
      final data = await _fetchAttendanceData(date);

      emit(currentState.copyWith(isLoading: false, data: data));
    } catch (e) {
      emit(HomeDataState(error: e.toString()));
    }
  }

  updateGsheet(EmployeeEntry entry, int row, String worksheet) async {
    try {
      final success = await _updateAttendance(
        date: worksheet,
        entry: entry,
        row: row,
      );
      if (success) {
        fetchGsheets(date: worksheet);
      }
    } catch (e) {
      emit(HomeDataState(error: e.toString()));
    }
  }

  void onCheckInOutTap(
    BuildContext context, {
    required EmployeeEntry empentry,
    required bool isChekIn,
    required int row,
  }) async {
    var value = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (value != null) {
      DateTime dateTime = isChekIn ? empentry.checkIn : empentry.checkOut;

      DateTime newDT = DateTime(dateTime.year, dateTime.month, dateTime.day,
          value.hour, value.minute);
      isChekIn ? empentry.checkIn = newDT : empentry.checkOut = newDT;
      if (empentry.checkIn.isAfter(empentry.checkOut)) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Checkin time cannot be after Checkout Time')));
        return;
      } else if (empentry.checkOut.isBefore(empentry.checkIn)) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Checkout time cannot be before Checkin Time'),
        ));
        return;
      }
      updateGsheet(empentry, row, dropValue);
    }
  }

  void onCheckBoxTap(
    BuildContext context, {
    required EmployeeEntry empentry,
    required int row,
    required bool value,
  }) {
    empentry.isPresent = value;
    updateGsheet(empentry, row, dropValue);
  }
}

// List<EmployeeEntry> convertSheetDates(List<List<dynamic>> rows) {
//   DateTime googleBaseDate = DateTime(1899, 12, 30);

//   // return rows.map((row) {
//   return rows.map((cell) {
//     // var temp = double.tryParse(cell);
//     // if (temp != null) {
//     //   cell = temp;
//     // }
//     // if (cell is num) {
//     //   // Convert serial number to DateTime
//     //   return googleBaseDate
//     //       .add(Duration(milliseconds: (cell * 86400000).round()));
//     // }
//     return EmployeeEntry(
//       employeeName: cell[0],
//       checkIn: googleBaseDate.add(
//           Duration(milliseconds: (double.parse(cell[1]) * 86400000).round())),
//       checkOut: googleBaseDate.add(
//           Duration(milliseconds: (double.parse(cell[2]) * 86400000).round())),
//       isPresent: bool.tryParse(cell[3]) ?? true,
//     ); // Return as is if it's not a number
//   }).toList();
//   // }).toList();
// }
