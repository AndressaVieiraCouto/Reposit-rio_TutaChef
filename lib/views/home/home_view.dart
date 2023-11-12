import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutachef_project/core/widgets/custom_textField.dart';
import 'package:tutachef_project/mock/receitas.dart';
import 'package:tutachef_project/views/favorites/widgets/card_recipe.dart';
import 'package:tutachef_project/views/recipe/recipe_model.dart';
import 'package:tutachef_project/views/recipe/show_recipe.dart';

import '../../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String filter = "";
  // List<Receita> receitas = [];

  @override
  void initState() {
    super.initState();
    var controller = Provider.of<HomeController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<HomeController>(context);

    List<Receita> filteredRecipes = controller.receitas
        .where((receita) =>
            receita.tituloReceita!.toLowerCase().contains(filter.toLowerCase()))
        .toList();

    return Column(
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
                      controller: controller,
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
                  chef: receita.chef ?? 'Glauco',
                  sugestaoChef: receita.sugestaoChef!.toString(),
                  colorStar: receita.favorite! ? Colors.amber : Colors.black,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
