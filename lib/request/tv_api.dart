import 'package:dio/dio.dart';
import 'http_utils/base_api.dart';

class TvApi {
  Future<Map<String, dynamic>> getAllTvInfo(String searchContent) async {
    return await HttpUtils()
        .get('/api/video/list?s=${Uri.encodeComponent(searchContent)}');
  }

  Future<Map<String, dynamic>> getVideoInfoById(String id) async {
    return await HttpUtils()
        .get('/api/video/${Uri.encodeComponent(id)}');
  }
}
