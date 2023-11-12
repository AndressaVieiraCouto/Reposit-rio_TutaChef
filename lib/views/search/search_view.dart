import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../../controllers/home_controller.dart';
import '../../core/app_core.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../core/widgets/custom_drawer.dart';
import '../favorites/widgets/card_recipe.dart';
import '../recipe/show_recipe.dart';
// Importe o widget CardRecipeSearch aqui

class SearchView extends StatefulWidget {
  const SearchView({Key? key, this.viaDrawer = false}) : super(key: key);

  final bool viaDrawer;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  void initState() {
    super.initState();
    var controller = Provider.of<HomeController>(context, listen: false);
  }

  final TextEditingController _ingredientsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<HomeController>(context);
    List<String> suggestionsIngredients = AppCore.ingredientesMock;

    return Scaffold(
      appBar:
          !widget.viaDrawer ? null : CustomAppBarWidget(controller: controller),
      endDrawer:
          !widget.viaDrawer ? null : CustomDrawer(controller: controller),
      backgroundColor: widget.viaDrawer ? null : Colors.white,
      floatingActionButton: !widget.viaDrawer
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: Colors.orange[700]),
            ),
      floatingActionButtonLocation: !widget.viaDrawer
          ? null
          : FloatingActionButtonLocation.miniStartFloat,
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Pesquisa Refinada',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 30),
          Observer(
            builder: (_) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          controller.isStrictMode ? Colors.white : Colors.black,
                      backgroundColor: controller.isStrictMode
                          ? Colors.orange
                          : Colors.white,
                    ),
                    onPressed: () {
                      controller.setStrictMode();
                      print(controller.isStrictMode);
                    },
                    child: Text('Restrita',
                        style: TextStyle(
                            color: controller.isStrictMode
                                ? Colors.white
                                : Colors.orange)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: !controller.isStrictMode
                          ? Colors.white
                          : Colors.black,
                      backgroundColor: !controller.isStrictMode
                          ? Colors.orange
                          : Colors.white,
                    ),
                    onPressed: () {
                      controller.setFlexibleMode();
                      print(controller.isStrictMode);
                    },
                    child: Text('Flexível',
                        style: TextStyle(
                            color: !controller.isStrictMode
                                ? Colors.white
                                : Colors.orange)),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          Observer(
            builder: (_) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _ingredientsController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      suggestionsCallback: (pattern) async {
                        return suggestionsIngredients.where((ingredient) =>
                            ingredient
                                .toLowerCase()
                                .contains(pattern.toLowerCase()));
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        _ingredientsController.text = suggestion;
                        controller.addIngredientsToList(suggestion);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Ingredientes Selecionados:'),
                  ...List.generate(
                    controller.listSelectedIngredients.length,
                    (index) => Text(
                      controller.listSelectedIngredients[index],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Receitas Encontradas:'),
                  ListView.builder(
                    shrinkWrap: true, // Use shrinkWrap to allow nested ListView
                    itemCount: controller.receitasFiltradasBusca().length,
                    itemBuilder: (context, index) {
                      final receita =
                          controller.receitasFiltradasBusca()[index];
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
                          chef: receita.chef!,
                          sugestaoChef: receita.sugestaoChef!.toString(),
                          colorStar:
                              Colors.amber, // Sempre definido como favorito
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
