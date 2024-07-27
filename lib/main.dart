import 'package:flutter/material.dart';
import 'package:newsapplication/services/firebase_remote_config.dart';
import 'package:newsapplication/services/news_service.dart';
import 'package:newsapplication/views/homeScreen.dart';
import 'package:newsapplication/views/loginScreen.dart';
import 'package:newsapplication/services/auth_service.dart';
import 'package:newsapplication/views/signupScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  print('start');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'newsapplicatino',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue.shade900);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('main');

    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<NewsService>(create: (_) => NewsService()),
        Provider<RemoteConfigService>(
            create: (_) => RemoteConfigService()..init()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: kColorScheme,
            appBarTheme: AppBarTheme().copyWith(
                backgroundColor: kColorScheme.onPrimaryContainer,
                foregroundColor: kColorScheme.onSecondary)),
        routes: {
          '/signup': (context) => const SignupScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => HomeScreen(),
        },
        home: const SignupScreen(),
        //
        // ),
      ),
    );
  }
}
