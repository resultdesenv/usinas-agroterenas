import 'package:flutter/material.dart';

class MenuApontamentosItem extends StatelessWidget {
  final String titulo;
  final IconData icone;
  final BuildContext context;
  final Function() onTap;

  MenuApontamentosItem({
    @required this.titulo,
    @required this.icone,
    @required this.context,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
          child: Column(children: <Widget>[
        Expanded(
            child: Container(
                color: Theme.of(context).primaryColor,
                child:
                    Center(child: Icon(icone, size: 48, color: Colors.white)))),
        Container(
            width: double.infinity,
            height: 48.0,
            color: Colors.white24,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(child: Text(titulo)))
      ])),
    );
  }
}
