import 'package:teslo_shop/features/auth/auth.dart';

class AuthRepositoryImpl extends AuthRepository {

  final AuthDataSource dataSource;


  AuthRepositoryImpl({
    AuthDataSource? dataSource
  }) : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus({required String token}) {
    return dataSource.checkAuthStatus(token: token);
  }

  @override
  Future<User> login({required String email, required String password}) {
    return dataSource.login(email: email, password: password);
  }

  @override
  Future<User> register(
      {required String fullName,
      required String email,
      required String password}) {
    return dataSource.register(
      fullName: fullName,
      email: email,
      password: password,
    );
  }
}
