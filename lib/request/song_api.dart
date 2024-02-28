import 'package:dio/dio.dart';
import './base_api.dart';

class SongApi extends BaseApi {
  Future<Map<String, dynamic>> getAllSongInfo(String searchContent) async {
    // return await get('https://www.gequbao.com/s/$searchContent');
    return await get('https://code-app.netlify.app/api/music/list?s=${Uri.encodeComponent(searchContent)}');
  }

  Future<Map<String, dynamic>> getSongInfoById(String songId) async {
    return await get('https://spacedeta-1-f1000878.deta.app/api/proxy?url=https://www.gequbao.com/music/$songId');
  }

  Future<Map<String, dynamic>> getSongUrlById(String songId) async {
    return await get('https://www.gequbao.com/api/play_url?id=$songId&json=1');
  }
}
// 获取用户信息
// try {
// final userInfo = await UserApi().getUserInfo(userId);
// // 处理用户信息
// } catch (e) {
// // 处理错误
// }

// class Api {
//   static const String baseUrl = 'https://api.example.com';
//
//   Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));
//
//   Future<Map<String, dynamic>> getUserInfo(String userId) async {
//     final response = await _dio.get('/user/$userId');
//     return response.data;
//   }
// }


