class Anillo {
  final int id;
  final String nombre;
  final Map<String, dynamic> foto;
  final List<dynamic>? pesos;
  final String talla;
  final String referencia;
  final String categoria;

  Anillo(
      {required this.nombre,
      required this.id,
      required this.foto,
      required this.pesos,
      required this.talla,
      required this.referencia,
      required this.categoria});

  factory Anillo.fromJson(Map<String, dynamic> json) {
    return Anillo(
      id: json['id'],
      foto: json['foto'],
      nombre: json['nombre'],
      pesos: json['pesos'],
      talla: json['talla'],
      referencia: json['referencia'],
      categoria: json['categoria'],
    );
  }
}
