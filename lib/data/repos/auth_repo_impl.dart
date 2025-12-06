import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_jo_user_application/core/constants.dart';

import '../../domain/errors/failures.dart';
import '../../domain/repos/auth_repo.dart';
import '../../services/remote_data_source.dart';
import '../../services/database_service.dart';
import '../../services/firebase_auth_service.dart';
import '../../services/secure_storage_service.dart';
import '../../services/shared_preferences.dart';
import '../models/user_model.dart';

class AuthRepoImpl implements AuthRepo {

  final RemoteDataSource remoteDataSource;
  final FirebaseAuthService firebaseAuthService;


  AuthRepoImpl(
      {required this.remoteDataSource, required this.firebaseAuthService});

  @override
  Future<Either<Failure, UserModel>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String username,
  }) async {
    try {
      var user = await remoteDataSource.sendRequest(
          endpoint: '/auth/register/user',
          method: 'POST',
          data: {
            'email': email,
            'password': password,
            'personFullName': name,
            'username': username
          });
      UserModel userModel = UserModel.fromMap(user);

      return Right(userModel);
    } catch (e) {
      log('error in create user with email and password (auth_repo_impl) ${e
          .toString()}');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var user = await remoteDataSource.sendRequest(
          endpoint: '/auth/login/user',
          method: 'POST',
          data: {'email': email, 'password': password});
      print('hi before');
      UserModel userModel = UserModel(id: user['normalUserId'].toString(),
          personFullName: user['personFullName'],
          email: email,
          username: user['username'],
          profilePhoto: user['profilePhoto'],
          password: password);
      await saveUserData(user: userModel);
      await saveUserToken(response: user);
      final token = await getSavedToken();
      if (token != null) {
        print("Token exists: $token");
      } else {
        print("No token saved");
      }

      return Right(userModel);
    } on Exception catch (e) {
      log('error in sign in with email and password (auth_repo_impl) ${e
          .toString()}');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future saveUserData({required UserModel user}) async {
    var jsonData = jsonEncode(user.toMap());
    await SharedPreferencesService.setString(userDataKey, jsonData);
  }

}
/*
  @override
  Future<Either<Failure, UserModel>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();
      UserModel userModel=UserModel(id: user.uid, name: user.displayName ?? 'User', email: user.email ?? 'User', personFullName: '', username: '', profilePhoto: '', password: '');
      var isUserExists= await databaseService.checkDataExists(collectionName: 'users', documentId: user.uid);
      if(isUserExists) {
        await getUserDataFromDatabase(id: user.uid);
      }
      else{
        await addUserDataToDatabase(user: userModel);
      }
      await saveUserData(user: userModel);
      return Right(userModel);
    } catch (e) {
      deleteUser(user);
      log('error in sign in with google (auth_repo_impl) ${e.toString()}');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithFacebook() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithFacebook();
      UserModel userModel=UserModel(id: user!.uid , name: user.displayName ?? 'User', email: user.email ?? 'User');
      var isUserExists= await databaseService.checkDataExists(collectionName: 'users', documentId: user.uid);
      if(isUserExists) {
        await getUserDataFromDatabase(id: user.uid);
      }
      else{
        await addUserDataToDatabase(user: userModel);
      }

      await saveUserData(user: userModel);
      return Right(userModel);
    } catch (e, stack) {
      deleteUser(user);
      log('❌ error in signInWithFacebook (auth_repo_impl): $e\n$stack');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future addUserDataToDatabase({required UserModel user}) async {

    await databaseService.addDataToDatabase(collectionName: 'users', data: user.toMap(),documentId: user.id);

  }

  void deleteUser(user) async{
    if(user!=null){
      await firebaseAuthService.deleteUser();

    }


  }

  @override
  Future<UserModel> getUserDataFromDatabase({required String id}) async {

    Map<String,dynamic> data =await databaseService.getDataFromDatabase(collectionName: 'users', documentId: id);

    return UserModel.fromMap(data);

  }
*/