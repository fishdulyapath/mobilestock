import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mobilestock/core/client.dart';
import 'package:mobilestock/model/user_login_model.dart';
import 'package:mobilestock/global.dart' as global;

class AuthRepository {
  Future<ApiResponse> authenUser(String username, String password, String provider, String dbname) async {
    try {
      global.loadConfig();
      Dio client = Client().init();
      UserLoginModel user = UserLoginModel(
        databasename: dbname,
        provider: provider,
        usercode: username,
        userpassword: password,
      );
      final response = await client.post('/webresources/rest/ulogin/', data: user.toJson());
      final rawData = json.decode(response.toString());
      if (rawData['error'] != null) {
        throw Exception('${rawData['code']}: ${rawData['message']}');
      }
      if (response.statusCode == 200) {
        return ApiResponse.fromMap({
          'success': true,
          'data': rawData['user_name'],
        });
      } else {
        throw Exception('${response.statusCode}: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.message.toString());
      } else {
        throw Exception(e.error);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
