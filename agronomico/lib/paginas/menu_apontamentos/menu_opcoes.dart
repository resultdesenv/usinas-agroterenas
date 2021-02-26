import 'package:agronomico/comum/utilidades/navegacao.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_page.dart';
import 'package:agronomico/paginas/apontamento_broca_lista/apontamento_broca_lista_page.dart';
import 'package:agronomico/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_page.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final menuOpcoes = [
  {
    'titulo': 'Estimativas',
    'icone': Icons.place,
    'onTap': (BuildContext context) => navegar(
          context: context,
          pagina: ApontamentoEstimativaListaPage(),
        ),
  },
  {
    'titulo': 'Broca - Consulta',
    'icone': FontAwesomeIcons.joint,
    'onTap': (BuildContext context) => navegar(
          context: context,
          pagina: ApontamentoBrocaListaPage(),
        ),
  },
  {
    'titulo': 'Broca - Apontamento',
    'icone': FontAwesomeIcons.joint,
    'onTap': (BuildContext context) => navegar(
          context: context,
          pagina: TalhaoUnicoPage(
            callback: ({cdFunc, dispositivo, talhao, qtCanas}) {
              navegar(
                context: context,
                pagina: ApontamentoBrocaFormPage(
                  cdFunc: cdFunc,
                  dispositivo: dispositivo,
                  upnivel3: talhao,
                  novoApontamento: true,
                  qtCanas: qtCanas,
                ),
              );
            },
          ),
        ),
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
