import 'package:agronomico/base/base_inherited.dart';
import 'package:agronomico/comum/componentes/drawer_filtros.dart';
import 'package:agronomico/comum/componentes/drawer_menu.dart';
import 'package:agronomico/comum/utilidades/navegacao.dart';
import 'package:agronomico/paginas/apontamento_estimativa_form/apontamento_estimativa_page.dart';
import 'package:agronomico/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_bloc.dart';
import 'package:agronomico/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_state.dart';
import 'package:agronomico/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_event.dart';
import 'package:agronomico/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_tile.dart';
import 'package:agronomico/paginas/upnivel3/upnivel3_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApontamentoEstimativaListaContent extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  ApontamentoEstimativaListaContent({@required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApontamentoEstimativaListaBloc,
        ApontamentoEstimativaListaState>(
      builder: (context, estado) {
        if (estado.carregando) {
          return Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Column(children: [
              Text('ESTIMATIVA'),
              Text(BaseInherited.of(context).empresaAutenticada.cdInstManfro,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade200))
            ]),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => navegar(
                    context: context,
                    pagina: UpNivel3Page(
                      selecaoMultipla: true,
                    )),
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
          body: estado.estimativas.length > 0
              ? Column(
                  children: [
                    Container(
                      color: Colors.grey[200],
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 16, left: 8),
                            child: Checkbox(
                              value: estado.estimativas.length ==
                                  estado.estimativasSelecionadas.length,
                              onChanged: (valor) => context
                                  .bloc<ApontamentoEstimativaListaBloc>()
                                  .add(CheckAllEstimativaLista(valor: valor)),
                            ),
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
                                          'Seq',
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
                                          'Fazenda',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          'Zona',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          'Talhão',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                          child: Text('',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              )))
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
                        itemCount: estado.estimativas.length,
                        itemBuilder: (context, indice) =>
                            ApontamentoEstimativaListaTile(
                          estimativa: estado.estimativas[indice],
                          selected: estado.estimativasSelecionadas
                              .contains(estado.estimativas[indice]),
                          onSelectionChange: (__) {
                            context
                                .bloc<ApontamentoEstimativaListaBloc>()
                                .add(MudaSelecaoEstimativa(
                                  estimativa: estado.estimativas[indice],
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : Center(child: Text('Nenhum registro encontrado!')),
          floatingActionButton: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              AnimatedPositioned(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 380),
                bottom: estado.estimativasSelecionadas.length > 0 ? 74 : -84,
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
                bottom: estado.estimativasSelecionadas.length > 0 ? 0 : -84,
                right: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 380),
                  height: estado.estimativasSelecionadas.length > 0 ? 64 : null,
                  width: estado.estimativasSelecionadas.length > 0 ? 64 : null,
                  child: FloatingActionButton(
                    tooltip: 'Editar Sequencias',
                    heroTag: null,
                    onPressed: () async {
                      await navegar(
                        context: context,
                        pagina: ApontamentoEstimativaPage(
                          apontamentos: estado.estimativasSelecionadas,
                        ),
                      );
                      context
                          .bloc<ApontamentoEstimativaListaBloc>()
                          .add(CarregarListas(filtros: estado.filtros));
                    },
                    child: Icon(Icons.edit),
                  ),
                ),
              ),
            ],
          ),
          drawer: DrawerMenu(),
          endDrawer: DrawerFiltros(
            apontamento: true,
            filtrarData: false,
            filtros: estado.filtros,
            controllerBoletim:
                TextEditingController(text: estado.filtros['noBoletim'] ?? ''),
            controllerZona:
                TextEditingController(text: estado.filtros['cdUpnivel2'] ?? ''),
            alteraFiltro: (chave, valor) {
              context
                  .bloc<ApontamentoEstimativaListaBloc>()
                  .add(AlterarFiltroEstimativas(chave: chave, valor: valor));
            },
            filtrar: (valores) {
              context
                  .bloc<ApontamentoEstimativaListaBloc>()
                  .add(CarregarListas(filtros: valores));
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
        content: Text('Deseja excluir TODAS as estimativas selecionadas?'),
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
              context
                  .bloc<ApontamentoEstimativaListaBloc>()
                  .add(RemoverEstimativasSelecionadas());
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
