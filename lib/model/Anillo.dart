class Anillo {
  final String nombre;
  final String peso;
  final String talla;
  final String referencia;
  final String categoria;

  Anillo(
      {required this.nombre,
      required this.peso,
      required this.talla,
      required this.referencia,
      required this.categoria});

  factory Anillo.fromJson(Map<String, dynamic> json) {
    return Anillo(
      nombre: json['nombre'],
      peso: json['peso'],
      talla: json['talla'],
      referencia: json['refrencia'],
      categoria: json['categoria'],
    );
  }
}
