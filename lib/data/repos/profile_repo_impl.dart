import '../../domain/repos/profile_repo.dart';
import '../../services/remote_data_source.dart';

class ProfileRepoImpl extends ProfileRepo {

  final RemoteDataSource remoteDataSource;

  ProfileRepoImpl({required this.remoteDataSource});

  @override
  Future<Map<String, dynamic>> updateProfile({required Map<String, dynamic> data}) async{

    final response= await remoteDataSource.sendRequest(
        endpoint: '/profile/user',
        method:'PATCH',
        data:data
    );
    return response;
  }
}