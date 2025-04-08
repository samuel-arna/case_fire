import 'package:case_fire/modules/auth/data/datasource/auth_firebase_datasource.dart';
import 'package:case_fire/modules/auth/domain/repositories/auth_repository.dart';
import 'package:case_fire/modules/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:case_fire/modules/auth/domain/usecases/login_usecase.dart';
import 'package:case_fire/modules/auth/domain/usecases/logout_usecase.dart';
import 'package:case_fire/modules/auth/ui/stores/bloc/auth_bloc.dart';
import 'package:case_fire/modules/post/data/datasources/post_placeholder_datasource.dart';
import 'package:case_fire/modules/post/domain/repositories/post_repository.dart';
import 'package:case_fire/modules/post/domain/usecases/get_posts_usecase.dart';
import 'package:case_fire/modules/post/ui/stores/bloc/post_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

Future<void> configureDependencies() async {
  // Firebase
  await Firebase.initializeApp();
  di.registerLazySingleton(() => FirebaseAuth.instance);

  // Auth
  di.registerLazySingleton(() => AuthFirebaseDatasource(firebaseAuth: di()));
  di.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(datasource: di()),
  );
  di.registerLazySingleton(() => LoginUseCase(di()));
  di.registerLazySingleton(() => LogoutUseCase(di()));
  di.registerLazySingleton(() => GetCurrentUserUseCase(di()));
  di.registerFactory(
    () => AuthBloc(
      loginUseCase: di(),
      logoutUseCase: di(),
      getCurrentUserUseCase: di(),
    ),
  );

  // Post
  di.registerLazySingleton(() => PostPlaceholderDatasource());
  di.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(di()));
  di.registerLazySingleton(() => GetPostsUseCase(di()));
  di.registerFactory(() => PostBloc(getPostsUseCase: di()));
}
