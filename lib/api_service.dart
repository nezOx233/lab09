import 'package:dio/dio.dart';

class ApiService {
  static const String baseUrl =
      'https://flutterlab13roman.requestcatcher.com';

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),

      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  static Future<void> login({
    required String email,
    required String password,
  }) async {
    await _dio.post('/login', data: {
      'email': email.trim(),
      'password': password,
    });
  }

  static Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await _dio.post('/signup', data: {
      'name': name.trim(),
      'email': email.trim(),
      'password': password,
    });
  }

  static Future<void> resetPassword({required String email}) async {
    await _dio.post('/reset-password', data: {
      'email': email.trim(),
    });
  }

  static String errorMessage(Object error) {
    if (error is DioException) {
      final status = error.response?.statusCode;
      if (status != null) {
        return 'Сервер повернув HTTP $status';
      }
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return 'Перевищено час очікування відповіді';
      }
      return 'Перевірте мережу й адресу сервера. У Flutter Web можлива помилка CORS';
    }
    return 'Не вдалося надіслати запит';
  }
}
