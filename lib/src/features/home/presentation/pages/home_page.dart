import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 16),
        children: [
          Table(
            columnWidths: {
              0: FixedColumnWidth(150),
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
                  ),
                  Text(
                    'Check-In',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    'Check-Out',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    'Overtime',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              TableRow(
                children: [
                  SizedBox(height: 10),
                  SizedBox.shrink(),
                  SizedBox.shrink(),
                  SizedBox.shrink(),
                ],
              ),
              TableRow(
                children: [
                  Text('Aman'),
                  Text('9:00 AM'),
                  Text('10:00 PM'),
                  Text('4 hrs'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
