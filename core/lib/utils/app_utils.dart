import 'package:dependencies/flutter_dotenv/flutter_dotenv.dart';

abstract final class AppUtils {
  static Future<void> initEnv() async {
    await dotenv.load(fileName: '.env');
  }
}
