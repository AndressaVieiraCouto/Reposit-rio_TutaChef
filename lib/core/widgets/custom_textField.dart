import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      this.hint,
      this.obscure,
      this.function,
      this.maxLines,
      this.controller});
  String? hint;
  bool? obscure;
  Function(String)? function;
  int? maxLines;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0), // Borda arredondada
        color: Colors.white, // Cor de fundo
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ], // Sombra
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines ?? 1,
        onChanged: function,
        obscureText: obscure ?? false,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: hint ?? '',
          border: InputBorder.none, // Remova a borda padrão
          contentPadding: const EdgeInsets.all(12.0), // Espaçamento interno
        ),
      ),
    );
  }
}
