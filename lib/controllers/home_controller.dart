import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

import '../views/recipe/recipe_model.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store, ChangeNotifier {
  @observable
  int indexHome = 0;

  @action
  void selectIndex(value) => indexHome = value;

  @observable
  ObservableMap ingredientMap = ObservableMap<String, dynamic>();

  @observable
  ObservableList<Receita> receitas = ObservableList<Receita>();

  @action
  void addRecipe(Receita receita) {
    receitas.add(receita);
  }

  @observable
  ObservableList<String> listSelectedIngredients = ObservableList<String>();

  @action
  void addIngredientsToList(String ingredients) =>
      listSelectedIngredients.add(ingredients);
  @action
  void addIngredientMap({
    required String medida,
    required String ingrediente,
    required String quantidade,
  }) {
    if (ingrediente.isNotEmpty && medida.isNotEmpty && quantidade.isNotEmpty) {
      runInAction(() {
        // Verifica se o ingrediente já existe no mapa
        if (ingredientMap.containsKey(ingrediente)) {
          // Atualiza a quantidade e a medida se o ingrediente já existir
          ingredientMap[ingrediente] = {
            'quantidade': double.parse(quantidade),
            'unidadeMedida': medida,
          };
        } else {
          // Adiciona um novo ingrediente ao mapa
          ingredientMap[ingrediente] = {
            'quantidade': double.parse(quantidade),
            'unidadeMedida': medida,
          };
        }
      });
    }
  }

  List<String> formatIngredientMap() {
    List<String> formattedIngredients = [];

    ingredientMap.forEach((ingrediente, values) {
      double quantidade = values['quantidade'];
      String medida = values['unidadeMedida'];

      String formattedIngredient = '$quantidade $medida de $ingrediente';
      formattedIngredients.add(formattedIngredient);
    });

    return formattedIngredients;
  }

  @observable
  String? imagePath;

  @observable
  File? image;

  @action
  Future getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagePath = pickedFile.path;
    }
  }

  @action
  Future getImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagePath = pickedFile.path;
    }
  }

  @observable
  bool isStrictMode = true;

  @action
  void setStrictMode() {
    if (!isStrictMode) {
      isStrictMode = true;
      listSelectedIngredients
          .clear(); // Limpa os ingredientes ao trocar para o modo restrito
    }
  }

  @action
  void setFlexibleMode() {
    if (isStrictMode) {
      isStrictMode = false;
    }
  }

  // // Adicione a função para obter as receitas filtradas
  // void getFilteredRecipes() {
  //   if (isStrictMode) {
  //     return receitasFiltradas.addAll(receitas
  //         .where((element) =>
  //             element.ingredientes!.contains(listSelectedIngredients))
  //         .toList());
  //   } else {
  //     return receitasFiltradas.addAll(receitas
  //         .where((element) =>
  //             element.ingredientes!.contains(listSelectedIngredients))
  //         .toList());
  //     // return receitas
  //     //     .where((recipe) => listSelectedIngredients.any((selectedIngredient) =>
  //     //         recipe.ingredientes!.contains(selectedIngredient)))
  //     //     .toList();
  //   }
  // }

  @observable
  List<Receita> receitasFiltradasBusca() {
    return receitas
        .where((receita) => listSelectedIngredients.any((selectedIngredient) =>
            receita.ingredientes!.contains(selectedIngredient)))
        .toList();
  }
}
