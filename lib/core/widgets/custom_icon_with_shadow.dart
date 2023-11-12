import 'package:flutter/material.dart';

class IconWithShadow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color shadowColor;
  final double size;

  const IconWithShadow(
      {super.key,
      required this.icon,
      required this.iconColor,
      required this.shadowColor,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0, // Ajuste o tamanho conforme necessário
      height: 100.0, // Ajuste o tamanho conforme necessário
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10.0,
          ),
        ],
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: size, // Ajuste o tamanho do ícone conforme necessário
        color: iconColor,
      ),
    );
  }
}
