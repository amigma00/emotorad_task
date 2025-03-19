// import 'package:googleapis/sheets/v4.dart' as sheets;
// import 'package:googleapis_auth/auth_io.dart';
import 'dart:convert';
import 'package:emotorad_task/src/core/services/service_locator.dart';
import 'package:emotorad_task/src/core/services/shared_services.dart';
import 'package:emotorad_task/src/models/employee_entry.dart';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';

class GoogleSheetsService {
  static Future<Spreadsheet> initialize() async {
    const String spreadsheetId = "1x6e9JXDz3cj7xu3K13ox_d6f_V-FRlObwxpX2ivEro4";
    try {
      final credentials = jsonDecode(await rootBundle
          .loadString('assets/emotorad-task-aea5a30fae16.json'));
      GSheets gSheets = GSheets(credentials);
      Spreadsheet ss = await gSheets.spreadsheet(spreadsheetId);
      print("Google Sheets initialized successfully!");

      final todayDate = DateTime.now().toString().split(' ')[0];
      final existingSheet =
          await ss.worksheetByTitle(todayDate)?.values.allRows();
      if (existingSheet?.isEmpty ?? true) {
        DateTime now = DateTime.now();
        DateTime nineAM = DateTime(now.year, now.month, now.day, 9, 0, 0);
        DateTime sixPM = DateTime(now.year, now.month, now.day, 18, 0, 0);
        final newSheet = await ss.addWorksheet(todayDate);
        final worksheet = ss.worksheetByTitle("employees");
        if (worksheet == null) {
          throw Exception("Worksheet 'employees' not found.");
        }
        final data = await worksheet.values.allRows();
        final employees =
            data.map((row) => row.isNotEmpty ? row[0] : "").toList();
        for (int i = 0; i < employees.length; i++) {
          await newSheet.values.appendRow([
            employees[i],
            nineAM.toIso8601String(),
            sixPM.toIso8601String()
          ]);
        }
      }
      return ss;
    } catch (e) {
      print("Error initializing Google Sheets: $e");
      throw Exception("Failed to initialize Google Sheets");
    }
  }
}

class GoogleSheetsApis {
  final Spreadsheet _ss;
  GoogleSheetsApis(this._ss);

  Future<List<String>> fetchEmployees() async {
    try {
      final worksheet = _ss.worksheetByTitle("employees");
      if (worksheet == null) {
        throw Exception("Worksheet 'employees' not found.");
      }

      final data = await worksheet.values.allRows();

      // Assuming employee names are in the first column
      return data.map((row) => row.isNotEmpty ? row[0] : "").toList();
    } catch (e) {
      print("Error fetching employees: $e");
      throw Exception("Failed to fetch employees.");
    }
  }

  Future<List<String>> fetchSheetNames() async {
    try {
      return _ss.sheets.map((sheet) => sheet.title).toList();
    } catch (e) {
      print("Error fetching sheet names: $e");
      throw Exception("Failed to fetch sheet names.");
    }
  }

  /// Fetch Attendance Data**
  Future<List<List<String>>> fetchAttendanceData(String date) async {
    try {
      final response = await _ss.worksheetByTitle(date)?.values.allRows();
      return response ?? [];
    } catch (e) {
      print("Error fetching attendance data: $e");
      throw Exception("Failed to fetch attendance data.");
    }
  }

  /// **Update Attendance**
  Future<bool> updateAttendance({
    required EmployeeEntry entry,
    required String date,
    required int row,
  }) async {
    final worksheet = _ss.worksheetByTitle(date);
    final response = await worksheet?.values.insertRow(row + 1, [
      entry.employeeName,
      entry.checkIn.toString(),
      entry.checkOut.toString()
    ]);
    print("Attendance updated successfully!");
    return response ?? false;
  }

  /// **Add Attendance**

  Future<void> addAttendance({
    required String employeeName,
    required String checkIn,
    required String checkOut,
    required String date,
  }) async {
    final worksheet = _ss.worksheetByTitle(date);
    await worksheet?.values.appendRow([employeeName, checkIn, checkOut]);
  }

  // Future<void> removeEmployee(String employeeName) async {
  //   if (gSheets == null) {
  //     throw Exception("GoogleSheetsService is not initialized.");
  //   }
  //   final data = await fetchAttendanceData();
  //   for (int i = 0; i < data.length; i++) {
  //     if (data[i].length >= 4 && data[i][0] == employeeName) {
  //       await deleteRow(data[i]);
  //       break;
  //     }
  //   }
  // }

  // /// **Delete a Row**
  // Future<void> deleteRow(List<dynamic> rowToDelete) async {
  //   if (gSheets == null) {
  //     throw Exception(
  //         "GoogleSheetsService has not been initialized. Call initialize() first.");
  //   }

  //   // Fetch all rows from the sheet
  //   final data = await fetchAttendanceData();

  //   // Find the index of the row to delete
  //   int rowIndex = -1;
  //   for (int i = 0; i < data.length; i++) {
  //     if (data[i].toString() == rowToDelete.toString()) {
  //       rowIndex = i + 1; // Rows are 1-indexed in Google Sheets
  //       break;
  //     }
  //   }

  //   if (rowIndex == -1) {
  //     throw Exception("Row not found in the sheet.");
  //   }

  //   // Create a DimensionRange to specify the row to delete
  //   final dimensionRange = sheets.DimensionRange()
  //     ..sheetId = 0 // Assuming the sheet ID is 0
  //     ..dimension = "ROWS"
  //     ..startIndex = rowIndex - 1 // Convert to 0-based index
  //     ..endIndex = rowIndex; // End index is exclusive

  //   // Create a DeleteDimensionRequest
  //   final deleteRequest = sheets.DeleteDimensionRequest()
  //     ..range = dimensionRange;

  //   // Create a Request object
  //   final request = sheets.Request()..deleteDimension = deleteRequest;

  //   // Create a BatchUpdateSpreadsheetRequest
  //   final batchUpdateRequest = sheets.BatchUpdateSpreadsheetRequest()
  //     ..requests = [request];

  //   // Execute the batch update
  //   await gSheets!.spreadsheets.batchUpdate(batchUpdateRequest, _spreadsheetId);

  //   print("Row deleted successfully!");
  // }
}
