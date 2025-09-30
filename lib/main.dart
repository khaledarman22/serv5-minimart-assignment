import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:minimart/core/cach_helper/cache_helper.dart';
import 'package:minimart/core/models/product_card.dart';
import 'package:minimart/core/models/product_model.dart';
import 'package:minimart/core/themes/app_theme.dart';
import 'package:minimart/core/themes/cubit/theme_cubit.dart';
import 'package:minimart/core/themes/cubit/theme_state.dart';
import 'package:minimart/features/cart/cubit/cart_cubit.dart';
import 'package:minimart/features/splash/splash_screen.dart';
import 'package:minimart/firebase_options.dart';
import 'package:minimart/service_locator.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.logger = EasyLogger(
    printer: (object, {level, name, stackTrace}) => log(
      name:
          "${level == LevelMessages.error || level == LevelMessages.warning ? "❌" : "🌎"} ESAY LOCALIZATION",
      object.toString(),
    ),
    enableBuildModes: [if (kDebugMode) BuildMode.debug],
    enableLevels: [if (kDebugMode) LevelMessages.info, LevelMessages.warning, LevelMessages.error],
  );
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();
  setupServiceLocator();
  // Register adapters
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(ProductCardAdapter());
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      fallbackLocale: const Locale('ar'),
      path: 'assets/translations',
      startLocale: const Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ThemeCubit>()..loadTheme()),
        BlocProvider(create: (context) => sl<CartCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Mini Mart',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode,
            navigatorKey: navigatorKey,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
