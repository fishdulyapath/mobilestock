import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';

import 'package:mobilestock/core/client.dart';
import 'package:mobilestock/model/cart_model.dart';
import 'package:mobilestock/model/item_model.dart';
import 'package:mobilestock/model/post_select_model.dart';
import 'package:mobilestock/model/user_login_model.dart';
import 'package:mobilestock/global.dart' as global;
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';

class WebServiceRepository {
  Future<ApiResponse> getLocation(String whcode) async {
    global.loadConfig();
    Dio client = Client().init();

    try {
      final response = await client.get('/getLocation?provider=${global.serverProvider}&dbname=${global.serverDatabase}&whcode=$whcode');
      try {
        final rawData = json.decode(response.toString());
        if (rawData['error'] != null) {
          throw Exception('${rawData['code']}: ${rawData['message']}');
        }
        return ApiResponse.fromMap(rawData);
      } catch (ex) {
        throw Exception(ex);
      }
    } on DioException catch (ex) {
      String errorMessage = ex.response.toString();
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> getWarehouse() async {
    global.loadConfig();
    Dio client = Client().init();

    try {
      final response = await client.get('/getWarehouse?provider=${global.serverProvider}&dbname=${global.serverDatabase}&branchcode=${global.branchCode}');
      try {
        final rawData = json.decode(response.toString());
        if (rawData['error'] != null) {
          throw Exception('${rawData['code']}: ${rawData['message']}');
        }
        return ApiResponse.fromMap(rawData);
      } catch (ex) {
        throw Exception(ex);
      }
    } on DioException catch (ex) {
      String errorMessage = ex.response.toString();
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> getCartList() async {
    global.loadConfig();
    Dio client = Client().init();

    try {
      final response = await client.get('/getCartList?provider=${global.serverProvider}&dbname=${global.serverDatabase}&branchcode=${global.branchCode}');
      try {
        final rawData = json.decode(response.toString());
        if (rawData['error'] != null) {
          throw Exception('${rawData['code']}: ${rawData['message']}');
        }
        return ApiResponse.fromMap(rawData);
      } catch (ex) {
        throw Exception(ex);
      }
    } on DioException catch (ex) {
      String errorMessage = ex.response.toString();
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> getCartSubList() async {
    global.loadConfig();
    Dio client = Client().init();

    try {
      final response = await client.get('/getCartSubList?provider=${global.serverProvider}&dbname=${global.serverDatabase}&branchcode=${global.branchCode}');
      try {
        final rawData = json.decode(response.toString());
        if (rawData['error'] != null) {
          throw Exception('${rawData['code']}: ${rawData['message']}');
        }
        return ApiResponse.fromMap(rawData);
      } catch (ex) {
        throw Exception(ex);
      }
    } on DioException catch (ex) {
      String errorMessage = ex.response.toString();
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> getBranchList() async {
    global.loadConfig();
    Dio client = Client().init();

    try {
      final response = await client.get('/getBranchList?provider=${global.serverProvider}&dbname=${global.serverDatabase}');
      try {
        final rawData = json.decode(response.toString());
        if (rawData['error'] != null) {
          throw Exception('${rawData['code']}: ${rawData['message']}');
        }
        return ApiResponse.fromMap(rawData);
      } catch (ex) {
        throw Exception(ex);
      }
    } on DioException catch (ex) {
      String errorMessage = ex.response.toString();
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> getItemSearch(String search) async {
    global.loadConfig();
    Dio client = Client().init();

    try {
      final response = await client.get('/getItemSearch?provider=${global.serverProvider}&dbname=${global.serverDatabase}&search=$search');
      try {
        final rawData = json.decode(response.toString());
        if (rawData['error'] != null) {
          throw Exception('${rawData['code']}: ${rawData['message']}');
        }
        return ApiResponse.fromMap(rawData);
      } catch (ex) {
        throw Exception(ex);
      }
    } on DioException catch (ex) {
      String errorMessage = ex.response.toString();
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> getItemDetail(String barcode, String whcode, String lccode) async {
    global.loadConfig();
    Dio client = Client().init();

    try {
      final response = await client.get('/getItemDetail?provider=${global.serverProvider}&dbname=${global.serverDatabase}&barcode=$barcode&whcode=$whcode&lccode=$lccode');
      try {
        final rawData = json.decode(response.toString());
        if (rawData['error'] != null) {
          throw Exception('${rawData['code']}: ${rawData['message']}');
        }
        return ApiResponse.fromMap(rawData);
      } catch (ex) {
        throw Exception(ex);
      }
    } on DioException catch (ex) {
      String errorMessage = ex.response.toString();
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> getCartDetail(String docno) async {
    global.loadConfig();
    Dio client = Client().init();

    try {
      final response = await client.get('/getCartDetail?provider=${global.serverProvider}&dbname=${global.serverDatabase}&docno=$docno');
      try {
        final rawData = json.decode(response.toString());
        if (rawData['error'] != null) {
          throw Exception('${rawData['code']}: ${rawData['message']}');
        }
        return ApiResponse.fromMap(rawData);
      } catch (ex) {
        throw Exception(ex);
      }
    } on DioException catch (ex) {
      String errorMessage = ex.response.toString();
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> getCartSubDetail(String docno) async {
    global.loadConfig();
    Dio client = Client().init();

    try {
      final response = await client.get('/getCartSubDetail?provider=${global.serverProvider}&dbname=${global.serverDatabase}&docno=$docno');
      try {
        final rawData = json.decode(response.toString());
        if (rawData['error'] != null) {
          throw Exception('${rawData['code']}: ${rawData['message']}');
        }
        return ApiResponse.fromMap(rawData);
      } catch (ex) {
        throw Exception(ex);
      }
    } on DioException catch (ex) {
      String errorMessage = ex.response.toString();
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> sendCart(String docno) async {
    global.loadConfig();
    Dio client = Client().init();

    try {
      final response = await client.get('/sendCart?provider=${global.serverProvider}&dbname=${global.serverDatabase}&docno=$docno');
      try {
        final rawData = json.decode(response.toString());
        if (rawData['error'] != null) {
          throw Exception('${rawData['code']}: ${rawData['message']}');
        }
        return ApiResponse.fromMap(rawData);
      } catch (ex) {
        throw Exception(ex);
      }
    } on DioException catch (ex) {
      String errorMessage = ex.response.toString();
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> sendSubCart(String docno) async {
    global.loadConfig();
    Dio client = Client().init();

    try {
      final response = await client.get('/sendSubCart?provider=${global.serverProvider}&dbname=${global.serverDatabase}&docno=$docno');
      try {
        final rawData = json.decode(response.toString());
        if (rawData['error'] != null) {
          throw Exception('${rawData['code']}: ${rawData['message']}');
        }
        return ApiResponse.fromMap(rawData);
      } catch (ex) {
        throw Exception(ex);
      }
    } on DioException catch (ex) {
      String errorMessage = ex.response.toString();
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> deleteCart(String docno) async {
    global.loadConfig();
    Dio client = Client().init();

    try {
      final response = await client.get('/deleteCart?provider=${global.serverProvider}&dbname=${global.serverDatabase}&docno=$docno');
      try {
        final rawData = json.decode(response.toString());
        if (rawData['error'] != null) {
          throw Exception('${rawData['code']}: ${rawData['message']}');
        }
        return ApiResponse.fromMap(rawData);
      } catch (ex) {
        throw Exception(ex);
      }
    } on DioException catch (ex) {
      String errorMessage = ex.response.toString();
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> createCart(String docno, String whcode, String locationcode, String remark) async {
    global.loadConfig();
    Dio client = Client().init();

    try {
      final response = await client
          .post('/createCart?provider=${global.serverProvider}&dbname=${global.serverDatabase}', data: {'docno': docno, 'whcode': whcode, 'locationcode': locationcode, 'remark': remark, 'usercode': global.userCode, 'branchcode': global.branchCode});
      try {
        final rawData = json.decode(response.toString());
        if (rawData['error'] != null) {
          throw Exception('${rawData['code']}: ${rawData['message']}');
        }
        return ApiResponse.fromMap(rawData);
      } catch (ex) {
        throw Exception(ex);
      }
    } on DioException catch (ex) {
      String errorMessage = ex.response.toString();
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> mergeCart(String docno, String docdate, String doctime, String whcode, String locationcode, String remark, String carts) async {
    global.loadConfig();
    Dio client = Client().init();
    var postData = {'docno': docno, 'whcode': whcode, 'locationcode': locationcode, 'remark': remark, 'usercode': global.userCode, 'branchcode': global.branchCode, 'docdate': docdate, 'doctime': doctime, 'carts': carts};
    try {
      final response = await client.post('/mergeCart?provider=${global.serverProvider}&dbname=${global.serverDatabase}', data: postData);
      try {
        final rawData = json.decode(response.toString());
        if (rawData['error'] != null) {
          throw Exception('${rawData['code']}: ${rawData['message']}');
        }
        return ApiResponse.fromMap(rawData);
      } catch (ex) {
        throw Exception(ex);
      }
    } on DioException catch (ex) {
      String errorMessage = ex.response.toString();
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> saveCartDetail(List<ItemScanModel> item, CartModel cart) async {
    global.loadConfig();
    Dio client = Client().init();
    item.forEach((element) {
      element.linenumber = item.indexOf(element) + 1;
    });
    var detail = item.map((e) => e.toJson()).toList();
    try {
      final response = await client.post('/saveCartDetail?provider=${global.serverProvider}&dbname=${global.serverDatabase}', data: {'docno': cart.docno, 'whcode': cart.whcode, 'locationcode': cart.locationcode, 'details': detail});
      try {
        final rawData = json.decode(response.toString());
        if (rawData['error'] != null) {
          throw Exception('${rawData['code']}: ${rawData['message']}');
        }
        return ApiResponse.fromMap(rawData);
      } catch (ex) {
        throw Exception(ex);
      }
    } on DioException catch (ex) {
      String errorMessage = ex.response.toString();
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> saveCartSubDetail(List<ItemScanModel> item, CartModel cart) async {
    global.loadConfig();
    Dio client = Client().init();
    var detail = item.map((e) => e.toJson()).toList();
    try {
      final response = await client.post('/saveCartSubDetail?provider=${global.serverProvider}&dbname=${global.serverDatabase}', data: {'docno': cart.docno, 'whcode': cart.whcode, 'locationcode': cart.locationcode, 'details': detail});
      try {
        final rawData = json.decode(response.toString());
        if (rawData['error'] != null) {
          throw Exception('${rawData['code']}: ${rawData['message']}');
        }
        return ApiResponse.fromMap(rawData);
      } catch (ex) {
        throw Exception(ex);
      }
    } on DioException catch (ex) {
      String errorMessage = ex.response.toString();
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> updateCart(String docno, String whcode, String locationcode, String remark) async {
    global.loadConfig();
    Dio client = Client().init();

    try {
      final response = await client
          .post('/updateCart?provider=${global.serverProvider}&dbname=${global.serverDatabase}', data: {'docno': docno, 'whcode': whcode, 'locationcode': locationcode, 'remark': remark, 'usercode': global.userCode, 'branchcode': global.branchCode});
      try {
        final rawData = json.decode(response.toString());
        if (rawData['error'] != null) {
          throw Exception('${rawData['code']}: ${rawData['message']}');
        }
        return ApiResponse.fromMap(rawData);
      } catch (ex) {
        throw Exception(ex);
      }
    } on DioException catch (ex) {
      String errorMessage = ex.response.toString();
      throw Exception(errorMessage);
    }
  }

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
