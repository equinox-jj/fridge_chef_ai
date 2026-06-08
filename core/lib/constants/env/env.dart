import 'package:dependencies/flutter_dotenv/flutter_dotenv.dart';

abstract class Env {
  static final String supabaseUrl = dotenv.get('SUPABASE_URL');
  static final String supabaseKey = dotenv.get('SUPABASE_KEY');
}
