import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/user_model.dart';
import '../../../domain/repos/auth_repo.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({required this.authRepo}) : super(SignInInitial());

  final AuthRepo authRepo;

  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    emit(SignInLoading());
    final result = await authRepo.signInWithEmailAndPassword(email: email, password: password);
    result.fold((failure) => emit(SignInFailure(failure.message)),
            (user) => emit(SignInSuccess(user)));

  }

  Future<void> signInWithGoogle() async {
    emit(SignInLoading());
    final result = await authRepo.signInWithGoogle();
    result.fold((failure) => emit(SignInFailure(failure.message)),
            (user) => emit(SignInSuccess(user)));

  }

  Future<void> signInWithFacebook() async {
    emit(SignInLoading());
    final result = await authRepo.signInWithFacebook();
    result.fold((failure) => emit(SignInFailure(failure.message)),
            (user) => emit(SignInSuccess(user)));

  }



}
