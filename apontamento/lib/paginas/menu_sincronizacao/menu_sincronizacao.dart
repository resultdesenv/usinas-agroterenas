import 'package:apontamento/base/base_inherited.dart';
import 'package:apontamento/comum/componentes/drawer_menu.dart';
import 'package:apontamento/comum/utilidades/navegacao.dart';
import 'package:apontamento/paginas/sincronizacao/sincronizao_page.dart';
import 'package:apontamento/paginas/sincronizacao_out/sincronizacao_out_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuSincronizacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(BaseInherited.of(context).empresaAutenticada.cdInstManfro),
        ),
        body: GridView(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4),
            physics: NeverScrollableScrollPhysics(),
            children: [
              _montaCard(
                  context: context,
                  titulo: 'Receber / Entrada',
                  icone: FontAwesomeIcons.download,
                  corIcone: Theme.of(context).accentColor,
                  pagina: SincronizacaoPage()),
              _montaCard(
                context: context,
                titulo: 'Enviar / Saida',
                icone: FontAwesomeIcons.upload,
                corIcone: Theme.of(context).primaryColor,
                pagina: SincronizacaoOutPage(),
              )
            ]),
        drawer: DrawerMenu(),
        backgroundColor: Color(0xFFEEEEEE));
  }

  Widget _montaCard({
    @required Color corIcone,
    @required IconData icone,
    @required String titulo,
    @required Widget pagina,
    @required BuildContext context,
  }) {
    return InkWell(
      onTap: () => navegar(context: context, pagina: pagina),
      child: Card(
          child: Column(children: <Widget>[
            Expanded(
                child: Container(
                    color: corIcone,
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
    return Card(
      child: Container(
        child: FlatButton(
          onPressed: () => navegar(context: context, pagina: pagina),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(titulo, style: TextStyle(fontSize: 14)),
              Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Icon(icone, size: 32, color: corIcone))
            ],
          ),
        ),
      ),
    );
  }
}
