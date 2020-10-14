import 'package:apontamento/base/base_inherited.dart';
import 'package:apontamento/comum/utilidades/navegacao.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_estimativa_bloc.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_estimativa_state.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_estimativa_event.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_formulario.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_page.dart';
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

        if (estado.edicaoConcluida) {
          if (estado.criacao) {
            navegar(context: context, pagina: ApontamentoEstimativaListaPage());
          } else {
            Navigator.of(context).pop();
          }
        }
      },
      listenWhen: (anterior, atual) =>
          anterior.mensagemErro != atual.mensagemErro || atual.edicaoConcluida,
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
          buildWhen: (anterior, atual) =>
              anterior.apontamentos.length != atual.apontamentos.length,
          builder: (context, estado) {
            final List<ApontamentoFormulario> formularios = estado.apontamentos
                .map(
                  (apontamento) => ApontamentoFormulario(
                    apontamento: apontamento,
                    controllerTch0: TextEditingController(
                      text: apontamento.tch0 != null
                          ? apontamento.tch0.toStringAsFixed(2)
                          : '',
                    ),
                    controllerTch1: TextEditingController(
                      text: apontamento.tch1 != null
                          ? apontamento.tch1.toStringAsFixed(2)
                          : '',
                    ),
                    controllerTch2: TextEditingController(
                      text: apontamento.tch2 != null
                          ? apontamento.tch2.toStringAsFixed(2)
                          : '',
                    ),
                    controllerTch3: TextEditingController(
                      text: apontamento.tch3 != null
                          ? apontamento.tch3.toStringAsFixed(2)
                          : '',
                    ),
                    controllerTch4: TextEditingController(
                      text: apontamento.tch4 != null
                          ? apontamento.tch4.toStringAsFixed(2)
                          : '',
                    ),
                  ),
                )
                .toList();

            return Scaffold(
              appBar: AppBar(
                title: Text(
                    BaseInherited.of(context).empresaAutenticada.cdInstManfro),
                actions: [
                  !estado.criacao
                      ? IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _mostrarModal(context),
                          tooltip: 'Apagar todos os registros',
                        )
                      : Container(),
                ],
              ),
              body: estado.apontamentos.length > 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.only(
                              top: 16,
                              left: 8,
                              right: 8,
                            ),
                            children: formularios,
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text('Nenhum apontamento para ser preenchido!'),
                    ),
              backgroundColor: Color(0xFFEAEAEA),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.save),
                onPressed: () => context
                    .bloc<ApontamentoEstimativaBloc>()
                    .add(SalvarApontamentos(
                      empresa: BaseInherited.of(context).empresaAutenticada,
                      estimativas:
                          formularios.map((form) => form.valores).toList(),
                    )),
                tooltip: 'Salvar',
              ),
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
            onPressed: () {
              Navigator.of(context).pop();
              context
                  .bloc<ApontamentoEstimativaBloc>()
                  .add(ApagarApontamentos());
            },
          ),
        ],
      ),
    );
  }
}
