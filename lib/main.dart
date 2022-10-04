import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/resources/routes_manager.dart';
import 'core/resources/theme_manager.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/register/presentation/bloc/register_bloc.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<LoginBloc>()),
        BlocProvider(create: (_) => sl<RegisterBloc>()),
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
