// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<EmployeeEntry> data;

  HomeLoaded({required this.data});
}

class LoadDropDown extends HomeState {
  final List<String> dropDowns;
  LoadDropDown({
    required this.dropDowns,
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
