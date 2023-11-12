import 'package:flutter/material.dart';
import 'package:tutachef_project/core/app_core.dart';
import 'package:tutachef_project/core/widgets/custom_button.dart';
import 'package:tutachef_project/views/categories/card_categorie.dart';

import '../../controllers/home_controller.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../core/widgets/custom_drawer.dart';
import '../../core/widgets/custom_textField.dart';

class IngredientsCadastradosView extends StatelessWidget {
  const IngredientsCadastradosView({Key? key, required this.controller})
      : super(key: key);
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
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back, color: Colors.orange[700]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Cadastrar Ingrediente',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ingredientes cadastrados',
              style: TextStyle(color: Colors.grey),
            ),
            CustomTextField(
              hint: 'Pesquisar...',
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: AppCore.ingredientesMock.length,
                  itemBuilder: (context, index) {
                    return CardCategorie(
                        categorie: AppCore.ingredientesMock[index],
                        type: AppCore.ingredientesMock[index]);
                  }),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: CustomButton(
                textButton: 'Cadastrar Ingrediente',
                function: () {
                  _showOptionsDialog(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cadastrar Ingrediente'),
          content: CustomTextField(
            hint: 'Informe o ingrediente...',
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                AppCore().successDialog(
                  context,
                  'Ingrediente adicionado com sucesso!',
                );
              },
              child: const Text(
                'Adicionar',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}
