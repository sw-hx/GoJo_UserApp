import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<dynamic> sendRequest({
    required String endpoint,
    required String method,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await dio.request(
        endpoint,
        data: method == 'GET' ? null : data,
        options: Options(
          method: method,
          headers: {
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode != null && response.statusCode! < 300) {
        return response.data;
      } else {
        final message = response.data is Map<String, dynamic>
            ? response.data['message'] ?? 'Unknown error'
            : 'Unknown error';
        throw Exception(message);
      }
    } on DioException catch (e) {
      final message = e.response?.data ?? e.message;
      throw Exception("Dio Error: $message");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
