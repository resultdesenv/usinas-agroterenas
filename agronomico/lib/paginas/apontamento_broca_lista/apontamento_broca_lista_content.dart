import 'package:agronomico/base/base_inherited.dart';
import 'package:agronomico/comum/componentes/drawer_filtros.dart';
import 'package:agronomico/comum/componentes/drawer_menu.dart';
import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:agronomico/comum/utilidades/navegacao.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_page.dart';
import 'package:agronomico/paginas/apontamento_broca_lista/apontamento_broca_lista_bloc.dart';
import 'package:agronomico/paginas/apontamento_broca_lista/apontamento_broca_lista_event.dart';
import 'package:agronomico/paginas/apontamento_broca_lista/apontamento_broca_lista_state.dart';
import 'package:agronomico/paginas/apontamento_broca_lista/apontamento_broca_lista_tile.dart';
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
                      int noBoletim,
                      int dispositivo,
                      List<UpNivel3Model> upniveis,
                    }) =>
                        navegar(
                            context: context,
                            pagina: ApontamentoBrocaFormPage(
                              cdFunc: cdFunc,
                              noBoletim: noBoletim,
                              dispositivo: dispositivo,
                              upnivel3: upniveis.first,
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
          body: state.carregando
              ? Center(child: CircularProgressIndicator())
              : state.brocas.length == 0
                  ? Center(child: Text('Nenhum registro encontrado.'))
                  : Column(
                      children: [
                        Container(
                          color: Colors.grey[200],
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 16, left: 8),
                                child: SizedBox(width: 48, height: 48),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Table(
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Text(
                                              'Boletim',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              'Coletor',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              'Safra',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              'Up1',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              'Up2',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              'Up3',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.brocas.length,
                            itemBuilder: (context, index) =>
                                ApontamentoBrocaListaTile(
                              broca: state.brocas[index],
                              selecionado:
                                  state.brocaSelecionada == state.brocas[index],
                              alteraSelecao: (value) => context
                                  .bloc<ApontamentoBrocaListaBloc>()
                                  .add(AlteraSelecaoBroca(
                                      value: value,
                                      broca: state.brocas[index])),
                            ),
                          ),
                        ),
                      ],
                    ),
          floatingActionButton: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              AnimatedPositioned(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 380),
                bottom: state.brocaSelecionada != null ? 74 : -84,
                right: 5,
                child: FloatingActionButton(
                  tooltip: 'Remover Sequencias',
                  heroTag: null,
                  onPressed: () => _confirmacaoExclusao(context),
                  backgroundColor: Colors.red,
                  child: Icon(Icons.delete),
                ),
              ),
              AnimatedPositioned(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 380),
                bottom: state.brocaSelecionada != null ? 0 : -84,
                right: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 380),
                  height: state.brocaSelecionada != null ? 64 : null,
                  width: state.brocaSelecionada != null ? 64 : null,
                  child: FloatingActionButton(
                    tooltip: 'Editar Sequencias',
                    heroTag: null,
                    onPressed: () async {
                      await navegar(
                        context: context,
                        pagina: ApontamentoBrocaFormPage(
                          noBoletim: state.brocaSelecionada.noBoletim,
                          novoApontamento: false,
                        ),
                      );
                      context
                          .bloc<ApontamentoBrocaListaBloc>()
                          .add(BuscaListaBroca(
                            filtros: state.filtros,
                            salvaFiltros: false,
                          ));
                    },
                    child: Icon(Icons.edit),
                  ),
                ),
              ),
            ],
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

  void _confirmacaoExclusao(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Você tem certeza?'),
        content: Text('Deseja EXCLUIR o apontamento selecionado?'),
        actions: [
          FlatButton(
            child: Text('Voltar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text(
              'Continuar',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              context.bloc<ApontamentoBrocaListaBloc>().add(RemoverBrocas());
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
