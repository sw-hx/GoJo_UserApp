import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/repos/profile_repo.dart';
import '../../../services/storage_service.dart';
import '../../../services/supabase_storage.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({
    required this.profileRepo,
    required this.storageService,
  }) : super(EditProfileInitial());

  final ProfileRepo profileRepo;
  final StorageService storageService;

  Future<void> editProfile({
    required String username,
    required String fullName,
    File? newImage,
  }) async {
    emit(EditProfileLoading());

    try {
      String? imageUrl;

      if (newImage != null) {
        imageUrl = await storageService.uploadImage(
          file: newImage,
          bucket: Buckets.userProfilePhotos,
          folder: "user_$username/profile",
        );
      }

      final Map<String, dynamic> body = {
        "personFullName": fullName,
        if (imageUrl != null) "profileImageLink": imageUrl,
      };

      final user= await profileRepo.updateProfile(data: body);

      emit(EditProfileSuccess(updatedUser: user));
      emit(EditProfileInitial());
    } catch (e) {
      emit(EditProfileFailure(message: e.toString()));
      emit(EditProfileInitial());
    }
  }
}
