import 'package:flutter/material.dart';
import 'package:tutachef_project/core/app_core.dart';
import 'package:tutachef_project/core/widgets/custom_button.dart';
import 'package:tutachef_project/views/categories/card_categorie.dart';

import '../../../controllers/home_controller.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_drawer.dart';
import '../../../core/widgets/custom_textField.dart';

class MedidasView extends StatelessWidget {
  const MedidasView({Key? key, required this.controller}) : super(key: key);
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
              'Cadastrar Medidas',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text(
              'Medidas cadastradas',
              style: TextStyle(color: Colors.grey),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: AppCore.unidades.length,
                itemBuilder: (context, index) {
                  return CardCategorie(
                    categorie: AppCore.unidades[index],
                    type: AppCore.unidades[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: CustomButton(
                textButton: 'Cadastrar Medida',
                function: () {
                  _cadastrarMedida(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _cadastrarMedida(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cadastrar Medida'),
          content: CustomTextField(
            hint: 'Informe a medida...',
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                AppCore().successDialog(
                    context, 'Unidade de medida cadastrada com sucesso');
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
