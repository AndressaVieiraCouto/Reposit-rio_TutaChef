import 'package:flutter/material.dart';
import 'package:tutachef_project/controllers/home_controller.dart';
import 'package:tutachef_project/core/widgets/custom_textField.dart';
import 'package:tutachef_project/views/recipe/recipe_model.dart';
import 'package:tutachef_project/views/recipe/show_recipe.dart';

import '../../core/widgets/custom_appbar.dart';
import '../../core/widgets/custom_drawer.dart';
import '../../mock/receitas.dart';
import 'card_manage_recipe.dart';

class ManageRecipes extends StatefulWidget {
  ManageRecipes({Key? key, required this.controller}) : super(key: key);
  HomeController controller;

  @override
  _ManageRecipesState createState() => _ManageRecipesState();
}

class _ManageRecipesState extends State<ManageRecipes> {
  String filter = "";
  List<Receita> receitas = [];

  @override
  void initState() {
    super.initState();
    receitas = mockReceitas().map((data) => Receita.fromMap(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Receita> filteredRecipes = receitas
        .where((receita) =>
            receita.tituloReceita!.toLowerCase().contains(filter.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: CustomAppBarWidget(controller: widget.controller),
      endDrawer: CustomDrawer(
        controller: widget.controller,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          // Ação do botão
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back, color: Colors.orange[700]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Seja bem-vindo!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          //const Center(child: CustomDropDownButton()),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250,
                height: 60,
                child: CustomTextField(
                  hint: 'Pesquisar...',
                  function: (text) {
                    setState(
                      () {
                        filter = text;
                      },
                    );
                  },
                ),
              ),
              const Icon(
                Icons.search,
                size: 30,
                color: Colors.orange,
              )
            ],
          ),
          const Text(
            'Últimas Receitas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                final receita = filteredRecipes[index];
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
                  child: CardManageRecipe(
                    tituloReceita: receita.tituloReceita!,
                    ingredientes: receita.ingredientes!,
                    chef: receita.chef!,
                    sugestaoChef: receita.sugestaoChef!.toString(),
                    colorStar: receita.favorite! ? Colors.amber : Colors.black,
                    controller: widget.controller,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
