
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class EmployeesRepositoryImp implements EmployeesRepository{

        final EmployeesRemoteDataSource remoteDataSource;
        EmployeesRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    