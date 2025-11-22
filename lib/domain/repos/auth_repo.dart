import 'package:dartz/dartz.dart';

import '../../data/models/user_model.dart';
import '../errors/failures.dart';


abstract class AuthRepo {

  Future<Either<Failure,UserModel>> createUserWithEmailAndPassword({required String email, required String password,required String name});

  Future<Either<Failure,UserModel>> signInWithEmailAndPassword({required String email, required String password});

  Future<Either<Failure,UserModel>> signInWithGoogle();

  Future<Either<Failure,UserModel>> signInWithFacebook();

  Future addUserDataToDatabase({required UserModel user});

  Future<UserModel> getUserDataFromDatabase({required String id});

  Future saveUserData({required UserModel user});



}