import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/item_controller.dart';
import 'views/home/home_page.dart';

void main() {
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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        
      ),
    );
  }
}
