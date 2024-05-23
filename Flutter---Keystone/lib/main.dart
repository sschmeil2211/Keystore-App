import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keystore/firebase_options.dart';
import 'package:keystore/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:keystore/screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ControllersProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SeedProvider()),
        ChangeNotifierProvider(create: (_) => PasswordProvider()),
        ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
      ],
      child: MaterialApp(
        title: 'Keystore',
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(brightness: Brightness.light),
        themeMode: ThemeMode.dark,
        initialRoute: 'splashScreen',
        routes: {
          'splashScreen'        : (_) => const SplashScreen(),
          'signScreen'          : (_) => const SignScreen(),
          'homeScreen'          : (_) => const HomeScreen(),
          'pinScreen'           : (_) => const PinScreen(),
          'seedScreen'          : (_) => const SeedScreen(),
          'profileScreen'       : (_) => const ProfileScreen(),
          'emailToVerifyScreen' : (_) => const EmailToVerifyScreen(),
          'verifySeedScreen'    : (_) => const VerifySeedScreen(),
          'newPasswordScreen'   : (_) => const NewPasswordScreen(),
        },
      ),
    );
  }
}