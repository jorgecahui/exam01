// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/gastos_viewmodel.dart';
import 'screens/home_screen.dart';
void main() {
  runApp(const MiApp());
}
class MiApp extends StatelessWidget {
  const MiApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
// create se llama UNA sola vez al iniciar la app.
// El ViewModel vive mientras la app este abierta.
      create: (_) => GastosViewModel(),
      child: MaterialApp(
        title: 'Control de Gastos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}