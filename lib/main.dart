import 'package:core/blocs/connectivity_bloc.dart';
import 'package:core/constants/env/env.dart';
import 'package:core/di/di.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/app_theme.dart';
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
    return MultiBlocProvider(
      providers: <Widget>[
        RepositoryProvider<AppNavigator>.value(
          value: getIt<AppNavigator>(),
        ),
        BlocProvider<ConnectivityBloc>.value(
          value: getIt<ConnectivityBloc>(),
        ),
      ].cast(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        routerConfig: getIt<AppRouter>().config,
      ),
    );
  }
}
