// viewmodels/gastos_viewmodel.dart
import 'package:flutter/foundation.dart'; // ChangeNotifier vive aqui
import '../models/gasto.dart';
// Las categorias son constantes: nunca cambian en esta version
const List<String> categorias = [
  'Alimentacion',
  'Transporte',
  'Entretenimiento',
  'Salud',
  'Otros',
];
class GastosViewModel extends ChangeNotifier {
// Lista privada: nadie fuera del ViewModel puede modificarla directamente
  final List<Gasto> _gastos = [];
// Getter que expone una copia inmutable de la lista
// List.unmodifiable previene modificaciones accidentales desde la UI
  List<Gasto> get gastos => List.unmodifiable(_gastos);
// Total general: suma de todos los montos con fold()
// fold() recorre la lista acumulando un valor (como reduce en JS)
  double get totalGeneral =>
      _gastos.fold(0.0, (suma, g) => suma + g.monto);
// Total por categoria: filtra con where() y suma con fold()
  double totalPorCategoria(String categoria) {
    return _gastos
        .where((g) => g.categoria == categoria) // filtra
        .fold(0.0, (suma, g) => suma + g.monto); // suma
  }
// Agrega un gasto y NOTIFICA a todos los widgets suscritos
  void agregarGasto(Gasto gasto) {
    _gastos.add(gasto);
    notifyListeners(); // SIN esto la UI no se actualiza
  }
// Propiedad conveniente para detectar lista vacia
  bool get estaVacia => _gastos.isEmpty;
}