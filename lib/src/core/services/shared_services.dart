import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  late SharedPreferences? prefs;

  static Future<SharedPreferences> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('employees') == null) {
      await prefs.setStringList(
          'employees', ['Aman Ali', 'Hrithik Mishra', 'Rohit Daftari']);
    }
    return prefs;
  }
}

class SharedPref {
  final SharedPreferences prefs;

  SharedPref(this.prefs);

  Future<bool> setEmployees(List<String> newEmployees) async {
    final existingEmployees = getEmployees();

    final response = await prefs.setStringList(
      'employees',
      existingEmployees..addAll(newEmployees),
    );
    return response;
  }

  List<String> getEmployees() {
    return prefs.getStringList('employees') ?? [];
  }
}
