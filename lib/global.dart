import 'package:get_storage/get_storage.dart';

late GetStorage appStorage;
String serverHost = "";
String serverProvider = "";
String serverDatabase = "";
String userCode = "";
String userName = "";

Future<void> initializeConfig() async {
  await GetStorage.init("SMLConfig");
  appStorage = GetStorage("SMLConfig");
  loadConfig();
}

Future<void> loadConfig() async {
  serverHost = appStorage.read("host") ?? "";
  serverProvider = appStorage.read("provider") ?? "";
  serverDatabase = appStorage.read("database") ?? "";
  userCode = appStorage.read("usercode") ?? "";
  userName = appStorage.read("username") ?? "";
}
