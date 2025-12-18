import 'package:echange_pret_biens/views/firebase_options.dart';
import 'package:echange_pret_biens/views/home_page.dart';
import 'package:echange_pret_biens/views/login_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';

import 'controllers/item_controller.dart';
import 'views/auth/login_page.dart';
import 'views/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialisation Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const DevMobMvcApp());
}

class DevMobMvcApp extends StatelessWidget {
  const DevMobMvcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ItemController()..loadItems(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DEVMOB MVC',

        // 🔐 Démarrage sur Login
        initialRoute: '/',

        routes: {
          '/': (_) => const LoginPage(),
          '/home': (_) => const HomePage(),
        },

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
      ),
    );
  }
}
