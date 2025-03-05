
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class RecordsRepositoryImp implements RecordsRepository{

        final RecordsRemoteDataSource remoteDataSource;
        RecordsRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    