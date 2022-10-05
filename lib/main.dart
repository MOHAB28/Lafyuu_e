import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_observer.dart';
import 'core/resources/routes_manager.dart';
import 'core/resources/theme_manager.dart';
import 'features/home/presentation/bloc/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/register/presentation/bloc/register_bloc.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<LoginBloc>()),
        BlocProvider(create: (_) => sl<RegisterBloc>()),
        BlocProvider(create: (_) => sl<HomeBloc>()),
        BlocProvider(create: (_) => sl<BottomNavCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        routes: Routes.routes,
        initialRoute: Routes.splashPageKey,
      ),
    );
  }
}
