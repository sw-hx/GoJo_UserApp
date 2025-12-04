import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/repos/auth_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.authRepo}) : super(SignUpInitial());

  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword({required String email, required String password,required String name,required String username,}) async {
    emit(SignUpLoading());
    final result = await authRepo.createUserWithEmailAndPassword(email: email, password: password,name: name,username: username);
    result.fold((failure) => emit(SignUpFailure(failure.message)),
            (user) => emit(SignUpSuccess(user)));

  }



}
