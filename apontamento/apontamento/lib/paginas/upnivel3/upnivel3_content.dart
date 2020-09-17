import 'package:apontamento/base/base_inherited.dart';
import 'package:apontamento/comun/componentes/drawer_filtros.dart';
import 'package:apontamento/paginas/upnivel3/upnivel3_bloc.dart';
import 'package:apontamento/paginas/upnivel3/upnivel3_event.dart';
import 'package:apontamento/paginas/upnivel3/upnivel3_state.dart';
import 'package:apontamento/paginas/upnivel3/upnivel3_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpNivel3Content extends StatelessWidget {
  final bool selecaoMultipla;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  UpNivel3Content({@required this.selecaoMultipla});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpNivel3Bloc, UpNivel3State>(
      listener: (context, estado) {
        if (estado.mensagemErro != null && estado.mensagemErro.isNotEmpty) {
          final snackbar = SnackBar(
            duration: Duration(seconds: 30),
            content: Text(estado.mensagemErro),
          );

          Scaffold.of(context).showSnackBar(snackbar);
        }
      },
      listenWhen: (anterior, atual) =>
          anterior.mensagemErro != atual.mensagemErro,
      child: BlocBuilder<UpNivel3Bloc, UpNivel3State>(
        builder: (context, estado) {
          if (estado.carregando)
            return Center(child: CircularProgressIndicator());

          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(
                  BaseInherited.of(context).empresaAutenticada.cdInstManfro),
              actions: [
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    _scaffoldKey.currentState.openEndDrawer();
                  },
                ),
              ],
            ),
            body: estado.lista.length > 0
                ? ListView.builder(
                    itemCount: estado.lista.length,
                    itemBuilder: (context, indice) => UpNivel3Tile(
                      selecaoMultipla: selecaoMultipla,
                      upnivel3: estado.lista[indice],
                      selected:
                          estado.selecionadas.contains(estado.lista[indice]),
                      onSelectionChange: (__) {
                        context.bloc<UpNivel3Bloc>().add(MudaSelecaoUpNivel3(
                            upnivel3: estado.lista[indice]));
                      },
                    ),
                  )
                : Center(
                    child: Text('Nenhum registro encontrado!'),
                  ),
            floatingActionButton: Stack(
              overflow: Overflow.visible,
              children: [
                AnimatedPositioned(
                  curve: Curves.bounceInOut,
                  duration: Duration(milliseconds: 600),
                  bottom: estado.selecionadas.length == 0 ? -84 : 0,
                  right: 0,
                  child: FloatingActionButton(
                    child: Icon(Icons.check),
                    onPressed: () => context
                        .bloc<UpNivel3Bloc>()
                        .add(ConfirmaSelecaoUpNivel3(context: context)),
                  ),
                ),
              ],
            ),
            endDrawer: DrawerFiltros(
              filtros: estado.filtros,
              listaSafra: estado.listaDropDown['cdSafra'] ?? [],
              listaUp1: estado.listaDropDown['cdUpnivel1'] ?? [],
              listaUp2: estado.listaDropDown['cdUpnivel2'] ?? [],
              listaUp3: estado.listaDropDown['cdUpnivel3'] ?? [],
              alteraFiltro: (chave, valor) {
                context
                    .bloc<UpNivel3Bloc>()
                    .add(AlterarFiltroUpNivel3(chave: chave, valor: valor));
              },
              filtrar: (filtros) {
                context
                    .bloc<UpNivel3Bloc>()
                    .add(BuscaListaUpNivel3(filtros: _formataFiltros(filtros)));
              },
            ),
          );
        },
      ),
    );
  }

  Map<String, String> _formataFiltros(Map<String, String> filtros) {
    final Map<String, String> filtrosFormatados = Map.from(filtros);
    filtrosFormatados.removeWhere((chave, valor) => valor.isEmpty);

    if (filtros['dtHistoricoInicio'] != null &&
        filtros['dtHistoricoFim'] != null) {
      filtrosFormatados.remove('dtHistoricoInicio');
      filtrosFormatados.remove('dtHistoricoFim');
      filtrosFormatados['(date(dtUltimoCorte)'] =
          "BETWEEN date('${filtros['dtHistoricoInicio']}') AND date('${filtros['dtHistoricoFim']}'))";
    }

    return filtrosFormatados;
  }
}
