import 'dart:async';

import 'package:adhicine/screens/add_medicine.dart';
import 'package:adhicine/screens/home.dart';
import 'package:adhicine/screens/login.dart';
import 'package:adhicine/screens/signup.dart';
import 'package:adhicine/screens/splash.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const Login(),
        '/signup': (context) => const SignUp(),
        '/home': (context) => const Home(),
        '/add_medicine': (context) => const AddMedicine(),
      },
    );
  }


}