class Solitario {
  final int id;
  final String pesoOro;
  final String pesoPlata;
  final String foto;
  final String talla;
  final String referencia;
  final String tamanoPiedra;
  final String formaPiedra;

  Solitario(
      {required this.pesoOro,
      required this.id,
      required this.foto,
      required this.pesoPlata,
      required this.talla,
      required this.referencia,
      required this.tamanoPiedra,
      required this.formaPiedra});

  factory Solitario.fromJson(Map<String, dynamic> json) {
    return Solitario(
      id: json['id'],
      foto: json['foto'],
      pesoOro: json['pesoOro'],
      tamanoPiedra: json['tamanoPiedra'],
      formaPiedra: json['formaPiedra'],
      talla: json['talla'],
      referencia: json['referencia'],
      pesoPlata: json['pesoPlata'],
    );
  }
}
