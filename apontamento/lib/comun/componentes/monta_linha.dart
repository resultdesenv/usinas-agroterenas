import 'package:flutter/material.dart';

class MontaLinha extends StatelessWidget {
  final String label;
  final String valor;

  MontaLinha({@required this.label, @required this.valor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Text(valor),
      ],
    );
  }
}
