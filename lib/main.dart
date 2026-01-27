import 'package:flutter/material.dart';

void main() {
  runApp(const NibrassApp());
}

class NibrassApp extends StatelessWidget {
  const NibrassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nibrass Hub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(child: Text('Nibrass Hub Initialized')),
      ),
    );
  }
}
