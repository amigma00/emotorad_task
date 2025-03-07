import 'package:emotorad_task/src/core/extensions/padding_extension.dart';
import 'package:emotorad_task/src/core/services/service_locator.dart';
import 'package:emotorad_task/src/core/utils/date_time_util.dart';
import 'package:emotorad_task/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:emotorad_task/src/models/employee_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final cubit = sl<HomeCubit>();
  @override
  Widget build(BuildContext context) {
    cubit.fetchGsheets();
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Align(
              alignment: Alignment.centerLeft,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: SizedBox(
                    width: 200,
                    child: DropdownButton(
                        isExpanded: true,
                        underline: SizedBox.shrink(),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        borderRadius: BorderRadius.circular(100),
                        value: 'aman',
                        items: [
                          DropdownMenuItem(
                            child: Text('Aman'),
                            value: 'aman',
                          )
                        ],
                        onChanged: (x) {}),
                  )).paddingSymmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            } else if (state is HomeLoaded) {
              return ListView(
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Check-In',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Check-Out',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Overtime',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
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
                      ...entries(cubit, context, state),
                    ],
                  )
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  List<TableRow> entries(
      HomeCubit cubit, BuildContext context, HomeLoaded state) {
    var list = state.data;
    return List.generate(
      list.length,
      (index) {
        return TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text(
                list[index].employeeName.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            checkInOutField(true, list[index], index, context).paddingAll(4),
            checkInOutField(false, list[index], index, context).paddingAll(4),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text(
                '${DateTimeUtil.calculateOvertime(list[index].checkOut).toStringAsFixed(2)} hrs',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }

  TextField checkInOutField(
      bool isChekIn, EmployeeEntry emp, int index, BuildContext context) {
    return TextField(
      controller: TextEditingController(
          text: DateTimeUtil.getTime(isChekIn ? emp.checkIn : emp.checkOut)),
      readOnly: true,
      onTap: () => cubit.onCheckInOutTap(context,
          empentry: emp,
          isChekIn: isChekIn,
          row: index,

          //TODO: chaneg worksheet name
          worksheet: DateTime.now().toString().split(' ')[0]),
      style: TextStyle(fontSize: 14),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          isDense: true,
          fillColor: Colors.red,
          border: OutlineInputBorder()),
    );
  }



}
