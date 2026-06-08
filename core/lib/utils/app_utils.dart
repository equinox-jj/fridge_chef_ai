import 'package:dependencies/flutter_dotenv/flutter_dotenv.dart';

abstract class AppUtils {
  const AppUtils._();

  static Future<void> initEnv() async {
    await dotenv.load(fileName: '.env');
  }
}
