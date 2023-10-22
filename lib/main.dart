import 'package:dolabi/screens/cart.dart';
import 'package:dolabi/screens/home.dart';
import 'package:dolabi/screens/login.dart';
import 'package:dolabi/screens/product_details.dart';
import 'package:dolabi/screens/products_list.dart';
import 'package:dolabi/screens/signup.dart';
import 'package:dolabi/screens/tabs_with_screens.dart';
import 'package:dolabi/services/auth_bloc.dart';
import 'package:dolabi/services/firestore_service.dart';
import 'package:dolabi/services/local_notifications_service.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'models.dart/app_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotificationService.initialize();
  runApp(const MyApp());
}

final fireStoreService = FireStoreService();
final authBloc = AuthBloc();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(
          create: (context) => authBloc.isLoggedIn(),
          initialData: false,
        ),
        Provider(
          create: (context) => authBloc,
        ),
        StreamProvider(
          create: (context) => authBloc.appUser,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(primary: Colors.transparent),
        ),
        home: /*SplashScreen(
            backgroundColor: Colors.white,
            seconds: 3,
            image: Image.asset('images/logo.png'),
            photoSize: 100,
            useLoader: true,
            loaderColor: const Color.fromARGB(255, 255, 115, 0),
            navigateAfterSeconds: */
            EasySplashScreen(
                logoWidth: 100,
                loaderColor: mainColor,
                durationInSeconds: 3,
                backgroundColor: Colors.white,
                logo: Image.asset('images/logo.png'),
                navigator: TabsWithScreens()),
      ),
    );
  }
}

class HomeOrLogin extends StatelessWidget {
  const HomeOrLogin({super.key});

  @override
  Widget build(BuildContext context) {
    var isLoggedIn = Provider.of<bool>(context);
    //final appUser = Provider.of<AppUser>(context);
    return (isLoggedIn != false) ? TabsWithScreens() : Login();
  }
}
