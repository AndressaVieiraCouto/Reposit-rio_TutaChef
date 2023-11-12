import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:permission_handler/permission_handler.dart';
import 'package:tutachef_project/controllers/home_controller.dart';
import 'package:tutachef_project/views/reports/send_reports_view.dart';

class ShowRecipe extends StatefulWidget {
  ShowRecipe(
      {super.key,
      required this.title,
      required this.ingredientes,
      required this.modoPreparo,
      required this.sugestaoChef,
      required this.src,
      required this.controller});
  String title;
  List<String> ingredientes;
  String modoPreparo;
  String sugestaoChef;
  String src;
  final HomeController controller;

  @override
  State<ShowRecipe> createState() => _ShowRecipeState();
}

class _ShowRecipeState extends State<ShowRecipe> {
  Future<void> _requestPermissions() async {
    await Permission.storage.request();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height * 0.5;
    double wi = MediaQuery.of(context).size.width;

    Future<void> _saveRecipeAsPdf() async {
      // Verificar e solicitar permissões se necessário
      if (await Permission.storage.request().isGranted) {
        // Criar um documento PDF
        final pdf = pdfLib.Document();

        // Adicionar conteúdo ao PDF
        pdf.addPage(
          pdfLib.MultiPage(
            build: (context) => [
              pdfLib.Container(
                child: pdfLib.Image(
                  pdfLib.MemoryImage(File(widget.src).readAsBytesSync()),
                  fit: pdfLib.BoxFit.cover,
                ),
              ),
              pdfLib.Text(widget.title,
                  style: pdfLib.TextStyle(
                      fontSize: 20, fontWeight: pdfLib.FontWeight.bold)),
              pdfLib.SizedBox(height: 30),
              pdfLib.Text('Ingredientes:',
                  style: pdfLib.TextStyle(
                      fontSize: 14, fontWeight: pdfLib.FontWeight.bold)),
              pdfLib.Text(widget.ingredientes.join('\n')),
              pdfLib.SizedBox(height: 30),
              pdfLib.Text('Modo de Preparo:',
                  style: pdfLib.TextStyle(
                      fontSize: 14, fontWeight: pdfLib.FontWeight.bold)),
              pdfLib.Text(widget.modoPreparo,
                  textAlign: pdfLib.TextAlign.justify),
              pdfLib.SizedBox(height: 20),
              pdfLib.Row(
                children: [
                  pdfLib.Text('Sugestão do Chef:   ',
                      style: pdfLib.TextStyle(
                          fontWeight: pdfLib.FontWeight.bold, fontSize: 14),
                      textAlign: pdfLib.TextAlign.justify),
                  pdfLib.Text(widget.sugestaoChef),
                ],
              ),
            ],
          ),
        );

        // Obter o diretório temporário
        final directory = await getTemporaryDirectory();
        final path =
            '${directory.path}/receita_${DateTime.now().millisecondsSinceEpoch}.pdf';

        // Salvar o PDF no armazenamento externo
        final File file = File(path);
        await file.writeAsBytes(await pdf.save());

        // Mostrar diálogo de sucesso
        _showSuccessDialog(context,
            textContent: 'Receita salva em PDF com sucesso!');
      } else {
        // Permissões negadas
        _showErrorDialog(context,
            textContent:
                'Permissões de armazenamento negadas. Não é possível salvar o PDF.');
      }
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back, color: Colors.orange[700]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      body: SizedBox(
        width: wi,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: he * 0.5,
                width: wi,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.file(
                    File(widget.src),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text('Ingredientes:',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    Text(widget.ingredientes
                        .toString()
                        .replaceAll(',', '\n')
                        .replaceAll('[', ' ')
                        .replaceAll(']', '')),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text('Modo de Preparo:',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    Text(
                      widget.modoPreparo,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Sugestão do Chef:   ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        Text(
                          widget.sugestaoChef,
                          textAlign: TextAlign.justify,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SendReportView(
                                title: widget.title,
                                controller: widget.controller,
                              ),
                            ),
                          ),
                          child: const Column(
                            children: [
                              Icon(
                                Icons.details_rounded,
                                size: 30,
                                color: Colors.red,
                              ),
                              Text('Denunciar')
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _showSuccessDialog(context),
                          child: Column(
                            children: [
                              Icon(
                                Icons.star_border_purple500,
                                size: 30,
                                color: Colors.amber[600],
                              ),
                              const Text('Favoritar')
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: _saveRecipeAsPdf,
                          child: Column(
                            children: [
                              Icon(
                                Icons.picture_as_pdf,
                                size: 30,
                                color: Colors.green[700],
                              ),
                              const Text('Salvar em PDF'),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, {String? textContent}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sucesso'),
          content: Text(textContent ?? 'Receita adicionada aos favoritos!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text(
                'OK',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, {String? textContent}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sucesso'),
          content: Text(textContent ?? 'Receita adicionada aos favoritos!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text(
                'OK',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
