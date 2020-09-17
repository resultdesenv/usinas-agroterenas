import 'package:apontamento/comun/utilidades/navegacao.dart';
import 'package:flutter/material.dart';

class MenuApontamentosItem extends StatelessWidget {
  final String titulo;
  final IconData icone;
  final Widget pagina;
  final BuildContext context;

  MenuApontamentosItem({
    @required this.titulo,
    @required this.icone,
    @required this.pagina,
    @required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: FlatButton(
        onPressed: () => navegar(context: context, pagina: pagina),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titulo,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            Icon(icone, size: 40)
          ],
        ),
      ),
    );
  }
}
