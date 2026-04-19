import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/gastos_viewmodel.dart';
import 'views/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GastosViewModel(),
      child: const MiApp(),
    ),
  );
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Control de Gastos',
      home: const HomeScreen(),
    );
  }
}