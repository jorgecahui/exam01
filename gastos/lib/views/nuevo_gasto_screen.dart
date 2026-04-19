import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/gastos_viewmodel.dart';
import '../models/gasto.dart';

class NuevoGastoScreen extends StatefulWidget {
  const NuevoGastoScreen({super.key});

  @override
  State<NuevoGastoScreen> createState() => _NuevoGastoScreenState();
}

class _NuevoGastoScreenState extends State<NuevoGastoScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nombreCtrl = TextEditingController();
  final _montoCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();

  String? _categoria;

  final categorias = [
    'Alimentacion',
    'Transporte',
    'Entretenimiento',
    'Salud',
    'Otros'
  ];

  void _guardar() {
    if (!_formKey.currentState!.validate()) return;

    final gasto = Gasto(
      nombre: _nombreCtrl.text,
      monto: double.parse(_montoCtrl.text),
      categoria: _categoria!,
      descripcion: _descripcionCtrl.text,
    );

    context.read<GastosViewModel>().agregarGasto(gasto);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Gasto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) =>
                v == null || v.length < 3 ? 'Min 3 caracteres' : null,
              ),
              TextFormField(
                controller: _montoCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Monto'),
                validator: (v) {
                  final n = double.tryParse(v ?? '');
                  if (n == null || n <= 0) return 'Monto inválido';
                  return null;
                },
              ),
              DropdownButtonFormField(
                value: _categoria,
                items: categorias
                    .map((c) =>
                    DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _categoria = v),
                validator: (v) =>
                v == null ? 'Seleccione categoría' : null,
              ),
              TextFormField(
                controller: _descripcionCtrl,
                decoration:
                const InputDecoration(labelText: 'Descripción'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardar,
                child: const Text('Guardar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}