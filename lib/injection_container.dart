import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/dio_helper.dart';
import 'core/network/network_info.dart';
import 'features/login/data/datasources/login_remote_data_sources.dart';
import 'features/login/data/repositories/login_repo_impl.dart';
import 'features/login/domain/repositories/login_repo.dart';
import 'features/login/domain/usecases/login_usecase.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/register/data/datasources/register_remote_data_sources.dart';
import 'features/register/data/repositories/register_repo_impl.dart';
import 'features/register/domain/repositories/register_repo.dart';
import 'features/register/domain/usecases/register_usecase.dart';
import 'features/register/presentation/bloc/register_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initAppModule() async {
  //! Features
  sl.registerFactory(
    () => LoginBloc(sl()),
  );
  sl.registerFactory(
    () => RegisterBloc(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => RegisterUsecase(sl()));

  // Repository
  sl.registerLazySingleton<LoginRepo>(
    () => LoginRepoImpl(sl(), sl()),
  );
  sl.registerLazySingleton<RegisterRepo>(
    () => RegisterRepoImpl(sl(), sl()),
  );

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSources>(
    () => LoginRemoteDataSourcesImpl(sl()),
  );
  sl.registerLazySingleton<RegisterRemoteDataSources>(
    () => RegisterRemoteDataSourcesImpl(sl()),
  );

  //! Core
  sl.registerLazySingleton<DioHelper>(
    () => DioHelperImpl(),
  );
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => Connectivity());
}
