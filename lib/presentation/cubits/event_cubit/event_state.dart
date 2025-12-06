part of 'event_cubit.dart';

@immutable
sealed class EventState {}

final class EventInitial extends EventState {}
final class EventLoading extends EventState {}
final class EventSuccess extends EventState {
  final List<EventModel> events;

  EventSuccess({required this.events});
}
final class EventError extends EventState {
  final String message;

  EventError({required this.message});
}
