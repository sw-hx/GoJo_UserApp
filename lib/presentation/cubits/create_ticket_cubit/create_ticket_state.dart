part of 'create_ticket_cubit.dart';

@immutable
sealed class CreateTicketState {}

final class CreateTicketInitial extends CreateTicketState {}

final class CreateTicketLoading extends CreateTicketState {}

final class CreateTicketSuccess extends CreateTicketState {}

final class CreateTicketFailure extends CreateTicketState {
  final String message;

  CreateTicketFailure({required this.message});
}
