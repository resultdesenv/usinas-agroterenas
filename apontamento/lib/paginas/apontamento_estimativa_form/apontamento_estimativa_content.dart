import 'package:apontamento/base/base_inherited.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_estimativa_bloc.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_estimativa_state.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_estimativa_event.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_formulario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApontamentoEstimativaContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ApontamentoEstimativaBloc, ApontamentoEstimativaState>(
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
      child:
          BlocListener<ApontamentoEstimativaBloc, ApontamentoEstimativaState>(
        listener: (ctx, estado) {
          if (estado.mensagemErro != null && estado.mensagemErro.isNotEmpty) {
            final snackbar = SnackBar(
              duration: Duration(minutes: 1),
              content: Text(estado.mensagemErro),
            );

            Scaffold.of(context).showSnackBar(snackbar);
          }
        },
        listenWhen: (anterior, atual) =>
            anterior.mensagemErro != atual.mensagemErro,
        child:
            BlocBuilder<ApontamentoEstimativaBloc, ApontamentoEstimativaState>(
          builder: (context, estado) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                    BaseInherited.of(context).empresaAutenticada.cdInstManfro),
                actions: [
                  IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () => context
                        .bloc<ApontamentoEstimativaBloc>()
                        .add(SalvarApontamentos(context: context)),
                  ),
                ],
              ),
              body: estado.apontamentos.length > 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.only(
                              top: 16,
                              left: 8,
                              right: 8,
                            ),
                            itemCount: estado.apontamentos.length,
                            itemBuilder: (context, indice) {
                              final apontamento = estado.apontamentos[indice];
                              return ApontamentoFormulario(
                                apontamento: apontamento,
                                controllerTch0: TextEditingController(
                                  text: apontamento.tch0 != null
                                      ? apontamento.tch0.toStringAsFixed(2)
                                      : null,
                                ),
                                controllerTch1: TextEditingController(
                                  text: apontamento.tch1 != null
                                      ? apontamento.tch1.toStringAsFixed(2)
                                      : null,
                                ),
                                controllerTch2: TextEditingController(
                                  text: apontamento.tch0 != null
                                      ? apontamento.tch0.toStringAsFixed(2)
                                      : null,
                                ),
                                controllerTch3: TextEditingController(
                                  text: apontamento.tch3 != null
                                      ? apontamento.tch3.toStringAsFixed(2)
                                      : null,
                                ),
                                controllerTch4: TextEditingController(
                                  text: apontamento.tch4 != null
                                      ? apontamento.tch4.toStringAsFixed(2)
                                      : null,
                                ),
                                onChanged: (apontamentoEditado) {
                                  print('apontamento.props');

                                  context
                                      .bloc<ApontamentoEstimativaBloc>()
                                      .add(EditarApontamento(
                                        apontamento: apontamentoEditado,
                                        indice: indice,
                                      ));
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text('Nenhum apontamento para ser preenchido!'),
                    ),
              backgroundColor: Color(0xFFEAEAEA),
              floatingActionButton: !estado.criacao
                  ? FloatingActionButton(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.delete),
                      onPressed: () => _mostrarModal(context),
                      tooltip: 'Apagar todos os registros',
                    )
                  : Container(),
            );
          },
        ),
      ),
    );
  }

  void _mostrarModal(BuildContext context) {
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
            onPressed: () => context
                .bloc<ApontamentoEstimativaBloc>()
                .add(ApagarApontamentos(context: context)),
          ),
        ],
      ),
    );
  }
}
