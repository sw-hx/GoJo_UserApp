import 'package:go_jo_user_application/services/remote_data_source.dart';

import '../../domain/repos/notification_repo.dart';
import '../models/notification_model.dart';


class NotificationRepoImpl implements NotificationRepo {
  final RemoteDataSource remoteDataSource;
  NotificationRepoImpl({required this.remoteDataSource});

  @override
  Future<List<dynamic>> getNotification() async {

    final response = await remoteDataSource.sendRequest(
        endpoint:'/notification' ,
        method: 'GET'
    );
    return response.map((e) => NotificationModel.fromJson(e)).toList();

  }

  @override
  Future<void> deleteNotification({required int notificationId}) {
    print(notificationId);
    final response = remoteDataSource.sendRequest(
        endpoint:'/notification/$notificationId' ,
        method: 'DELETE'
    );
    return response;
  }
}