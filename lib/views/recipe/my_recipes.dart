import 'package:flutter/material.dart';
import 'package:tutachef_project/views/favorites/widgets/card_recipe.dart';
import 'package:tutachef_project/views/recipe/recipe_model.dart';

import '../../controllers/home_controller.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../core/widgets/custom_drawer.dart';
import '../../mock/receitas.dart';
import '../recipe/show_recipe.dart';

class MyRecipesView extends StatefulWidget {
  MyRecipesView({Key? key, required this.controller}) : super(key: key);
  HomeController controller;

  @override
  State<MyRecipesView> createState() => _MyRecipesViewState();
}

class _MyRecipesViewState extends State<MyRecipesView> {
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
      appBar: CustomAppBarWidget(controller: widget.controller),
      endDrawer: CustomDrawer(
        controller: widget.controller,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          // Ação do botão
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: Colors.orange[700]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              'Minhas Receitas',
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
                      title: receita.tituloReceita!,
                      ingredientes: receita.ingredientes!,
                      modoPreparo: receita.modoPreparo!,
                      sugestaoChef: receita.sugestaoChef!,
                      src: receita.foto!,
                      controller: widget.controller,
                    ),
                  ),
                ),
                child: CardRecipe(
                  tituloReceita: receita.tituloReceita!,
                  ingredientes: receita.ingredientes!,
                  chef: receita.chef!,
                  sugestaoChef: receita.sugestaoChef!,
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
