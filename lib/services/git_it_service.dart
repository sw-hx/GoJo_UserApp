import 'package:get_it/get_it.dart';

import '../data/repos/auth_repo_impl.dart';
import '../domain/repos/auth_repo.dart';
import 'database_service.dart';
import 'firebase_auth_service.dart';
import 'firestore_service.dart';

  final getIt = GetIt.instance;

  void setup() {
    getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
    getIt.registerSingleton<DatabaseService>(FirestoreService());
    getIt.registerSingleton<AuthRepo>(AuthRepoImpl(
      firebaseAuthService: getIt.get<FirebaseAuthService>(),
      databaseService: getIt.get<DatabaseService>(),

    ));


  }
