import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';

import 'package:mobilestock/core/client.dart';
import 'package:mobilestock/model/post_select_model.dart';
import 'package:mobilestock/model/user_login_model.dart';
import 'package:mobilestock/global.dart' as global;
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';

class WebServiceRepository {
  Future<ApiResponse> querySelect(String query) async {
    Map<String, dynamic> requestData = {
      'provider': global.serverProvider.toUpperCase(),
      'database': global.serverDatabase.toLowerCase(),
      'query': query,
    };

    // Compress and encode your request data
    String jsonRequest = jsonEncode(requestData);
    List<int> compressedData = await compress(jsonRequest);
    String base64Request = base64Encode(compressedData);

    try {
      global.loadConfig();
      Dio client = Client().init();
      var response = await client.post(
        '/webresources/rest/select',
        data: base64Request,
        options: Options(
          headers: {
            Headers.contentTypeHeader: 'application/octet-stream',
          },
        ),
      );

      if (response.statusCode == 200) {
        Uint8List decodedBytes = base64Decode(response.data);
        String decompressedResponse = utf8.decode(GZipDecoder().decodeBytes(decodedBytes));
        Map<String, dynamic> result = jsonDecode(decompressedResponse);
        return ApiResponse.fromMap({
          'success': true,
          'data': result.isNotEmpty ? result['data'] : [],
        });
      } else {
        throw Exception('${response.statusCode}: ${response.statusMessage}');
      }
    } catch (e) {
      print('An error occurred: $e');
      throw Exception(e.toString());
    }
  }

  Future<Uint8List> compress(String data) async {
    List<int> utf8Bytes = utf8.encode(data);
    List<int> gzipBytes = GZipCodec().encode(utf8Bytes);
    return Uint8List.fromList(gzipBytes);
  }

  Future<String> decompress(Uint8List compressed) async {
    if (compressed.isEmpty) {
      return "";
    }

    if (_isCompressed(compressed)) {
      final GZipCodec gzip = GZipCodec();
      List<int> decompressedBytes = gzip.decode(compressed);
      return utf8.decode(decompressedBytes);
    } else {
      return String.fromCharCodes(compressed);
    }
  }

  bool _isCompressed(Uint8List compressed) {
    return true;
  }
}
