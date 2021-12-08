import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: 'https://student.valuxapps.com/api/',
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async
  {
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String language = 'ar',
    String? token,

  }) async {
    dio.options.headers = {
      'lang': language,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

  return dio.post(url ,
  queryParameters: query!,
  data: data,

   );
  }
}
