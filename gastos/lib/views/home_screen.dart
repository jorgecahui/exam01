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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Total: S/. ${vm.totalGeneral.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Alimentación: S/. ${vm.totalPorCategoria("Alimentacion").toStringAsFixed(2)}'),
                Text('Transporte: S/. ${vm.totalPorCategoria("Transporte").toStringAsFixed(2)}'),
                Text('Entretenimiento: S/. ${vm.totalPorCategoria("Entretenimiento").toStringAsFixed(2)}'),
                Text('Salud: S/. ${vm.totalPorCategoria("Salud").toStringAsFixed(2)}'),
                Text('Otros: S/. ${vm.totalPorCategoria("Otros").toStringAsFixed(2)}'),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: vm.gastos.isEmpty
                ? const Center(
              child: Text(
                'No hay gastos registrados',
                style: TextStyle(color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: vm.gastos.length,
              itemBuilder: (context, index) {
                final g = vm.gastos[index];

                return ListTile(
                  title: Text(g.nombre),
                  subtitle: Text(g.categoria),
                  trailing: Text(
                    'S/. ${g.monto.toStringAsFixed(2)}',
                  ),
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