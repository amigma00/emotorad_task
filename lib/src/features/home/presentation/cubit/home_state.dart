part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<List<String>> data;

  HomeLoaded({required this.data});
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
