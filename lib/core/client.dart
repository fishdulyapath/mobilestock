import 'package:dio/dio.dart';
import 'package:mobilestock/core/app_const.dart';

class Client {
  Dio init() {
    Dio dio = Dio();
    dio.interceptors.add(ApiInterceptors());

    String endPointService = "http://43.240.113.44:8089/MobileStockServiceAPI/service/stockservice/";
    if (endPointService.isNotEmpty) {
      endPointService += endPointService[endPointService.length - 1] == "/" ? "" : "/";
    }

    dio.options.baseUrl = endPointService;

    return dio;
  }
}

class ApiResponse<T> {
  late final bool success;
  late final bool error;
  // ignore: unnecessary_question_mark
  late final dynamic? data;
  late final message;
  late final code;
  final Page? page;

  ApiResponse({
    required this.success,
    required this.data,
    this.error = true,
    this.message = "",
    this.code = 00,
    this.page,
  });

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
      success: map['success'] ?? false,
      error: map['error'] ?? true,
      data: map['data'],
      page: map['pages'] == null ? Page.empty : Page.fromMap(map['pages']),
    );
  }
}

class Page {
  final int size;
  final int currentPage;
  final int totalRecord;
  final int maxPage;

  const Page({
    required this.size,
    required this.currentPage,
    required this.totalRecord,
    required this.maxPage,
  });

  static const empty = Page(size: 0, currentPage: 0, totalRecord: 0, maxPage: 0);

  bool get isEmpty => this == Page.empty;

  bool get isNotEmpty => this == Page.empty;

  factory Page.fromMap(Map<String, dynamic> map) {
    return Page(size: map['size'], currentPage: map['page'], totalRecord: map['total_record'], maxPage: map['max_page']);
  }
}

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //options.headers['Content-Type'] = 'application/json';

    // String authorization = options.extra['Authorization'] ??= '';
    // if (authorization.isNotEmpty) {
    //   options.headers['Authorization'] = authorization;
    // }

    super.onRequest(options, handler);
  }
}
