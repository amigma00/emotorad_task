part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeDataState extends HomeState {
  final bool isLoading;
  final List<String> dropDowns;
  final List<EmployeeEntry> data;
  final String? error;

  HomeDataState({
    this.isLoading = false,
    this.dropDowns = const [],
    this.data = const [],
    this.error,
  });

  HomeDataState copyWith({
    bool? isLoading,
    List<String>? dropDowns,
    List<EmployeeEntry>? data,
    String? error,
  }) {
    return HomeDataState(
      isLoading: isLoading ?? this.isLoading,
      dropDowns: dropDowns ?? this.dropDowns,
      data: data ?? this.data,
      error: error,
    );
  }
}

// class HomeErrorState extends HomeState {
//   final String error;
//   HomeErrorState({required this.error});
// }
