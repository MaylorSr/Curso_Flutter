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

  static Dio dioProducts({required String accesToken}) => Dio(
        BaseOptions(
          baseUrl: Environment.apiUrl,
          headers: {'Authorization': 'Bearer $accesToken'},
          receiveTimeout: const Duration(
            seconds: 5,
          ),
        ),
      );
}
