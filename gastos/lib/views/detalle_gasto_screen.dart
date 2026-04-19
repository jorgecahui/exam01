import 'package:flutter/material.dart';
import '../models/gasto.dart';

class DetalleGastoScreen extends StatelessWidget {
  final Gasto gasto;

  const DetalleGastoScreen({super.key, required this.gasto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${gasto.nombre}'),
            Text('Categoría: ${gasto.categoria}'),
            Text('Monto: S/. ${gasto.monto}'),
            Text(
              'Descripción: ${gasto.descripcion.isEmpty ? "Sin descripción" : gasto.descripcion}',
            ),
            Text('Fecha: ${gasto.fechaRegistro}'),
          ],
        ),
      ),
    );
  }
}