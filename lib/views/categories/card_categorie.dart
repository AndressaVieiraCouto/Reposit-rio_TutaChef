import 'package:flutter/material.dart';
import 'package:tutachef_project/core/app_core.dart';

import '../../core/widgets/custom_textField.dart';

class CardCategorie extends StatelessWidget {
  CardCategorie({super.key, required this.categorie, required this.type});
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
                      .successDialog(context, '$type excluida com sucesso!');
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
                onTap: () =>
                    _alterarCategoria(context, type, action: 'Alterar'),
                child: const Icon(
                  Icons.edit_document,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () =>
                    _mostrarDialogDeConfirmacaoExclusao(context, categorie),
                child: const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _alterarCategoria(BuildContext context, String type,
      {String? action, bool? ingredient}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        ingredient == true ? type = '$type alterado' : type = '$type alterada';
        return AlertDialog(
          title: Text('Alterar $type'),
          content: CustomTextField(
            hint: 'Informe a $type...',
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                AppCore().successDialog(context, '$type com sucesso');
              },
              child: Text(
                action ?? 'Adicionar',
                style: const TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}
