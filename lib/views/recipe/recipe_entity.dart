class Receita {
  final String tituloReceita;
  final List<String> ingredientes;
  final String modoPreparo;
  final String sugestaoChef;
  final String chef;
  final String foto;
  final bool favorite;

  Receita(
      {required this.tituloReceita,
      required this.ingredientes,
      required this.modoPreparo,
      required this.sugestaoChef,
      required this.chef,
      required this.foto,
      required this.favorite});

  Map<String, dynamic> toMap() {
    return {
      "tituloReceita": tituloReceita,
      "ingredientes": ingredientes,
      "modoPreparo": modoPreparo,
      "sugestaoChef": sugestaoChef,
      "chef": chef,
      "foto": foto,
      "favorite": favorite
    };
  }
}
