import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/exceptions/request_exception_data.dart';
import 'package:teslo_shop/features/auth/auth.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final dio = DioRest.dio;

  @override
  Future<User> checkAuthStatus({required String token}) async {
    try {
      final response = await dio.get(
        Environment.checkStatusUrl,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      final user = AuthMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw BadRequestException(
            statusCode: 401,
            errMessage: err.response?.data['message'] ??
                'Las credenciales no son correctas');
      }

      if (err.type == DioExceptionType.connectionTimeout) {
        throw ConnectionTimeOut(
            statusCode: 500,
            errMessage: err.response?.data['message'] ??
                'Compruebe su conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final response = await dio.post(Environment.loginUrl, data: {
        'email': email,
        'password': password,
      });

      final user = AuthMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        throw BadRequestException(
            statusCode: 401,
            errMessage: err.response?.data['message'] ??
                'Las credenciales no son correctas');
      }

      if (err.type == DioExceptionType.connectionTimeout) {
        throw ConnectionTimeOut(
            statusCode: 500,
            errMessage: err.response?.data['message'] ??
                'Compruebe su conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        Environment.registerUrl,
        data: {
          'email': email,
          'password': password,
          'fullName': fullName,
        },
      );
      final user = AuthMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (err) {
      if (err.response?.statusCode == 400) {
        throw BadRequestException(
            statusCode: 400,
            errMessage: err.response?.data['message'] ??
                'Las credenciales no son correctas');
      }

      if (err.type == DioExceptionType.connectionTimeout) {
        throw ConnectionTimeOut(
            statusCode: 500,
            errMessage: err.response?.data['message'] ??
                'Compruebe su conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
