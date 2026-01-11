import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_jo_user_application/services/storage_service.dart';
import 'package:go_jo_user_application/services/stripe_service.dart';
import 'package:go_jo_user_application/services/supabase_storage.dart';

import '../data/repos/auth_repo_impl.dart';
import '../data/repos/checkout_repo_impl.dart';
import '../data/repos/event_repo_impl.dart';
import '../data/repos/favorite_repo_impl.dart';
import '../data/repos/notification_repo_impl.dart';
import '../data/repos/place_repo_impl.dart';
import '../data/repos/profile_repo_impl.dart';
import '../data/repos/search_repo_impl.dart';
import '../data/repos/ticket_repo_impl.dart';
import '../data/repos/trip_repo_impl.dart';
import '../domain/repos/auth_repo.dart';
import '../domain/repos/checkout_repo.dart';
import '../domain/repos/event_repo.dart';
import '../domain/repos/favorite_repo.dart';
import '../domain/repos/notification_repo.dart';
import '../domain/repos/place_repo.dart';
import '../domain/repos/profile_repo.dart';
import '../domain/repos/search_repo.dart';
import '../domain/repos/ticket_repo.dart';
import '../domain/repos/trip_repo.dart';
import 'remote_data_source.dart';
import 'dio_service.dart';
import 'firebase_auth_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  getIt.registerLazySingleton<StorageService>(() => SupabaseStorage());

  // Remote Data Source
  getIt.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSource(getIt<DioClient>().dio),
  );

  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());

  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => FlutterSecureStorage(),
  );
  getIt.registerLazySingleton<StripeService>(() => StripeService());

  // Auth Repository
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      remoteDataSource: getIt.get<RemoteDataSource>(),
      firebaseAuthService: getIt.get<FirebaseAuthService>(),
    ),
  );

  getIt.registerLazySingleton<PlaceRepo>(
    () => PlaceRepoImpl(remoteDataSource: getIt.get<RemoteDataSource>()),
  );
  getIt.registerLazySingleton<TripRepo>(
    () => TripRepoImpl(remoteDataSource: getIt.get<RemoteDataSource>()),
  );
  getIt.registerLazySingleton<SearchRepo>(
    () => SearchRepoImpl(remoteDataSource: getIt.get<RemoteDataSource>()),
  );
  getIt.registerLazySingleton<NotificationRepo>(
    () => NotificationRepoImpl(remoteDataSource: getIt.get<RemoteDataSource>()),
  );
  getIt.registerLazySingleton<EventRepo>(
    () => EventRepoImpl(remoteDataSource: getIt.get<RemoteDataSource>()),
  );

  getIt.registerLazySingleton<FavoriteRepo>(
    () => FavoriteRepoImpl(remoteDataSource: getIt.get<RemoteDataSource>()),
  );

  getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(remoteDataSource: getIt.get<RemoteDataSource>()),
  );

  getIt.registerLazySingleton<TicketRepo>(
    () => TicketRepoImpl(remoteDataSource: getIt.get<RemoteDataSource>()),
  );

  getIt.registerLazySingleton<CheckoutRepo>(
    () => CheckoutRepoImpl(stripeService: getIt.get<StripeService>()),
  );
}
