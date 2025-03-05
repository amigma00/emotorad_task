
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:meta/meta.dart';

  part 'navigation_state.dart';
  
  class NavigationCubit extends Cubit<NavigationState> {
    NavigationCubit() : super(NavigationInitial());
  }
  