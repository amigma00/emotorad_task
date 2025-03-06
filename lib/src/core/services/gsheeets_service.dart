// import 'package:googleapis/sheets/v4.dart' as sheets;
// import 'package:googleapis_auth/auth_io.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';

class GoogleSheetsService {
  bool isInitialized = false; // Track initialization
  static const String _spreadsheetId =
      "1x6e9JXDz3cj7xu3K13ox_d6f_V-FRlObwxpX2ivEro4";
  // sheets.SheetsApi? sheetsApi; // Nullable to avoid late initialization error
  GSheets? gSheets;
  late Spreadsheet? ss;

  GoogleSheetsService() {
    init();
  }

  Future init() async {
    await _initialize();
  }

  /// Initialize Google Sheets API**
  Future<void> _initialize() async {
    if (isInitialized) return; // Prevent multiple initializations

    try {
      final credentials = jsonDecode(await rootBundle
          .loadString('assets/emotorad-task-aea5a30fae16.json'));

      gSheets = GSheets(credentials);

      ss = await gSheets?.spreadsheet(_spreadsheetId);

      // sheetsApi = sheets.SheetsApi(client); // Initialize API
      isInitialized = true;
      print("Google Sheets initialized successfully!");
    } catch (e) {
      print("Error initializing Google Sheets: $e");
      throw Exception("Failed to initialize Google Sheets");
    }
  }

  /// Fetch Attendance Data**
  Future<List<List<String>>> fetchAttendanceData(String date) async {
    if (gSheets == null) {
      throw Exception("GoogleSheetsService is not initialized.");
    }

    try {
      final response = ss?.worksheetByTitle(date)?.values.allRows();

      return response ?? [];
    } catch (e) {
      print("Error fetching attendance data: $e");
      throw Exception("Failed to fetch attendance data.");
    }
  }

  /// **Update Attendance**
  Future<void> updateAttendance(
      {required String employeeName,
      required String checkIn,
      required String checkOut,
      required String date}) async {
    if (gSheets == null) {
      throw Exception(
          "GoogleSheetsService has not been initialized. Call initialize() first.");
    }

    final worksheet = ss?.worksheetByTitle(date);
    await worksheet?.values.insertRow(1, [employeeName, checkIn, checkOut]);

    print("Attendance updated successfully!");
  }

  Future<void> addEmployee(String employeeName, String date) async {
    if (gSheets == null) {
      throw Exception("GoogleSheetsService is not initialized.");
    }
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
