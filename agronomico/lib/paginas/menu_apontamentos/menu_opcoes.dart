import 'package:agronomico/paginas/apontamento_broca_lista/apontamento_broca_lista_page.dart';
import 'package:agronomico/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final menuOpcoes = [
  {
    'titulo': 'Estimativas',
    'icone': Icons.place,
    'pagina': ApontamentoEstimativaListaPage(),
  },
  {
    'titulo': 'Brocas',
    'icone': FontAwesomeIcons.joint,
    'pagina': ApontamentoBrocaListaPage(),
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
