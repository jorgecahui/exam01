// screens/registro_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/gastos_viewmodel.dart';
import '../models/gasto.dart';
class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});
  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}
class _RegistroScreenState extends State<RegistroScreen> {
// GlobalKey identifica ESTE Form en el arbol de widgets.
// Permite llamar validate() y save() desde fuera del Form.
  final _formKey = GlobalKey<FormState>();
// Controladores para leer el texto de cada TextField
  final _nombreCtrl = TextEditingController();
  final _montoCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();
// null = no seleccionado aun
  String? _categoriaSeleccionada;
  @override
  void dispose() {
// CRITICO: liberar controladores para evitar memory leaks
    _nombreCtrl.dispose();
    _montoCtrl.dispose();
    _descripcionCtrl.dispose();
    super.dispose();
  }
  void _guardar() {
// validate() ejecuta el validator de CADA campo del Form.
// Retorna true solo si TODOS retornan null (sin error).
    if (!_formKey.currentState!.validate()) return;
    final gasto = Gasto(
      nombre: _nombreCtrl.text.trim(),
      monto: double.parse(_montoCtrl.text.trim()),
      categoria: _categoriaSeleccionada!,
      descripcion: _descripcionCtrl.text.trim(),
// fechaRegistro se genera automaticamente en el constructor
    );
// context.read: obtiene el ViewModel SIN suscribirse a cambios.
// Correcto aqui porque solo llamamos un metodo, no reconstruimos.
    context.read<GastosViewModel>().agregarGasto(gasto);
// Regresar a HomeScreen. El Consumer alli se reconstruye automaticamente.
    Navigator.pop(context);}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nuevo Gasto'),
          backgroundColor: const Color(0xFF23373B),
          foregroundColor: Colors.white,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: _formKey, // conecta este Form con _formKey
                child: ListView(
                  children: [
// Campo: Nombre
                  TextFormField(
                  controller: _nombreCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del gasto',
                    hintText: 'Ej: Almuerzo, Bus, Cine...',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty)
                      return 'El nombre es obligatorio';
                    if (value.trim().length < 3)
                      return 'El nombre debe tener al menos 3 caracteres';
                    return null; // null = valido
                  },
                ),
                const SizedBox(height: 16),
// Campo: Monto
                TextFormField(
                  controller: _montoCtrl,
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Monto (S/.)',
                    prefixText: 'S/. ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty)
                      return 'El monto es obligatorio';
                    final monto = double.tryParse(value.trim());
                    if (monto == null) return 'Ingresa un numero valido';
                    if (monto <= 0) return 'El monto debe ser mayor a 0';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
// Campo: Categoria (Dropdown)
                DropdownButtonFormField<String>(
                    value: _categoriaSeleccionada,
                    decoration: const InputDecoration(
                      labelText: 'Categoria',
                      border: OutlineInputBorder(),
                    ),
                    items: categorias.map((cat) =>
                        DropdownMenuItem(value: cat, child: Text(cat)))
                        .toList(),
                  onChanged: (valor) =>
                      setState(() => _categoriaSeleccionada = valor),
                  validator: (value) =>
                  value == null ? 'Selecciona una categoria' : null,
                ),
                    const SizedBox(height: 16),
// Campo: Descripcion (opcional)
                    TextFormField(
                      controller: _descripcionCtrl,
                      maxLength: 100,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Descripcion (opcional)',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value != null && value.trim().length > 100)
                          return 'Maximo 100 caracteres';
                        return null; // siempre valido si esta vacio
                      },
                    ),
                    const SizedBox(height: 24),
// Boton Guardar
                    ElevatedButton(
                      onPressed: _guardar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEB811B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Guardar Gasto',
                          style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
            ),
        ),
    );
  }
}
