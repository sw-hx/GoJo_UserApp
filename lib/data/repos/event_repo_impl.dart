import '../../domain/repos/event_repo.dart';
import '../../services/remote_data_source.dart';
import '../models/event_model.dart';

class EventRepoImpl implements EventRepo {
  final RemoteDataSource remoteDataSource;

  EventRepoImpl({required this.remoteDataSource});

  @override
  Future<List<EventModel>> getEvents() async {
    try {
      final response = await remoteDataSource.sendRequest(
        endpoint: '/event',
        method: 'GET',
      );
      return (response as List).map((e) => EventModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
