import 'package:diploma/blocs/authentication/authentication_bloc.dart';
import 'package:diploma/blocs/categories/categories_bloc.dart';
import 'package:diploma/blocs/profile/profile_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:module_business/module_business.dart';
import 'package:module_data/module_data.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  // BLoC
  sl.registerFactory(() => CategoriesBloc(
        getCategories: sl(),
        addCategory: sl(),
        addSpending: sl(),
        removeSpending: sl(),
        removeCategory: sl(),
      ));
  sl.registerFactory(() => AuthenticationBloc(
        userSignIn: sl(),
        userSignUp: sl(),
        userSignOut: sl(),
        userUid: sl(),
        userEmail: sl(),
      ));
  sl.registerFactory(() => ProfileBloc(
        uploadProfilePicture: sl(),
        downloadProfilePicture: sl(),
        deleteProfilePicture: sl(),
      ));

  // UseCases
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => AddCategory(sl()));
  sl.registerLazySingleton(() => RemoveCategory(sl()));
  sl.registerLazySingleton(() => AddSpending(sl()));
  sl.registerLazySingleton(() => RemoveSpending(sl()));
  sl.registerLazySingleton(() => UserUid(sl()));
  sl.registerLazySingleton(() => UserEmail(sl()));
  sl.registerLazySingleton(() => UserSignIn(sl()));
  sl.registerLazySingleton(() => UserSignUp(sl()));
  sl.registerLazySingleton(() => UserSignOut(sl()));
  sl.registerLazySingleton(() => UploadProfilePicture(sl()));
  sl.registerLazySingleton(() => DownloadProfilePicture(sl()));
  sl.registerLazySingleton(() => DeleteProfilePicture(sl()));

  // Repositories
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImp(),
  );
  sl.registerLazySingleton<SpendingsRepository>(
    () => SpendingsRepositoryImp(),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImp(),
  );
}
