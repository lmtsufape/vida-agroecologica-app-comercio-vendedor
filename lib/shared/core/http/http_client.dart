import 'package:dio/dio.dart';

abstract class IHttpClient {
  Future get({required String url});
}

class HttpClient implements IHttpClient {
  final Dio _dio = Dio();

  @override
  Future get({required String url}) async {
    final response = await _dio.get(url);
    return response.data;
  }
}
