import 'package:teslo_shop/features/auth/auth.dart';

abstract class AuthDataSource {
  Future<User> login({required String email, required String password});
  Future<User> register({
    required String fullName,
    required String email,
    required String password,
  });

  Future<User> checkAuthStatus({required String token});
}
