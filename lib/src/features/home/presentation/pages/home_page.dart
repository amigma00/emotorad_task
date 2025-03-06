import 'package:emotorad_task/src/core/extensions/padding_extension.dart';
import 'package:emotorad_task/src/core/services/service_locator.dart';
import 'package:emotorad_task/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // sl<HomeCubit>().fetchGsheets();
    sl<HomeCubit>().updateGsheet();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 8),
        children: [
          Table(
            border: TableBorder.all(),
            columnWidths: {
              0: FixedColumnWidth(140),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
            },
            children: [
              TableRow(
                children: [
                  Text(
                    'Employee Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Check-In',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Check-Out',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Overtime',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              // TableRow(
              //   children: [
              //     SizedBox(height: 10),
              //     SizedBox.shrink(),
              //     SizedBox.shrink(),
              //     SizedBox.shrink(),
              //   ],
              // ),
              TableRow(
                children: [
                  Text(
                    'Aman',
                    textAlign: TextAlign.center,
                  ),
                  TextField(
                    controller: TextEditingController(text: '09:00 AM'),
                    readOnly: true,
                    onTap: () => showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ),
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        fillColor: Colors.red,
                        border: OutlineInputBorder()),
                  ).paddingAll(4),
                  Text(
                    '10:00 PM',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '4 hrs',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
