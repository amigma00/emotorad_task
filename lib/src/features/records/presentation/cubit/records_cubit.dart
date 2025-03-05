
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:meta/meta.dart';

  part 'records_state.dart';
  
  class RecordsCubit extends Cubit<RecordsState> {
    RecordsCubit() : super(RecordsInitial());
  }
  