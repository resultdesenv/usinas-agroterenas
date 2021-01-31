import 'package:agronomico/base/base_inherited.dart';
import 'package:agronomico/comum/componentes/drawer_filtros.dart';
import 'package:agronomico/comum/componentes/drawer_menu.dart';
import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:agronomico/comum/utilidades/navegacao.dart';
import 'package:agronomico/paginas/apontamento_broca_lista/apontamento_broca_lista_bloc.dart';
import 'package:agronomico/paginas/apontamento_broca_lista/apontamento_broca_lista_event.dart';
import 'package:agronomico/paginas/apontamento_broca_lista/apontamento_broca_lista_state.dart';
import 'package:agronomico/paginas/upnivel3/upnivel3_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApontamentoBrocaListaContent extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  ApontamentoBrocaListaContent({@required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApontamentoBrocaListaBloc, ApontamentoBrocaListaState>(
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Column(children: [
              Text('BROCA'),
              Text(
                BaseInherited.of(context).empresaAutenticada.cdInstManfro,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade200),
              )
            ]),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => navegar(
                  context: context,
                  pagina: UpNivel3Page(
                    callback: ({
                      int cdFunc,
                      int noSeq,
                      int noBoletim,
                      int dispositivo,
                      List<UpNivel3Model> upniveis,
                    }) =>
                        context
                            .bloc<ApontamentoBrocaListaBloc>()
                            .add(MontaBoletimBroca(
                              cdFunc: cdFunc,
                              noSeq: noSeq,
                              dispositivo: dispositivo,
                              noBoletim: noBoletim,
                              upniveis: upniveis,
                            )),
                  ),
                ),
                tooltip: 'Adicionar Boletim',
              ),
              IconButton(
                icon: Icon(Icons.filter_list),
                tooltip: 'Filtros',
                onPressed: () {
                  scaffoldKey.currentState.openEndDrawer();
                },
              ),
            ],
          ),
          body: Center(
            child: Text('Brocas'),
          ),
          drawer: DrawerMenu(),
          endDrawer: DrawerFiltros(
            estimativa: true,
            filtros: state.filtros,
            listaSafra: state.listaDropDown['cdSafra'] ?? [],
            listaUp1: state.listaDropDown['cdUpnivel1'] ?? [],
            listaUp2: state.listaDropDown['cdUpnivel2'] ?? [],
            listaUp3: state.listaDropDown['cdUpnivel3'] ?? [],
            controller:
                TextEditingController(text: state.filtros['noBoletim'] ?? ''),
            alteraFiltro: (chave, valor) {
              context
                  .bloc<ApontamentoBrocaListaBloc>()
                  .add(AlterarFiltroBroca(chave: chave, valor: valor));
            },
            filtrar: (valores) {
              context
                  .bloc<ApontamentoBrocaListaBloc>()
                  .add(BuscaListaBroca(filtros: valores, salvaFiltros: true));
            },
            buscaSafra: (up1) {
              context
                  .bloc<ApontamentoBrocaListaBloc>()
                  .add(BuscaSafra(up1: up1));
            },
            buscaUp2: (safra) {
              context
                  .bloc<ApontamentoBrocaListaBloc>()
                  .add(BuscaUpnivel2(safra: safra));
            },
            buscaUp3: (up2) {
              context
                  .bloc<ApontamentoBrocaListaBloc>()
                  .add(BuscaUpnivel3(up2: up2));
            },
          ),
        );
      },
    );
  }
}
