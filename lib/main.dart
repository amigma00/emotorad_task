import 'package:emotorad_task/src/core/routes/router.dart';
import 'package:emotorad_task/src/core/services/bloc_observer.dart';
import 'package:emotorad_task/src/core/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  Bloc.observer = CustomBlocObserver();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
/*************  ✨ Codeium Command ⭐  *************/
  /// Builds the main widget tree for the application.
  ///
  /// This widget is wrapped in a [GestureDetector] to dismiss the keyboard
  /// when tapping outside of a text field. It returns a [MaterialApp.router]

/******  0405a6a6-9a75-4be9-8f04-11437417794a  *******/
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
      ),
    );
  }
}
