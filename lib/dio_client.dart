import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com/'));

  Dio get dio => _dio;

  DioClient() {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
    _dio.options.connectTimeout = const Duration(seconds: 5); // 5 seconds
    _dio.options.receiveTimeout = const Duration(seconds: 5); // 5 seconds
  }

  Future<Response> createData(Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post('/posts', data: data);
      return response;
    } catch (e) {
      throw Exception('Failed to create data: $e');
    }
  }

  Future<Response> readData(int id) async {
    try {
      Response response = await _dio.get('/posts/$id');
      return response;
    } catch (e) {
      throw Exception('Failed to read data: $e');
    }
  }

  Future<Response> updateData(int id, Map<String, dynamic> data) async {
    try {
      Response response = await _dio.put('/posts/$id', data: data);
      return response;
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  Future<Response> deleteData(int id) async {
    try {
      Response response = await _dio.delete('/posts/$id');
      return response;
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }
}
