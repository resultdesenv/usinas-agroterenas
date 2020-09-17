import 'package:apontamento/base/base_inherited.dart';
import 'package:apontamento/comun/componentes/drawer_filtros.dart';
import 'package:apontamento/comun/componentes/drawer_menu.dart';
import 'package:apontamento/comun/utilidades/navegacao.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_estimativa_pagina.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_bloc.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_estado.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_eventos.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_tile.dart';
import 'package:apontamento/paginas/upnivel3/upnivel3_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApontamentoEstimativaListaConteudo extends StatelessWidget {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApontamentoEstimativaListaBloc,
        ApontamentoEstimativaListaEstado>(
      builder: (context, estado) {
        if (estado.carregando) {
          return Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title:
                Text(BaseInherited.of(context).empresaAutenticada.cdInstManfro),
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
                  _scaffoldKey.currentState.openEndDrawer();
                },
              ),
            ],
          ),
          body: estado.estimativas.length > 0
              ? ListView.builder(
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
                      ))
              : Center(child: Text('Nenhum registro encontrado!')),
          floatingActionButton: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              AnimatedPositioned(
                curve: Curves.bounceInOut,
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
                curve: Curves.bounceInOut,
                duration: Duration(microseconds: 380),
                bottom: estado.estimativasSelecionadas.length > 0 ? 0 : -84,
                right: 0,
                child: AnimatedContainer(
                  duration: Duration(microseconds: 380),
                  height: estado.estimativasSelecionadas.length > 0 ? 64 : null,
                  width: estado.estimativasSelecionadas.length > 0 ? 64 : null,
                  child: FloatingActionButton(
                    tooltip: 'Editar Sequencias',
                    heroTag: null,
                    onPressed: () => navegar(
                      context: context,
                      pagina: ApontamentoEstimativaPagina(
                        apontamentos: estado.estimativasSelecionadas,
                      ),
                    ),
                    child: Icon(Icons.edit),
                  ),
                ),
              ),
            ],
          ),
          drawer: DrawerMenu(),
          endDrawer: DrawerFiltros(
            estimativa: true,
            filtros: estado.filtros,
            listaSafra: estado.listaDropDown['cdSafra'] ?? [],
            listaUp1: estado.listaDropDown['cdUpnivel1'] ?? [],
            listaUp2: estado.listaDropDown['cdUpnivel2'] ?? [],
            listaUp3: estado.listaDropDown['cdUpnivel3'] ?? [],
            alteraFiltro: (chave, valor) {
              context
                  .bloc<ApontamentoEstimativaListaBloc>()
                  .add(AlterarFiltroEstimativas(chave: chave, valor: valor));
            },
            filtrar: (valores) {
              context
                  .bloc<ApontamentoEstimativaListaBloc>()
                  .add(CarregarListas(filtros: _formataFiltros(valores)));
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
        content: Text('Deseja ,ecluir TODAS as estimativas selecionadas?'),
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

  Map<String, String> _formataFiltros(Map<String, String> valores) {
    final Map<String, String> filtrosFormatados = Map.from(valores);
    filtrosFormatados.removeWhere((chave, valor) => valor.isEmpty);

    if (valores['dtHistoricoInicio'] != null &&
        valores['dtHistoricoFim'] != null) {
      filtrosFormatados.remove('dtHistoricoInicio');
      filtrosFormatados.remove('dtHistoricoFim');
      filtrosFormatados['(date(dtHistorico)'] =
          "BETWEEN date('${valores['dtHistoricoInicio']}') AND date('${valores['dtHistoricoFim']}'))";
    }
    if (valores['status'] != null && valores['status'].isNotEmpty)
      filtrosFormatados['status'] = 'IN ${valores['status']}';

    return filtrosFormatados;
  }
}
