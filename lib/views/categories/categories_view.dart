import 'package:flutter/material.dart';
import 'package:tutachef_project/core/app_core.dart';
import 'package:tutachef_project/core/widgets/custom_button.dart';
import 'package:tutachef_project/views/categories/card_categorie.dart';

import '../../controllers/home_controller.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../core/widgets/custom_drawer.dart';
import '../../core/widgets/custom_textField.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(controller: controller),
      endDrawer: CustomDrawer(controller: controller),
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
              'Cadastrar Categorias',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text(
              'Categoria cadastradas',
              style: TextStyle(color: Colors.grey),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: AppCore.categoriasMock.length,
                itemBuilder: (context, index) {
                  return CardCategorie(
                    categorie: AppCore.categoriasMock[index],
                    type: AppCore.categoriasMock[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: CustomButton(
                textButton: 'Cadastrar Categoria',
                function: () {
                  _cadastrarCategoria(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _cadastrarCategoria(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cadastrar Categoria'),
          content: CustomTextField(
            hint: 'Informe a categoria...',
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                AppCore()
                    .successDialog(context, 'Categoria cadastrada com sucesso');
              },
              child: const Text(
                'Cadastrar',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}
