# Phone Auth OTP UI

[![pub package](https://img.shields.io/pub/v/phone_auth_otp_ui.svg)](https://pub.dev/packages/firebase_ui_auth)

Phone Auth OTP UI is a phone number authentication with OTP UI, that comes with super cool features like auto country code update as per user location, country selector screen with a search option, otp screen to verify user phone number and a super beautiful UI that will suit any flutter project. 

> Please contribute to the [discussion](https://github.com/stanezeaku/phone_auth_otp_ui/discussions/6978) with feedback.


## Installation

```sh
flutter pub add phone_auth_otp_ui
```

## Getting Started

Here's a quick example that shows how to implement the UI in your app

```dart
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
```

Learn more [here](https://github.com/firebase/flutterfire/tree/master/packages/firebase_ui_auth/doc).

## Roadmap / Features

- For issues, please create a new [issue on the repository](https://github.com/stanezeaku/phone_auth_otp_ui/issues).
- For feature requests, & questions, please participate on the [discussion](https://github.com/stanezeaku/phone_auth_otp_ui/discussions/6978) thread.
- To contribute a change to this plugin, please review our [contribution guide](https://github.com/stanezeaku/phone_auth_otp_ui/master/CONTRIBUTING.md) and open a [pull request](https://github.com/stanezeaku/phone_auth_otp_ui/pulls).

