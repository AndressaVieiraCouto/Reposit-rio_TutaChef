import 'package:flutter/material.dart';
import 'package:tutachef_project/core/app_core.dart';
import 'package:tutachef_project/core/widgets/custom_button.dart';
import 'package:tutachef_project/views/login/login_view.dart';

import '../../controllers/home_controller.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../core/widgets/custom_drawer.dart';
import '../../core/widgets/custom_textField.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        controller: controller,
      ),
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: Image.asset(
                          'assets/images/profile.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Text(
                      'Glauco Martins',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      'Nome: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      'Glauco Martins',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      'E-Mail: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      'user@tutachef.com',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      'Telefone: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      '15-995995959',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  width: 200,
                  child: CustomButton(
                      textButton: 'Alterar Cadastro',
                      function: () {
                        _showOptionsDialog(context);
                      }),
                ),
                SizedBox(
                  width: 200,
                  child: CustomButton(
                      textButton: 'Excluir Cadastro',
                      styleText: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      function: () {
                        _excluirCadastro(context);
                      }),
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginView(controller: controller)));
                      },
                      child: const Text(
                        'Sair',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _excluirCadastro(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Excluir Cadastro'),
            content: const Text('Tem certeza que deseja excluir seu cadastro?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    AppCore().successDialog(
                        context, 'Cadastro Excluído com sucesso!');
                  },
                  child: const Text(
                    'Excluir',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ))
            ],
          );
        });
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alterar Cadastro'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                hint: 'Nome completo...',
                obscure: true,
              ),
              CustomTextField(
                hint: 'Telefone...',
                obscure: true,
              ),
              CustomTextField(
                hint: 'Senha atual...',
                obscure: true,
              ),
              CustomTextField(
                hint: 'Nova senha...',
                obscure: true,
              ),
              CustomTextField(
                hint: 'Confirmar nova senha...',
                obscure: true,
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                AppCore()
                    .successDialog(context, 'Cadastro alterado com sucesso!');
              },
              child: const Text(
                'Alterar',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}
