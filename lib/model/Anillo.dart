class Anillo {
  final int id;
  final String nombre;
  final String foto;
  final String pesoOro;
  final String pesoPlata;
  final String talla;
  final String referencia;
  final String categoria;

  Anillo(
      {required this.nombre,
      required this.id,
      required this.foto,
      required this.pesoOro,
      required this.pesoPlata,
      required this.talla,
      required this.referencia,
      required this.categoria});

  factory Anillo.fromJson(Map<String, dynamic> json) {
    return Anillo(
      id: json['id'],
      foto: json['foto'],
      nombre: json['nombre'],
      pesoOro: json['pesoOro'],
      pesoPlata: json['pesoPlata'],
      talla: json['talla'],
      referencia: json['referencia'],
      categoria: json['categoria'],
    );
  }
}
