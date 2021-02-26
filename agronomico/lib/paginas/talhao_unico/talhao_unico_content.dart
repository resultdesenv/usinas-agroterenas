import 'package:agronomico/base/base_inherited.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_bloc.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_event.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_state.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TalhaoUnicoContent extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TalhaoUnicoBloc, TalhaoUnicoState>(
      listenWhen: (previous, current) =>
          previous.mensagemErro != current.mensagemErro,
      listener: (_, state) {},
      child: BlocBuilder<TalhaoUnicoBloc, TalhaoUnicoState>(
        builder: (context, state) {
          double somaAreas = 0;
          state.talhoes.forEach((talhao) {
            if (talhao.qtAreaProd != null) somaAreas += talhao.qtAreaProd;
          });
          final sujestao = (somaAreas * 3).ceil().toString();

          final controllerZona =
              TextEditingController(text: state.filtros['cdUpnivel2']);
          final controllerSujestao = TextEditingController(text: sujestao);

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
                  child: Form(
                    key: formKey,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Zona',
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 14),
                            ),
                            validator: _validarCampo,
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
                              labelText: 'Sugestão Qtd Cana',
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 14),
                            ),
                            controller: controllerSujestao,
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
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              context
                                  .bloc<TalhaoUnicoBloc>()
                                  .add(BuscaListaTalhoes(
                                    salvaFiltros: true,
                                    filtros: {
                                      'cdUpnivel2': controllerZona.text,
                                      'cdEmpresa': BaseInherited.of(context)
                                          .empresaAutenticada
                                          .cdEmpresa
                                          .toString(),
                                    },
                                  ));
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
                state.loading ? LinearProgressIndicator() : Container(),
                Container(
                  padding: EdgeInsets.only(
                    top: 16,
                    left: 16,
                    bottom: 16,
                    right: 76,
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
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              'Zona',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              'Talhão',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              'Area',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 14,
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
                              qtCanas: int.tryParse(controllerSujestao.text),
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

  String _validarCampo(String value) {
    return value == null || value.isEmpty || double.parse(value) == 0
        ? 'Preencha este campo!'
        : null;
  }
}
