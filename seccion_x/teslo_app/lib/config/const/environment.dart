import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String loginUrl = "/auth/login";

  static String checkStatusUrl = "/auth/check-status";

  static String registerUrl = "/auth/register";

  static String apiUrl = dotenv.env['API_URL'] ?? '';
}
