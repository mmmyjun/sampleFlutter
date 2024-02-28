import 'package:dio/dio.dart';

class HttpException implements Exception {
  final String? _message;

  String get message => _message ?? this.runtimeType.toString();

  final int? _code;

  int get code => _code ?? -1;

  HttpException([this._message, this._code]);

  String toString() {
    return "code:$code--message=$message";
  }
}

/// 客户端请求错误
class BadRequestException extends HttpException {
  BadRequestException({String? message, int? code}) : super(message, code);
}

/// 服务端响应错误
class BadServiceException extends HttpException {
  BadServiceException({String? message, int? code}) : super(message, code);
}

class UnknownException extends HttpException {
  UnknownException([String? message]) : super(message);
}

class CancelException extends HttpException {
  CancelException([String? message]) : super(message);
}

class NetworkException extends HttpException {
  NetworkException({String? message, int? code}) : super(message, code);
}

/// 401
class UnauthorisedException extends HttpException {
  UnauthorisedException({String? message, int? code = 401}) : super(message);
}

class BadResponseException extends HttpException {
  dynamic? data;

  BadResponseException([this.data]) : super();
}

class BaseApi {
  static const String baseUrl = '';

  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(minutes: 2),
    sendTimeout: const Duration(minutes: 2),
    receiveTimeout: const Duration(minutes: 2),
    validateStatus: (status) {
      return status! < 500;
    },
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
  ));

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    final response = await _dio.get(
      path,
      queryParameters: params,
      options: options,
    );
    return _handleResponse(response, path);
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    final response = await _dio.post(
      path,
      data: data,
      options: options,
    );
    return _handleResponse(response, path);
  }

  Future<Map<String, dynamic>> _handleResponse(Response response, path) async {
    print('statusCode.........${response.statusCode}, $path');
    if (response.statusCode == 200) {
      if (response.data is String) {
        return {'data': response.data};
      }
      return response.data;
    } else if (response.statusCode == 400) {
      // return BadRequestException(message: "请求语法错误", code: 400);
      throw BadRequestException(message: "请求语法错误", code: 400);
    } else if (response.statusCode == 401) {
      print('error 401-----------');
      throw UnauthorisedException();
    } else if (response.statusCode == 403) {
      print('error 403-----------');
      // return BadRequestException(message: "服务器拒绝执行", code: 403);
      throw BadRequestException(message: "服务器拒绝执行", code: 403);
    } else if (response.statusCode == 500) {
      // return BadServiceException(message: "服务器内部错误", code: 500);
      throw BadServiceException(message: "服务器内部错误", code: 500);
    } else {
      print('error UnknownException-----------${response.statusCode}');
      throw UnknownException();
    }
  }
}
