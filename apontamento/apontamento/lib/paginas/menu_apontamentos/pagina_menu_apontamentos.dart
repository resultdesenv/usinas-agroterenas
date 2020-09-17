import 'package:apontamento/base/base_inherited.dart';
import 'package:apontamento/comun/componentes/drawer_menu.dart';
import 'package:apontamento/comun/componentes/menu_apontamentos_item.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_pagina.dart';
import 'package:flutter/material.dart';

class PaginaMenuApontamentos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(BaseInherited.of(context).empresaAutenticada.cdInstManfro),
      ),
      body: GridView(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        children: [
          MenuApontamentosItem(
            titulo: 'Estimativas',
            icone: Icons.show_chart,
            pagina: ApontamentoEstimativaListaPagina(),
            context: context,
          ),
          // MenuApontamentosItem(
          //   titulo: 'Insumos',
          //   icone: Icons.chrome_reader_mode,
          //   pagina: MenuSincronizacao(),
          //   context: context,
          // ),
          // MenuApontamentosItem(
          //   titulo: 'Climatologico',
          //   icone: Icons.filter_drama,
          //   pagina: MenuSincronizacao(),
          //   context: context,
          // ),
        ],
      ),
      backgroundColor: Color(0xFFEEEEEE),
      drawer: DrawerMenu(),
    );
  }
}
