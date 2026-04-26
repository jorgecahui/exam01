class Gasto {
  final String nombre; // Nombre descriptivo (ej: "Almuerzo")
  final double monto; // Monto en soles, siempre > 0
  final String categoria; // Una de las 5 categorias predefinidas
  final String descripcion; // Opcional — puede ser cadena vacia
  final DateTime fechaRegistro; // Generada automaticamente al crear el objeto
  Gasto({
    required this.nombre,
    required this.monto,
    required this.categoria,
    this.descripcion = '', // Valor por defecto: vacio
    DateTime? fechaRegistro, // Si no se pasa, se usa DateTime.now()
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();
// ↑ Initializer list: se ejecuta ANTES del cuerpo del constructor.
// El operador ?? significa: "si es null, usar el valor de la derecha".
// Es la unica forma de inicializar un campo final con logica condicional.
}