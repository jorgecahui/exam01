import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/gastos_viewmodel.dart';
import 'nuevo_gasto_screen.dart';
import 'detalle_gasto_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<GastosViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Gastos'),
      ),
      body: Column(
        children: [
          // TOTAL GENERAL
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Total: S/. ${vm.totalGeneral.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
          ),

          // LISTA
          Expanded(
            child: vm.gastos.isEmpty
                ? const Center(
              child: Text('No hay gastos registrados'),
            )
                : ListView.builder(
              itemCount: vm.gastos.length,
              itemBuilder: (context, index) {
                final g = vm.gastos[index];

                return ListTile(
                  title: Text(g.nombre),
                  subtitle: Text(g.categoria),
                  trailing: Text('S/. ${g.monto}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            DetalleGastoScreen(gasto: g),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const NuevoGastoScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}