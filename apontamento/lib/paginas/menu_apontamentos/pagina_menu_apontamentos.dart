import 'package:apontamento/base/base_inherited.dart';
import 'package:apontamento/comum/componentes/drawer_menu.dart';
import 'package:apontamento/comum/componentes/menu_apontamentos_item.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_page.dart';
import 'package:flutter/material.dart';

final opcoes = [
  {
    'titulo': 'Estimativas',
    'icone': Icons.show_chart,
    'pagina': ApontamentoEstimativaListaPage(),
  },
  // {
  //   'titulo': 'Insumos',
  //   'icone': Icons.chrome_reader_mode,
  //   'pagina': MenuSincronizacao(),
  // },
  // {
  //   'titulo': 'Climatologico',
  //   'icone': Icons.filter_drama,
  //   'pagina': MenuSincronizacao(),
  // },
];

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
        children: opcoes
            .map((e) => MenuApontamentosItem(
                  titulo: e['titulo'],
                  icone: e['icone'],
                  pagina: e['pagina'],
                  context: context,
                ))
            .toList(),
      ),
      backgroundColor: Color(0xFFEEEEEE),
      drawer: DrawerMenu(),
    );
  }
}
