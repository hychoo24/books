import 'package:books/providers/inventory_provider.dart';
import 'package:books/providers/stat_provider.dart';
import 'package:books/screens/auth/login_page.dart';
import 'package:books/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:books/providers/book_provider.dart';
import 'package:books/providers/category_provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => InventoryProvider()),
        ChangeNotifierProvider(create: (_) => StatProvider()),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: LoginPage(),
        // home: const HomePage(),
      ),
    );
  }
}
