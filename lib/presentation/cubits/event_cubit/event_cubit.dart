import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/event_model.dart';
import '../../../domain/repos/event_repo.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit({required this.eventRepo}) : super(EventInitial());
  EventRepo eventRepo;

  Future<void> getEvents() async {
    emit(EventLoading());
    try {
      final events = await eventRepo.getEvents();
      emit(EventSuccess(events: events));
    } catch (e) {
      emit(EventError(message: e.toString()));
    }
  }
}
