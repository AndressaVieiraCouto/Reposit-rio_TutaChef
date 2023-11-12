import 'dart:convert';

RecipeModel recipeModelFromMap(String str) =>
    RecipeModel.fromMap(json.decode(str));

String recipeModelToMap(RecipeModel data) => json.encode(data.toMap());

class RecipeModel {
  List<Receita>? receitas;

  RecipeModel({
    this.receitas,
  });

  factory RecipeModel.fromMap(Map<String, dynamic> json) => RecipeModel(
        receitas: json["receitas"] == null
            ? []
            : List<Receita>.from(
                json["receitas"]!.map((x) => Receita.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "receitas": receitas == null
            ? []
            : List<dynamic>.from(receitas!.map((x) => x.toMap())),
      };
}

class Receita {
  String? tituloReceita;
  List<String>? ingredientes;
  String? modoPreparo;
  String? sugestaoChef;
  String? chef;
  String? foto;
  bool? favorite;

  Receita(
      {this.tituloReceita,
      this.ingredientes,
      this.modoPreparo,
      this.sugestaoChef,
      this.chef,
      this.foto,
      this.favorite});

  factory Receita.fromMap(Map<String, dynamic> json) {
    return Receita(
        tituloReceita: json["tituloReceita"],
        ingredientes: json["ingredientes"] == null
            ? []
            : List<String>.from(json["ingredientes"].map((x) => x)),
        modoPreparo: json["modoPreparo"],
        sugestaoChef: json['sugestaoChef'],
        chef: json["chef"],
        foto: json["foto"],
        favorite: json["favorite"]);
  }

  Map<String, dynamic> toMap() => {
        "tituloReceita": tituloReceita,
        "ingredientes": ingredientes == null
            ? []
            : List<dynamic>.from(ingredientes!.map((x) => x)),
        "modoPreparo": modoPreparo,
        "sugesstaoChef": sugestaoChef,
        "chef": chef,
        "foto": foto,
        "favorite": favorite
      };
}
