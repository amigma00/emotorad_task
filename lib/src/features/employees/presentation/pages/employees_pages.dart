import 'package:emotorad_task/src/core/extensions/padding_extension.dart';
import 'package:emotorad_task/src/features/employees/presentation/cubit/employees_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesPage extends StatelessWidget {
  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmployeesCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Employees Page'),
      ),
      body: BlocBuilder<EmployeesCubit, EmployeesState>(
        builder: (context, state) {
          final homeState = state as EmployeesDataState;
          if (homeState.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (homeState.error != null) {
            return Center(child: Text(state.error ?? ''));
          } else if (homeState.employees.isNotEmpty) {
            return Column(
              children: [
                ColoredBox(
                  color: Colors.blueGrey,
                  child: Form(
                    key: cubit.key,
                    child: TextFormField(
                      validator: (value) {
                        // Regular expression to match only alphabets (letters)
                        final RegExp regex = RegExp(r'^[a-z A-Z]+$');
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text'; // Handle empty input
                        } else if (!regex.hasMatch(value)) {
                          return 'Only alphabets are allowed'; // Handle invalid input
                        }
                        return null; // Return null if the input is valid
                      },
                      controller: cubit.nameController,
                      decoration: InputDecoration(
                        suffixIcon: TextButton(
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.zero),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.blue),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                          onPressed: () {
                            if (cubit.key.currentState!.validate()) {
                              cubit.addEmployee(cubit.nameController.text);
                            }
                            //  else {
                            //   ScaffoldMessenger.of(context)
                            //       .showSnackBar(SnackBar(
                            //     content: Text('Name cannot be empty'),
                            //   ));
                            // }
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ).paddingOnly(right: 16),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: '+ Add Employee',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8.0), // Rounded corners
                          borderSide:
                              BorderSide(color: Colors.grey), // Border color
                        ),
                      ),
                    ).paddingAll(10),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: homeState.employees.length,
                    itemBuilder: (context, index) => ListTile(
                      trailing: TextButton(
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero),
                          backgroundColor: WidgetStatePropertyAll(Colors.red),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                        ),
                        onPressed: () => cubit.removeEmployee(rowIndex: index),
                        child: Text(
                          'Remove',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      tileColor: Colors.blue
                          .withValues(alpha: index % 2 == 0 ? 0.2 : 0.1),
                      title: Text(homeState.employees[index].name),
                    ),
                  ),
                ),
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
}
