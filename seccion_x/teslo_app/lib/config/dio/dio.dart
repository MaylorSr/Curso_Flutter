import 'package:dio/dio.dart';
import 'package:teslo_shop/config/const/environment.dart';

class DioRest {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      receiveTimeout: const Duration(
        seconds: 5,
      ), // Configuración del receiveTimeout a 5 segundos
    ),
  );
}
