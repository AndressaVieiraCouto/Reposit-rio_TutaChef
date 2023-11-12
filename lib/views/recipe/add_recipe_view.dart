import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tutachef_project/core/app_core.dart';
import 'package:tutachef_project/core/widgets/custom_button.dart';
import 'package:tutachef_project/core/widgets/custom_textField.dart';
import 'package:tutachef_project/views/ingredients/ingredients_view.dart';
import 'package:tutachef_project/views/recipe/recipe_model.dart';

import '../../controllers/home_controller.dart';

class AddRecipeView extends StatefulWidget {
  AddRecipeView({super.key, this.editRecipe = false});
  bool editRecipe;

  @override
  State<AddRecipeView> createState() => _AddRecipeViewState();
}

class _AddRecipeViewState extends State<AddRecipeView> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<HomeController>(context);
    TextEditingController titulo = TextEditingController();
    TextEditingController modopreparo = TextEditingController();
    TextEditingController sugestao = TextEditingController();

    void _showImagePickerDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Escolha uma fonte de imagem"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text("Galeria"),
                  onTap: () {
                    Navigator.pop(context);
                    controller.getImageFromGallery();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text("Câmera"),
                  onTap: () {
                    Navigator.pop(context);
                    controller.getImageFromCamera();
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              !widget.editRecipe
                  ? const Text(
                      'Cadastrar Receita',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    )
                  : const SizedBox(),
              Observer(
                builder: (_) {
                  return Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.orangeAccent[200],
                        maxRadius: 50,
                        child: controller.image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  height: 100,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(48)),
                                  child: Image.file(controller.image!,
                                      fit: BoxFit.cover),
                                ),
                              )
                            : const Icon(
                                Icons.fastfood_outlined,
                                size: 50,
                              ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () => _showImagePickerDialog(),
                          child: Icon(
                            Icons.camera_alt,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.fromBorderSide(
                        BorderSide(width: 1, color: Colors.orange))),
                height: 40,
                width: 300,
                child: Center(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    isDense: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    underline:
                        const DropdownButtonHideUnderline(child: SizedBox()),
                    value: selectedCategory,
                    items: AppCore.categoriasMock
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                    hint: const Text('Categoria'),
                  ),
                ),
              ),
              CustomTextField(
                hint: 'Título',
                controller: titulo,
              ),
              SizedBox(
                width: 400,
                child: CustomButton(
                    textButton: 'Adicionar Ingrediente',
                    function: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => IngredientsView(
                                  controller: controller,
                                )))),
              ),
              CustomTextField(
                hint: 'Modo de Preparo',
                controller: modopreparo,
              ),
              CustomTextField(
                hint: 'Sugestão do Chef',
                controller: sugestao,
              ),
              !widget.editRecipe
                  ? CustomButton(
                      textButton: 'Enviar',
                      function: () {
                        // Criar uma instância de Receita com os dados fornecidos
                        Receita novaReceita = Receita(
                          tituloReceita: titulo.text,
                          ingredientes: controller.formatIngredientMap(),
                          modoPreparo: modopreparo.text,
                          sugestaoChef: sugestao.text,
                          foto: controller.imagePath ??
                              'assets/images/lasanha.jpg',
                          favorite:
                              false, // ou true se desejar definir como favorito inicialmente
                        );
                        // Adicionar a nova receita à lista usando o HomeController
                        controller.addRecipe(novaReceita);
                        controller.ingredientMap.clear();
                        setState(() {
                          titulo.clear();
                          modopreparo.clear();
                          sugestao.clear();
                        });
                        controller.image = null;

                        // Exibir o diálogo de sucesso
                        AppCore().successDialog(
                            context, 'Receita cadastrada com sucesso!');
                      },
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
