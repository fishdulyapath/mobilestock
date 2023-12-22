import 'package:get_storage/get_storage.dart';

late GetStorage appStorage;
String serverHost = "";
String serverProvider = "";
String serverDatabase = "";
String userCode = "";
String userName = "";
String branchCode = "";
String branchName = "";

Future<void> initializeConfig() async {
  await GetStorage.init("SMLConfig");
  appStorage = GetStorage("SMLConfig");
  loadConfig();
}

Future<void> loadConfig() async {
  serverHost = appStorage.read("host") ?? "";
  serverProvider = appStorage.read("provider") ?? "";
  serverDatabase = appStorage.read("dbname") ?? "";
  userCode = appStorage.read("usercode") ?? "";
  userName = appStorage.read("username") ?? "";
  branchCode = appStorage.read("branchcode") ?? "";
  branchName = appStorage.read("branchname") ?? "";
}
