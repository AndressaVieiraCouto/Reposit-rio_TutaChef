import 'package:flutter/material.dart';
import 'package:tutachef_project/core/app_core.dart';

class CardReport extends StatelessWidget {
  const CardReport({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showOptionsDialog(context);
      },
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Card(
          color: Colors.grey[200],
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Receita:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Lasanha Bolonhesa'),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Usuário:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Glauco'),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Data:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('01/11/2023'),
                      ],
                    ),
                  ],
                ),
                Icon(
                  Icons.announcement_rounded,
                  color: Colors.red,
                  size: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Título da Receita'),
          content: const Text('Conteúdo da Denúncia...'),
          actions: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextButton(
                onPressed: () {
                  // Coloque aqui a ação de "acatar"
                  Navigator.of(context).pop();
                  AppCore().successDialog(
                      context, 'Validação realizada com sucesso!');
                },
                child: const Text(
                  'Validar',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Coloque aqui a ação de "recusar"
                  Navigator.of(context).pop();
                  AppCore()
                      .successDialog(context, 'Denúncia recusada com sucesso!');
                },
                child: const Text(
                  'Recusar',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ]),
          ],
        );
      },
    );
  }
}
