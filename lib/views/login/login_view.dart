import 'package:flutter/material.dart';
import 'package:tutachef_project/controllers/home_controller.dart';
import 'package:tutachef_project/core/app_core.dart';
import 'package:tutachef_project/core/widgets/custom_button.dart';
import 'package:tutachef_project/core/widgets/custom_textField.dart';
import 'package:tutachef_project/views/signup/signup_view.dart';

import '../pages_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: heightScreen,
        width: widthScreen,
        decoration:
            const BoxDecoration(gradient: AppCore.defaultOrangeGradient),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: heightScreen * 0.1,
              ),
              SizedBox(
                height: heightScreen * 0.35,
                child: Container(
                    color: Colors.transparent,
                    child: Image.asset('assets/logo/logo-g.png')),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: 'E-mail',
              ),
              CustomTextField(
                hint: 'Senha',
                obscure: true,
              ),
              TextButton(
                onPressed: () {
                  _mostrarRecuperacaoSenhaDialog(context);
                },
                child: const Text(
                  'Esqueci minha senha!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              CustomButton(
                textButton: 'Login',
                function: () {
                  successDialog(context,
                      'Seja bem vindo, chef! Você entrou na sua cozinha!');
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignUpView(
                            controller: controller,
                          )));
                },
                child: const Text(
                  'Cadastre-se aqui!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Text(
                '- Ou -',
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Card(
                    elevation: 10,
                    child: GestureDetector(
                      child: Image.asset('assets/icons/google.png'),
                      onTap: () {
                        print('Login com Google');
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
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
                    builder: (_) => PagesView(
                          controller: controller,
                          //     controller: HomeController(),
                        )));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarRecuperacaoSenhaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Recuperar Senha'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                  'Insira seu endereço de e-mail para recuperar a senha:'),
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Recuperar'),
            ),
          ],
        );
      },
    );
  }
}
