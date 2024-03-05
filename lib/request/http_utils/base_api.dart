import 'package:dio/dio.dart';
import 'exception_api.dart';

class HttpUtils {
  static final HttpUtils _instance = HttpUtils._internal();
  final Dio _dio = Dio();

  factory HttpUtils() => _instance;

  HttpUtils._internal() {
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  // HttpUtils().init(baseUrl: 'https://api.example.com');
  void init({String? baseUrl}) {
    _dio.options.baseUrl = baseUrl ?? '';
    // if (interceptors != null && interceptors.isNotEmpty) {
    //   _dio.interceptors.addAll(interceptors);
    // }
    _dio.interceptors.add(ResponseInterceptor());
  }

  // HttpUtils().get('/path', params: {'id': 1}, options: Options(baseUrl: 'https://api.example.com'));
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
    // return _handleResponse(response, path);
    return response.data;
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
    // return _handleResponse(response, path);
    return response.data;
  }
}
class ResponseInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      // 处理200的情况
      handler.next(response);
    } else if (response.statusCode == 400) {
      // 处理400的情况
      handler.reject(BadRequestException(message: "请求语法错误", code: 400) as DioException);
    } else if (response.statusCode == 401) {
      // 处理401的情况
      handler.reject(UnauthorisedException() as DioException);
    } else if (response.statusCode == 403) {
      // 处理403的情况
      handler.reject(BadRequestException(message: "服务器拒绝执行", code: 403) as DioException);
    } else if (response.statusCode == 500) {
      // 处理500的情况
      handler.reject(BadServiceException(message: "服务器内部错误", code: 500) as DioException);
    } else {
      // 处理其他的情况
      handler.reject(UnknownException() as DioException);
    }
  }
}


// Future<Map<String, dynamic>> _handleResponse(Response response, path) async {
//   print('statusCode.........${response.statusCode}, $path');
//   if (response.statusCode == 200) {
//     if (response.data is String) {
//       return {'data': response.data};
//     }
//     return response.data;
//   } else if (response.statusCode == 400) {
//     // return BadRequestException(message: "请求语法错误", code: 400);
//     throw BadRequestException(message: "请求语法错误", code: 400);
//   } else if (response.statusCode == 401) {
//     print('error 401-----------');
//     throw UnauthorisedException();
//   } else if (response.statusCode == 403) {
//     print('error 403-----------');
//     // return BadRequestException(message: "服务器拒绝执行", code: 403);
//     throw BadRequestException(message: "服务器拒绝执行", code: 403);
//   } else if (response.statusCode == 500) {
//     // return BadServiceException(message: "服务器内部错误", code: 500);
//     throw BadServiceException(message: "服务器内部错误", code: 500);
//   } else {
//     print('error UnknownException-----------${response}-----------');
//     throw UnknownException();
//   }
// }