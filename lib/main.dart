import 'package:core/constants/env/env.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/theme.dart';
import 'package:core/utils/app_utils.dart';
import 'package:dependencies/bloc/bloc.dart';
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
    // Provided above MaterialApp.router so every routed page can reach it with
    // `context.read<AppNavigator>()`. The locator is touched only here, at the
    // composition root — widgets depend on the abstraction, not on GetIt.
    return RepositoryProvider<AppNavigator>.value(
      value: getIt<AppNavigator>(),
      child: MaterialApp.router(
        title: 'Fridge Chef AI',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        routerConfig: getIt<AppRouter>().config,
      ),
    );
  }
}
