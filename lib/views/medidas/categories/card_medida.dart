import 'package:flutter/material.dart';
import 'package:tutachef_project/core/app_core.dart';

import '../../../core/widgets/custom_textField.dart';

class CardMedidas extends StatelessWidget {
  CardMedidas({super.key, required this.categorie, required this.type});
  String categorie;
  String type;

  @override
  Widget build(BuildContext context) {
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
              GestureDetector(
                onTap: () => _alterarCategoria(context, type),
                child: const Icon(
                  Icons.edit_document,
                  color: Colors.orange,
                ),
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

  void _alterarCategoria(BuildContext context, String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alterar $type'),
          content: CustomTextField(
            hint: 'Informe a $type...',
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                AppCore()
                    .successDialog(context, 'Categoria alterada com sucesso');
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
                AppCore().successDialog(context, '$type excluida com sucesso!');
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
