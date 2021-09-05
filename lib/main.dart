import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pawon/shared/shared.dart';
import 'package:pawon/ui/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(), // Wrap your app
  );
  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     builder: (context) => MyApp(), // Wrap your app
  //   )
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFE7973F, ColorModel.color)
      ),
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
    );
  }
}