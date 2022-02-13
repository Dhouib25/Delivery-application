import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iac_project/Interfaces/cart.dart';
import 'package:iac_project/Interfaces/end_order.dart';
import 'package:iac_project/Interfaces/feed.dart';
import 'package:iac_project/Interfaces/otp.dart';
import 'package:iac_project/Interfaces/saved.dart';
import 'package:iac_project/Interfaces/search.dart';
import 'package:iac_project/firebase_options.dart';
import 'Interfaces/address.dart';
import 'Interfaces/forgot_password.dart';
import 'Interfaces/gps.dart';
import 'Interfaces/help.dart';
import 'Interfaces/map.dart';
import 'Interfaces/new_password.dart';
import 'Interfaces/opening.dart';
import 'Interfaces/profile.dart';
import 'Interfaces/setting.dart';
import 'Interfaces/signin.dart';
import 'Interfaces/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
      name: 'app', options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final String init = (FirebaseAuth.instance.currentUser != null) ? '/feed' : '/gps';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App",
      initialRoute: init,
      routes: {
        '/opening': (context) => const Opening(),
        '/signup': (context) => const SignUp(),
        '/signin': (context) => const SignIn(),
        '/forgot_password': (context) => const ForgotPassword(),
        '/otp': (context) => OTP(),
        '/new_password': (context) => NewPassword(),
        '/gps': (context) => const GPS(),
        '/settings': (context) => const Setting(),
        '/address': (context) => Address(),
        '/help': (context) => const Help(),
        '/profile': (context) => const Profile(),
        '/feed': (context) => const Feed(),
        '/map': (context) => const Mapp(),
        '/end_order': (context) => const EndOrder(),
        '/cart': (context) => const Cart(),
        '/search': (context) => const Search(),
        '/saved': (context) => const Saved(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
      ),
    );
  }
}
