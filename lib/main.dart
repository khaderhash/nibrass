import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/student_home/presentation/pages/student_home_page.dart';

void main() {
  runApp(const NibrassApp());
}

class NibrassApp extends StatelessWidget {
  const NibrassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Nibrass Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/student_home', page: () => StudentHomePage()),
        GetPage(name: '/employee_dashboard', page: () => Scaffold(body: Center(child: Text("Employee")))),
      ],
    );
  }
}