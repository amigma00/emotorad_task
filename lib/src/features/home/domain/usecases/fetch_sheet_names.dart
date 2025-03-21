import 'package:emotorad_task/src/features/home/domain/repositories/home_repository.dart';

class FetchSheetNames {
  final HomeRepository _repository;

  FetchSheetNames(this._repository);

  Future<List<String>> call() async {
    return await _repository.fetchSheetNames();
  }
}
