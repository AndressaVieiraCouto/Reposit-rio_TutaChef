import 'package:flutter/material.dart';
import 'package:tutachef_project/views/favorites/widgets/card_recipe.dart';
import 'package:tutachef_project/views/recipe/recipe_model.dart';

import '../../controllers/home_controller.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../core/widgets/custom_drawer.dart';
import '../../mock/receitas.dart';
import '../recipe/show_recipe.dart';

class FavoritesView extends StatefulWidget {
  FavoritesView({Key? key, required this.controller, this.viaDrawer = false})
      : super(key: key);
  final HomeController controller;
  bool viaDrawer;

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  String filter = "";
  List<Receita> receitas = [];

  @override
  void initState() {
    super.initState();
    receitas = mockReceitas().map((data) => Receita.fromMap(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Filtra as receitas favoritas
    final receitasFavoritas =
        receitas.where((element) => element.favorite == true).toList();

    return Scaffold(
      appBar: !widget.viaDrawer
          ? null
          : CustomAppBarWidget(controller: widget.controller),
      endDrawer: !widget.viaDrawer
          ? null
          : CustomDrawer(
              controller: widget.controller,
            ),
      backgroundColor: !widget.viaDrawer ? null : Colors.white,
      floatingActionButton: !widget.viaDrawer
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                // Ação do botão
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: Colors.orange[700]),
            ),
      floatingActionButtonLocation: !widget.viaDrawer
          ? null
          : FloatingActionButtonLocation.miniStartFloat,
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              'Receitas Favoritas',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          ),
          ListView.builder(
            shrinkWrap: true, // Use shrinkWrap to allow nested ListView
            itemCount: receitasFavoritas.length,
            itemBuilder: (context, index) {
              final receita = receitasFavoritas[index];
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ShowRecipe(
                      controller: widget.controller,
                      title: receita.tituloReceita!,
                      ingredientes: receita.ingredientes!,
                      modoPreparo: receita.modoPreparo!,
                      sugestaoChef: receita.sugestaoChef!,
                      src: receita.foto!,
                    ),
                  ),
                ),
                child: CardRecipe(
                  tituloReceita: receita.tituloReceita!,
                  ingredientes: receita.ingredientes!,
                  chef: receita.chef!,
                  sugestaoChef: receita.sugestaoChef!.toString(),
                  colorStar: Colors.amber, // Sempre definido como favorito
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
