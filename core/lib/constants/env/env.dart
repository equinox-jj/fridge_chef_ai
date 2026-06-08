import 'package:dependencies/flutter_dotenv/flutter_dotenv.dart';

abstract class Env {
  const Env._();

  static final String supabaseUrl = dotenv.get('SUPABASE_URL');
  static final String supabaseKey = dotenv.get('SUPABASE_KEY');
  static final String geminiKey = dotenv.get('GEMINI_KEY');
}
