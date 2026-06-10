import 'package:core/constants/env/env.dart';
import 'package:core/theme/theme.dart';
import 'package:core/utils/app_utils.dart';
import 'package:dependencies/firebase/firebase_core.dart';
import 'package:dependencies/supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'injector.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppUtils.initEnv();
  await Supabase.initialize(
    url: Env.supabaseUrl,
    publishableKey: Env.supabaseKey,
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fridge Chef AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: getIt<AppRouter>().config,
    );
  }
}
