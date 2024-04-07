import 'package:dio/dio.dart';
import 'http_utils/base_api.dart';

class SongApi {
  Future<Map<String, dynamic>> getAllSongInfo(String searchContent) async {
    return await HttpUtils().get(
        '/api/music/list?s=${Uri.encodeComponent(
            searchContent)}');
  }
}



