import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobilestock/repository/authentication_repository.dart';
import 'package:mobilestock/repository/webservice_repository.dart';

final serviceLocator = GetIt.instance;

Future<void> setUpServiceLocator() async {
  serviceLocator.registerSingleton<AuthRepository>(AuthRepository());
  serviceLocator.registerSingleton<WebServiceRepository>(WebServiceRepository());
}
