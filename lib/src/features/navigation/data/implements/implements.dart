
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class NavigationRepositoryImp implements NavigationRepository{

        final NavigationRemoteDataSource remoteDataSource;
        NavigationRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    