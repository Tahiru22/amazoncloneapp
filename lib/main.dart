import 'package:amazoncloneapp/layouts/screen_layout.dart';
import 'package:amazoncloneapp/models/product_model.dart';
import 'package:amazoncloneapp/providers/user_Details_provider.dart';
import 'package:amazoncloneapp/screens/product_screen.dart';
import 'package:amazoncloneapp/screens/result_screen.dart';
import 'package:amazoncloneapp/screens/sell_screen.dart';
import 'package:amazoncloneapp/screens/signin_screen.dart';
//import 'package:amazoncloneapp/screens/signup_screen.dart';
import 'package:amazoncloneapp/utils/color_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   if (kIsWeb) {
//     await Firebase.initializeApp(
//         options: const FirebaseOptions(
//             apiKey: "AIzaSyClvMlBt22CSp0WtxXxFnS2-iGOZ7n9V5E",
//             authDomain: "clone-460fd.firebaseapp.com",
//             projectId: "clone-460fd",
//             storageBucket: "clone-460fd.appspot.com",
//             messagingSenderId: "192690528297",
//             appId: "1:192690528297:web:047560adc57d5e6e1d7c38",
//             measurementId: "G-F9EPRMPRWQ"));
//   } else {
//     await Firebase.initializeApp();
//   }

//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              } else if (user.hasData) {
                return const ScreenLayout();
                //return const SellScreen();

                //return ResultScreen(
                //query: "thhth",
                //);
              } else {
                return const SignInScreen();
              }
            }),
      ),
    );
  }
}
