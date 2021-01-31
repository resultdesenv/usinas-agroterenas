import 'package:agronomico/base/base_inherited.dart';
import 'package:agronomico/comum/componentes/drawer_filtros.dart';
import 'package:agronomico/paginas/upnivel3/upnivel3_bloc.dart';
import 'package:agronomico/paginas/upnivel3/upnivel3_event.dart';
import 'package:agronomico/paginas/upnivel3/upnivel3_state.dart';
import 'package:agronomico/paginas/upnivel3/upnivel3_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpNivel3Content extends StatelessWidget {
  final bool selecaoMultipla;
  final scaffoldKey;

  UpNivel3Content({
    @required this.selecaoMultipla,
    @required this.scaffoldKey,
  });

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
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Column(children: [
                Text('LOCAL'),
                Text(
                  BaseInherited.of(context).empresaAutenticada.cdInstManfro,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade200),
                )
              ]),
              actions: [
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    scaffoldKey.currentState.openEndDrawer();
                  },
                ),
              ],
            ),
            body: estado.carregando
                ? Center(child: CircularProgressIndicator())
                : estado.lista.length > 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.grey[200],
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 16, left: 8),
                                  child: selecaoMultipla
                                      ? Checkbox(
                                          value: estado.selecionadas.length ==
                                              estado.lista.length,
                                          onChanged: (valor) => context
                                              .bloc<UpNivel3Bloc>()
                                              .add(
                                                CheckAllUpNivel3(valor: valor),
                                              ),
                                        )
                                      : SizedBox(
                                          height: 48,
                                          width: 48,
                                        ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 24),
                                    child: Table(
                                      children: [
                                        TableRow(
                                          children: [
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
                                                'Area',
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
                              itemCount: estado.lista.length,
                              itemBuilder: (context, indice) => UpNivel3Tile(
                                selecaoMultipla: selecaoMultipla,
                                upnivel3: estado.lista[indice],
                                disabled: estado.selecionadas.length > 0 &&
                                    !selecaoMultipla &&
                                    !estado.selecionadas
                                        .contains(estado.lista[indice]),
                                selected: estado.selecionadas
                                    .contains(estado.lista[indice]),
                                onSelectionChange: (__) {
                                  context
                                      .bloc<UpNivel3Bloc>()
                                      .add(MudaSelecaoUpNivel3(
                                        upnivel3: estado.lista[indice],
                                      ));
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Text('Nenhum registro encontrado!'),
                      ),
            floatingActionButton: Stack(
              overflow: Overflow.visible,
              children: [
                AnimatedPositioned(
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 380),
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
              filtrarData: false,
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
                    .add(BuscaListaUpNivel3(filtros: filtros));
              },
              buscaSafra: (up1) {
                context.bloc<UpNivel3Bloc>().add(BuscaSafra(up1: up1));
              },
              buscaUp2: (safra) {
                context.bloc<UpNivel3Bloc>().add(BuscaUpnivel2(safra: safra));
              },
              buscaUp3: (up2) {
                context.bloc<UpNivel3Bloc>().add(BuscaUpnivel3(up2: up2));
              },
            ),
          );
        },
      ),
    );
  }
}
