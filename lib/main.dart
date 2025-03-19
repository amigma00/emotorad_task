import 'package:emotorad_task/src/core/routes/router.dart';
import 'package:emotorad_task/src/core/services/bloc_observer.dart';
import 'package:emotorad_task/src/core/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = CustomBlocObserver();
  return runInvoke();
}

runInvoke() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  return runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
      ),
    );
  }
}
