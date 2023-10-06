class Dije {
  final int id;
  final String alto;
  final String ancho;
  final String foto;
  final String pesoOro;
  final String pesoPlata;
  final String referencia;
  final String categoria;

  Dije(
      {required this.alto,
      required this.id,
      required this.foto,
      required this.pesoOro,
      required this.pesoPlata,
      required this.ancho,
      required this.referencia,
      required this.categoria});

  factory Dije.fromJson(Map<String, dynamic> json) {
    return Dije(
      id: json['id'],
      foto: json['foto'],
      ancho: json['ancho'],
      pesoOro: json['pesoOro'],
      pesoPlata: json['pesoPlata'],
      alto: json['alto'],
      referencia: json['referencia'],
      categoria: json['categoria'],
    );
  }
}
