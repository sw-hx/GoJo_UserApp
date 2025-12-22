import 'package:go_jo_user_application/services/remote_data_source.dart';

import '../../domain/repos/ticket_repo.dart';

class TicketRepoImpl extends TicketRepo{

  final RemoteDataSource remoteDataSource;

  TicketRepoImpl({required this.remoteDataSource});

  @override
  Future<void> createTicket({required Map<String, dynamic> data})async {
    final result = await remoteDataSource.sendRequest(
        endpoint:'/ticket',
        method:'POST',
        data: data
    );


  }

}