import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repos/ticket_repo.dart';
import '../../../services/storage_service.dart';
import '../../../services/supabase_storage.dart';

part 'create_ticket_state.dart';

class CreateTicketCubit extends Cubit<CreateTicketState> {
  CreateTicketCubit({
    required this.ticketRepo,
    required this.storageService,
  }) : super(CreateTicketInitial());

  final TicketRepo ticketRepo;
  final StorageService storageService;

  Future<void> createTicket({
    required Map<String, dynamic> data,
    File? image,
    required String username,
  }) async {
    emit(CreateTicketLoading());

    try {
      String? imageUrl;

      if (image != null) {
        imageUrl = await storageService.uploadImage(
          file: image,
          bucket: Buckets.ticketPhotos,
          folder: "ticket_$username",
        );
      }

      final Map<String, dynamic> body = {
        ...data,
        "imageLink": imageUrl,
      };

      await ticketRepo.createTicket(data: body);

      emit(CreateTicketSuccess());
    } catch (e) {
      emit(CreateTicketFailure(message: e.toString()));
    }
  }
}
