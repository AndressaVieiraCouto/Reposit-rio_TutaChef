import 'package:flutter/material.dart';
import 'package:tutachef_project/core/app_core.dart';
import 'package:tutachef_project/core/widgets/custom_textField.dart';

class CardIngredienteIndicado extends StatelessWidget {
  CardIngredienteIndicado(
      {super.key, required this.categorie, required this.type});
  String categorie;
  String type;

  @override
  Widget build(BuildContext context) {
    void _mostrarDialogDeConfirmacaoExclusao(
        BuildContext context, String categorie) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Excluir $categorie'),
            content: const Text('Tem certeza de que deseja excluir?'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o AlertDialog
                },
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  AppCore()
                      .successDialog(context, '$type excluido com sucesso!');
                },
                child: const Text('Confirmar'),
              ),
            ],
          );
        },
      );
    }

    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Card(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categorie,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              GestureDetector(
                onTap: () => _adicionarRejeitarIngredient(
                  context,
                  type,
                  action: 'Alterar',
                ),
                child: Icon(
                  Icons.remove_red_eye,
                  color: Colors.green[600],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _adicionarRejeitarIngredient(BuildContext context, String type,
      {String? action}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar $type'),
          content: CustomTextField(),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  AppCore()
                      .successDialog(context, '$type rejeitado com sucesso');
                },
                child: const Text(
                  'Rejeitar',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  AppCore()
                      .successDialog(context, '$type adicionado com sucesso');
                },
                child: const Text(
                  'Adicionar',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
