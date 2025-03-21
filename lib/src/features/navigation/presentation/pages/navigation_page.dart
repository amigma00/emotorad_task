import 'package:emotorad_task/src/core/services/service_locator.dart';
import 'package:emotorad_task/src/features/employees/presentation/cubit/employees_cubit.dart';
import 'package:emotorad_task/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NavigationPage extends StatelessWidget {
  final Widget child;
  const NavigationPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => sl<HomeCubit>(),
        ),
        BlocProvider<EmployeesCubit>(
          create: (context) => sl<EmployeesCubit>(),
        ),
      ],
      child: Scaffold(
        body: child,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _getCurrentIndex(context),
          onTap: (index) {
            switch (index) {
              case 0:
                context.go('/home');
                break;
              case 1:
                context.go('/employees');
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Employees'),
          ],
        ),
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/employees')) {
      return 1;
    }
    return 0;
  }
}
