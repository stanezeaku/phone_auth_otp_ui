
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth_otp_ui/phone_auth_otp_ui.dart';


const bool USE_EMULATOR = true;

Future<void> main()  async{
    WidgetsFlutterBinding.ensureInitialized();

  // Initialize firebase
  await Firebase.initializeApp(

    name: 'phone-auth-otp-ui',
    options: DefaultFirebaseOptions.currentPlatform,
    
  );

  if (USE_EMULATOR) {
    _connectToFirebaseEmulator();
  }

runApp(const MyApp());
}

  Future _connectToFirebaseEmulator() async {
  const fireStorePort = "8080";
  const authPort = "9099";
  final localHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  FirebaseFirestore.instance.settings = Settings(
      host: "$localHost:$fireStorePort",
      sslEnabled: false,
      persistenceEnabled: false);
  await FirebaseAuth.instance.useEmulator("http://$localHost:$authPort");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
            fontFamily: "regular",
            primaryColor: kAppColor,
            backgroundColor: kAppColor,
            colorScheme: ThemeData()
                .colorScheme
                .copyWith(primary: kAppColor, secondary: kAppColor),

            // brightness: Brightness.light,
          ),
      home: const EditNumberScreen(navScreen: HomeScreen(),)
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kAppColor,
      ),
      body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/success.png',
              fit: BoxFit.cover,
              height: 250,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'User Authenticated \n Successfully!',
              style: TextStyle(
    fontSize: 18.0,
    fontFamily: 'semi-bold',
  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Support by liking this package and following my social media for more cool stuff',
                textAlign: TextAlign.center,
              ),
            ),
           
          
          ],
        ),
      ),
    )
    );
  }
}

