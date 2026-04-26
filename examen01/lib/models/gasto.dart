// models/gasto.dart
class Gasto {
  final String nombre;
  final double monto;
  final String categoria;
  final String descripcion;
  final DateTime fechaRegistro;
  Gasto({
    required this.nombre,
    required this.monto,
    required this.categoria,
    this.descripcion = '',
    DateTime? fechaRegistro,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();
  // Convierte este objeto a un Map<String, dynamic>.
  // El Map luego se convierte a String JSON para guardarse
  // en SharedPreferences. Cada campo del objeto se convierte
  // a un tipo primitivo que JSON entiende.
  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'monto': monto,
    'categoria': categoria,
    'descripcion': descripcion,
    // DateTime no es un tipo JSON valido, lo convertimos
    // a String en formato ISO 8601: "2026-04-12T14:30:00.000"
    // Este formato es estandar internacional y DateTime.parse()
    // puede convertirlo de vuelta sin perder informacion.
    'fecha': fechaRegistro.toIso8601String(),
  };
  // Constructor alternativo que crea un Gasto desde un Map.
  // Se llama "factory" porque no siempre crea una nueva instancia
  // (podria devolver una cacheada), aunque aqui siempre crea una nueva.
  // Se usa al leer de SharedPreferences: JSON → Map → Gasto.
  factory Gasto.fromJson(Map<String, dynamic> json) {
    return Gasto(
        nombre: json['nombre'] as String,
        monto: json['monto'] as double,
        categoria: json['categoria'] as String,
        descripcion: json['descripcion'] as String,
        // Convertimos el String ISO 8601 de vuelta a DateTime.
        fechaRegistro: DateTime.parse(json['fecha'] as String),

    );
  }
}
