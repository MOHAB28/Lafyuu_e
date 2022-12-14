import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/dio_helper.dart';
import 'core/network/network_info.dart';
import 'features/cart/data/datasources/cart_remote_data_sources.dart';
import 'features/cart/data/repositories/cart_repo_impl.dart';
import 'features/cart/domain/repositories/carts_repo.dart';
import 'features/cart/domain/usecases/add_or_remove_cart.dart';
import 'features/cart/domain/usecases/get_carts_usecase.dart';
import 'features/cart/domain/usecases/updata_cart_usecase.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/favourite/data/datasources/favourite_remote_data_sources.dart';
import 'features/favourite/data/repositories/fav_repo_impl.dart';
import 'features/favourite/domain/repositories/fav_repo.dart';
import 'features/favourite/domain/usecases/add_or_remove_fav_usecase.dart';
import 'features/favourite/domain/usecases/get_favs_usecase.dart';
import 'features/favourite/presentation/bloc/favourite_bloc.dart';
import 'features/home/data/datasources/home_remote_data_sources.dart';
import 'features/home/data/repositories/home_repo_impl.dart';
import 'features/home/domain/repositories/home_repo.dart';
import 'features/home/domain/usecases/home_usecase.dart';
import 'features/home/presentation/bloc/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/login/data/datasources/login_remote_data_sources.dart';
import 'features/login/data/repositories/login_repo_impl.dart';
import 'features/login/domain/repositories/login_repo.dart';
import 'features/login/domain/usecases/login_usecase.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/product_details/data/datasources/product_details_remote_data_sources.dart';
import 'features/product_details/data/repositories/products_details_repo_impl.dart';
import 'features/product_details/domain/repositories/product_details_repo.dart';
import 'features/product_details/domain/usecases/get_product_details_usecase.dart';
import 'features/product_details/presentation/bloc/product_details_bloc.dart';
import 'features/profile/data/datasources/profile_remote_data_sources.dart';
import 'features/profile/data/repositories/profile_repo_impl.dart';
import 'features/profile/domain/repositories/profile_repo.dart';
import 'features/profile/domain/usecases/get_profile_usecase.dart';
import 'features/profile/domain/usecases/updata_profile_usecase.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/register/data/datasources/register_remote_data_sources.dart';
import 'features/register/data/repositories/register_repo_impl.dart';
import 'features/register/domain/repositories/register_repo.dart';
import 'features/register/domain/usecases/register_usecase.dart';
import 'features/register/presentation/bloc/register_bloc.dart';
import 'features/search/data/datasources/search_remote_data_sources.dart';
import 'features/search/data/repositories/search_repo_impl.dart';
import 'features/search/domain/repositories/search_repo.dart';
import 'features/search/domain/usecases/search_usecase.dart';
import 'features/search/presentation/bloc/search_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initAppModule() async {
  //! Features
  sl.registerFactory(
    () => LoginBloc(sl()),
  );
  sl.registerFactory(
    () => ProductDetailsBloc(sl()),
  );
  sl.registerFactory(
    () => RegisterBloc(sl()),
  );
  sl.registerFactory(
    () => FavouriteBloc(sl(), sl()),
  );
  sl.registerFactory(
    () => HomeBloc(sl()),
  );
  sl.registerFactory(
    () => SearchBloc(sl()),
  );
  sl.registerFactory(
    () => ProfileBloc(sl(), sl()),
  );
  sl.registerFactory(
    () => CartBloc(sl(), sl(), sl()),
  );
  sl.registerFactory(
    () => BottomNavCubit(),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => GetProductDetailsUsecase(sl()));
  sl.registerLazySingleton(() => RegisterUsecase(sl()));
  sl.registerLazySingleton(() => HomeDataUsecase(sl()));
  sl.registerLazySingleton(() => GetProfileDataUsecase(sl()));
  sl.registerLazySingleton(() => UpdataProfileUsecase(sl()));
  sl.registerLazySingleton(() => GetAllFavouritesUsecase(sl()));
  sl.registerLazySingleton(() => AddOrRemoveFavUsecsae(sl()));
  sl.registerLazySingleton(() => AddOrRemoveCartUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCartUsecase(sl()));
  sl.registerLazySingleton(() => GetCartsUsecase(sl()));
  sl.registerLazySingleton(() => SearchUsecase(sl()));

  // Repository
  sl.registerLazySingleton<LoginRepo>(
    () => LoginRepoImpl(sl(), sl()),
  );
  sl.registerLazySingleton<RegisterRepo>(
    () => RegisterRepoImpl(sl(), sl()),
  );
  sl.registerLazySingleton<ProductDetailsRepo>(
    () => ProductDetailsRepoImpl(sl(), sl()),
  );
  sl.registerLazySingleton<HomeDataRepo>(
    () => HomeDataRepoImpl(sl(), sl()),
  );
  sl.registerLazySingleton<FavouritreRepo>(
    () => FavouriteRepoImpl(sl(), sl()),
  );
  sl.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(sl(), sl()),
  );
  sl.registerLazySingleton<CartsRepo>(
    () => CartsRepoImpl(sl(), sl()),
  );
  sl.registerLazySingleton<SearchRepo>(
    () => SearchRepoImpl(sl(), sl()),
  );

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSources>(
    () => LoginRemoteDataSourcesImpl(sl()),
  );
  sl.registerLazySingleton<RegisterRemoteDataSources>(
    () => RegisterRemoteDataSourcesImpl(sl()),
  );
  sl.registerLazySingleton<HomeRemoteDataSources>(
    () => HomeRemoteDataSourcesImpl(sl()),
  );
  sl.registerLazySingleton<ProductDetailsRemoteDataSources>(
    () => ProductDetailsRemoteDataSourcesImpl(sl()),
  );
  sl.registerLazySingleton<ProfileRemoteDataSources>(
    () => ProfileRemoteDataSourcesImpl(sl()),
  );
  sl.registerLazySingleton<FavouriteRemoteDataSources>(
    () => FavouriteRemoteDataSourcesImpl(sl()),
  );
  sl.registerLazySingleton<CartRemoteDataSources>(
    () => CartRemoteDataSourcesImpl(sl()),
  );
  sl.registerLazySingleton<SearchRemoteDataSources>(
    () => SearchRemoteDataSourcesImpl(sl()),
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
