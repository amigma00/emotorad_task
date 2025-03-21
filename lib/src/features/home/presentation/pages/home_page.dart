import 'package:emotorad_task/src/core/extensions/padding_extension.dart';

import 'package:emotorad_task/src/core/utils/date_time_util.dart';
import 'package:emotorad_task/src/features/home/domain/entities/employee_entry.dart';
import 'package:emotorad_task/src/features/home/presentation/cubit/home_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Scaffold(
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
                  child: BlocSelector<HomeCubit, HomeState, List<String>>(
                    selector: (state) {
                      if (state is HomeDataState) {
                        return state.dropDowns;
                      } else {
                        return [];
                      }
                    },
                    builder: (context, state) => state.isEmpty
                        ? SizedBox.shrink()
                        : StatefulBuilder(builder: (context, setState) {
                            return DropdownButton(
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                borderRadius: BorderRadius.circular(20),
                                value: cubit.dropValue,
                                items: List.generate(state.length, (index) {
                                  return DropdownMenuItem(
                                    value: state[index],
                                    child: Text(state[index]),
                                  );
                                }),
                                onChanged: (x) async {
                                  cubit.dropValue = x ?? '';

                                  await cubit.fetchGsheets(date: x);
                                  setState(() {});
                                });
                          }),
                  ),
                )).paddingSymmetric(horizontal: 16, vertical: 8),
          ),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final homeState = state as HomeDataState;

          if (homeState.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (homeState.error != null) {
            return RefreshIndicator(
              onRefresh: () => cubit.loadData(),
              child:
                  ListView(children: [Center(child: Text(state.error ?? ''))]),
            );
          } else if (homeState.data.isNotEmpty) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 8),
              children: [
                Table(
                  border: TableBorder.all(),
                  columnWidths: {
                    0: FixedColumnWidth(120),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(),
                    4: FlexColumnWidth(),
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
                        Text(
                          'Attend.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    ...entries(cubit, context, homeState.data),
                  ],
                )
              ],
            );
          } else {
            return Center(
              child: Text('No data'),
            );
          }
        },
      ),
    );
  }

  List<TableRow> entries(
      HomeCubit cubit, BuildContext context, List<EmployeeEntry> state) {
    var list = state;
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
                DateTimeUtil.calculateOvertime(
                    list[index].checkIn, list[index].checkOut),
                textAlign: TextAlign.center,
              ),
            ),
            TableCell(
                child: Checkbox(
              value: list[index].isPresent,
              onChanged: (value) => cubit.onCheckBoxTap(context,
                  row: index, empentry: list[index], value: value ?? false),
            ))
          ],
        );
      },
    );
  }

  Widget checkInOutField(
      bool isChekIn, EmployeeEntry emp, int index, BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.zero),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              side: BorderSide(width: 1),
              borderRadius: BorderRadius.circular(4)))),
      child: Text(
        DateTimeUtil.getTime(isChekIn ? emp.checkIn : emp.checkOut),
        style: TextStyle(fontSize: 14),
      ),
      onPressed: () => context.read<HomeCubit>().onCheckInOutTap(context,
          empentry: emp, isChekIn: isChekIn, row: index),
    );
  }
}
