import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'config/theme.dart';
import 'providers/locale_provider.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e, st) {
    debugPrint('Firebase.initializeApp failed: $e\n$st');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LocaleProvider())],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp(
            title: 'Akash Zaib Malik - Portfolio',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.darkTheme,
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
            ],
            locale: localeProvider.locale,
            supportedLocales: LocaleProvider.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) {
              final mq = MediaQuery.of(context);
              // Smooths Ctrl+/Ctrl- browser zoom so layouts rarely overflow extremes.
              final textScaler = mq.textScaler.clamp(
                minScaleFactor: 0.78,
                maxScaleFactor: 1.48,
              );
              return Directionality(
                textDirection: localeProvider.isRTL
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: MediaQuery(
                  data: mq.copyWith(textScaler: textScaler),
                  child: child!,
                ),
              );
            },
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
