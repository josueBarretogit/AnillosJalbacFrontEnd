class Dije {
  final int id;
  final String alto;
  final String ancho;
  final Map<String, dynamic> foto;
  final List<dynamic>? pesos;
  final String referencia;
  final String categoria;

  Dije(
      {required this.alto,
      required this.id,
      required this.foto,
      required this.pesos,
      required this.ancho,
      required this.referencia,
      required this.categoria});

  factory Dije.fromJson(Map<String, dynamic> json) {
    return Dije(
      id: json['id'],
      foto: json['foto'],
      ancho: json['ancho'],
      pesos: json['pesos'],
      alto: json['alto'],
      referencia: json['referencia'],
      categoria: json['categoria'],
    );
  }
}
