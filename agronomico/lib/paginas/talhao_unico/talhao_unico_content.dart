import 'package:agronomico/base/base_inherited.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_bloc.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_event.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_state.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TalhaoUnicoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TalhaoUnicoBloc, TalhaoUnicoState>(
      listenWhen: (previous, current) =>
          previous.mensagemErro != current.mensagemErro,
      listener: (_, state) {},
      child: BlocBuilder<TalhaoUnicoBloc, TalhaoUnicoState>(
        builder: (context, state) {
          final controllerZona =
              TextEditingController(text: state.filtros['cdUpnivel2']);
          final controllerSafra =
              TextEditingController(text: state.filtros['cdSafra']);

          return Scaffold(
            appBar: AppBar(
              title: Column(children: [
                Text('TALHÃO'),
                Text(
                  BaseInherited.of(context).empresaAutenticada.cdInstManfro,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade200),
                )
              ]),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Zona',
                            contentPadding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          controller: controllerZona,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'\d'),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Safra',
                            contentPadding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          controller: controllerSafra,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'\d'),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      FloatingActionButton(
                        child: Icon(Icons.search),
                        onPressed: () => context
                            .bloc<TalhaoUnicoBloc>()
                            .add(BuscaListaTalhoes(
                              salvaFiltros: true,
                              filtros: {
                                'cdUpnivel2': controllerZona.text,
                                'cdSafra': controllerSafra.text,
                              },
                            )),
                      )
                    ],
                  ),
                ),
                state.loading ? LinearProgressIndicator() : Container(),
                Container(
                  padding: EdgeInsets.only(
                    top: 16,
                    left: 16,
                    bottom: 16,
                    right: 48,
                  ),
                  color: Colors.grey[200],
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
                          // TODO: Remover fazenda
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
                Expanded(
                  child: ListView.builder(
                    itemCount: state.talhoes.length,
                    itemBuilder: (_, index) => TalhaoUnicoTile(
                      talhao: state.talhoes[index],
                      onPressed: (talhao) {
                        context.bloc<TalhaoUnicoBloc>().add(EscolheTalhao(
                              talhao: talhao,
                              cdFunc: BaseInherited.of(context)
                                  .usuarioAutenticada
                                  .cdFunc,
                            ));
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
