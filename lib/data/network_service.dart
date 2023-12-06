import 'package:dio/dio.dart';
import 'package:sandiq/core/params/apis.dart';

abstract class Network {
  Future<bool> methodLogIn({
    required String api,
    required Map<String, Object?> data,
  });
}

class HttpService implements Network {
  late final Dio _dio;

  HttpService() {
    _dio = Dio();
  }

  // #Method SignUp
  @override
  Future<bool> methodLogIn({
    required String api,
    required Map<String, Object?> data,
  }) async {
    try {
      final response = await _dio.post(
        "${Api.baseUrl}$api",
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      throw Exception("Sign Up ERROR:===>$e");
    }
  }
}


