import 'package:flutter/material.dart';
import 'package:tutachef_project/views/ingredients/widgets/card_ingredients_indicados.dart';

import '../../controllers/home_controller.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../core/widgets/custom_drawer.dart';
import '../../core/widgets/custom_textField.dart';

class IngredientsIndicadosView extends StatelessWidget {
  const IngredientsIndicadosView({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(controller: controller),
      endDrawer: CustomDrawer(
        controller: controller,
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Ingrediente Indicados',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Ingredientes indicados',
                  style: TextStyle(color: Colors.grey),
                ),
                CustomTextField(
                  hint: 'Pesquisar...',
                ),
                CardIngredienteIndicado(
                  categorie: 'Ingrediente 01',
                  type: 'Ingrediente',
                ),
                CardIngredienteIndicado(
                    categorie: 'Ingrediente 02', type: 'Ingrediente'),
                CardIngredienteIndicado(
                    categorie: 'Ingrediente 03', type: 'Ingrediente'),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
