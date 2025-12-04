import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../core/constants.dart';
import '../data/repos/auth_repo_impl.dart';
import '../data/repos/place_repo_impl.dart';
import '../data/repos/trip_repo_impl.dart';
import '../domain/repos/auth_repo.dart';
import '../domain/repos/place_repo.dart';
import '../domain/repos/trip_repo.dart';
import 'auth_remote_data_source.dart';
import 'database_service.dart';
import 'dio_service.dart';
import 'firebase_auth_service.dart';
import 'firestore_service.dart';

final getIt = GetIt.instance;

void setup() {

  getIt.registerLazySingleton<DioClient>(() => DioClient());

  // Remote Data Source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
          () => AuthRemoteDataSource(getIt<DioClient>().dio));


  getIt.registerLazySingleton<FirebaseAuthService>(
        () => FirebaseAuthService(),
  );

  getIt.registerLazySingleton<FlutterSecureStorage>(
        () => FlutterSecureStorage(),
  );




  // Auth Repository
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      authRemoteDataSource: getIt.get<AuthRemoteDataSource>(),
      firebaseAuthService: getIt.get<FirebaseAuthService>(),
    ),
  );

  getIt.registerLazySingleton<PlaceRepo>(
    () => PlaceRepoImpl(
      authRemoteDataSource: getIt.get<AuthRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<TripRepo>(
    () => TripRepoImpl(
      authRemoteDataSource: getIt.get<AuthRemoteDataSource>(),
    ),
  );
}
