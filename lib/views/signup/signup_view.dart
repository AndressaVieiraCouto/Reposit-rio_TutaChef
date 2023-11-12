import 'package:flutter/material.dart';
import 'package:tutachef_project/core/widgets/custom_button.dart';
import 'package:tutachef_project/core/widgets/custom_textField.dart';

import '../../controllers/home_controller.dart';
import '../../core/widgets/custom_appbar.dart';
import '../pages_view.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        controller: controller,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Realize seu Cadastro',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              hint: 'Nome Completo...',
            ),
            CustomTextField(
              hint: 'E-mail...',
            ),
            CustomTextField(
              hint: 'Senha...',
              obscure: true,
            ),
            CustomTextField(
              hint: 'Confirme sua senha...',
              obscure: true,
            ),
            CustomTextField(
              hint: 'Telefone...',
            ),
            CustomButton(
                textButton: 'Confirmar',
                function: () => successDialog(
                      context,
                      'Cadastro realizado com sucesso! \n Agora você é um Hobby Chef',
                    ))
          ],
        ),
      ),
    );
  }

  void successDialog(BuildContext context, String textSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sucesso'),
          content: Text(textSuccess),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PagesView(
                          controller: controller,
                          // controller: HomeController(),
                        )));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
