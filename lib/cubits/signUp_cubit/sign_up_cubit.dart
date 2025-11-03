import 'package:bloc/bloc.dart';
import 'package:go_jo_user_application/domain/models/user_model.dart';
import 'package:meta/meta.dart';
import '../../domain/repos/auth_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.authRepo}) : super(SignUpInitial());

  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword({required String email, required String password,required String name}) async {
    emit(SignUpLoading());
    final result = await authRepo.createUserWithEmailAndPassword(email: email, password: password,name: name);
    result.fold((failure) => emit(SignUpFailure(failure.message)),
            (user) => emit(SignUpSuccess(user)));

  }



}
