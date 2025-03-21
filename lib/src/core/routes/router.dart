import 'package:emotorad_task/src/features/employees/presentation/pages/employees_pages.dart';
import 'package:emotorad_task/src/features/home/presentation/pages/home_page.dart';
import 'package:emotorad_task/src/features/navigation/presentation/pages/navigation_page.dart';

import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
          builder: (context, state, child) => NavigationPage(child: child),
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => HomePage(),
            ),
            GoRoute(
              path: '/employees',
              builder: (context, state) => EmployeesPage(),
            ),
          ]),
    ],
  );
}
