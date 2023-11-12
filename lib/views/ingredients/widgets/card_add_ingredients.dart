import 'package:flutter/material.dart';
import 'package:tutachef_project/controllers/home_controller.dart';

import '../../../core/app_core.dart';

class CardAddIngredients extends StatefulWidget {
  const CardAddIngredients({super.key, required this.controller});
  final HomeController controller;

  @override
  State<CardAddIngredients> createState() => _CardAddIngredientsState();
}

List<String> suggestionsIngredients = AppCore.ingredientesMock;
List<String> suggestionsMedidas = AppCore.unidades;
TextEditingController _ingredientsController = TextEditingController();
TextEditingController _medidasController = TextEditingController();
TextEditingController _quantidadeController = TextEditingController();

String currentText = '';
bool showSuggestions = false;
List<String> filteredSuggestions = [];
String? selectedMedida;
String? selectedIngredient;

class _CardAddIngredientsState extends State<CardAddIngredients> {
  @override
  Widget build(BuildContext context) {
    double wi = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: SizedBox(
        height: 320,
        width: wi,
        child: Card(
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(mainAxisSize: MainAxisSize.min, children: [
                const SizedBox(
                  height: 5,
                ),
                // ... (o restante do seu código)

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.fromBorderSide(
                          BorderSide(width: 1, color: Colors.black))),
                  height: 60,
                  width: 240,
                  child: Center(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      isDense: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      underline:
                          const DropdownButtonHideUnderline(child: SizedBox()),
                      value: selectedIngredient,
                      items: AppCore.ingredientesMock
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _ingredientsController.text = newValue ?? '';
                          selectedIngredient = newValue;
                        });
                      },
                      hint: const Text('Selecione um ingrediente'),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.fromBorderSide(
                          BorderSide(width: 1, color: Colors.black))),
                  height: 60,
                  width: 240,
                  child: Center(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      isDense: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      underline:
                          const DropdownButtonHideUnderline(child: SizedBox()),
                      value: selectedMedida,
                      items: AppCore.unidades
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedMedida = newValue;
                          _medidasController.text = newValue!;
                        });
                      },
                      hint: const Text('Unidade de Medida'),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Quantidade',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      width: wi * 0.25,
                      child: Center(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _quantidadeController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          onEditingComplete: () {
                            _adicionarIngrediente();
                            FocusScope.of(context).unfocus();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => _adicionarIngrediente(),
                      child: Container(
                        height: 50,
                        width: 140,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            gradient: AppCore.defaultOrangeGradient),
                        child: const Center(
                          child: Text(
                            'Adicionar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _adicionarIngrediente() {
    String ingrediente = _ingredientsController.text.trim();
    String medida = _medidasController.text.trim();
    String quantidade = _quantidadeController.text.trim();

    widget.controller.addIngredientMap(
      quantidade: quantidade,
      medida: medida,
      ingrediente: ingrediente,
    );

    // Limpa os controladores após adicionar o ingrediente
    _ingredientsController.clear();
    _medidasController.clear();
    _quantidadeController.clear();
    selectedMedida = 'selecione uma medida';
    selectedIngredient = 'selecione um ingrediente';

    // Atualiza a exibição das sugestões
    setState(() {
      showSuggestions = false;
    });
  }
}
