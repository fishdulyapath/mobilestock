import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilestock/bloc/authentication/authentication_bloc.dart';
import 'package:mobilestock/bloc/webservice/webservice_bloc.dart';
import 'package:mobilestock/core/service_locator.dart';
import 'package:mobilestock/features/cart/cart_form_screen.dart';
import 'package:mobilestock/features/cart/cart_list_screen.dart';
import 'package:mobilestock/features/config/config_screen.dart';
import 'package:mobilestock/features/doc/doc_list_screen.dart';
import 'package:mobilestock/features/login/login_screen.dart';
import 'package:mobilestock/features/menu/menu_screen.dart';
import 'package:mobilestock/global.dart';
import 'package:mobilestock/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpServiceLocator();
  await initializeConfig();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (context) => WebserviceBloc(),
        ),
      ],
      child: MaterialApp(
          title: 'SML AI Data',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
          routes: {
            '/login': (context) => const LoginScreen(),
            '/config': (context) => const ConfigScreen(),
            '/menu': (context) => const MenuScreen(),
            '/cartlist': (context) => const CartListScreen(),
            '/doclist': (context) => const DocListScreen(),
          }),
    );
  }
}
