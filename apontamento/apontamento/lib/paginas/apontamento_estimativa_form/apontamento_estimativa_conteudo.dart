import 'package:apontamento/base/base_inherited.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_estimativa_bloc.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_estimativa_estado.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_estimativa_eventos.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_formulario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApontamentoEstimativaConteudo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ApontamentoEstimativaBloc, ApontamentoEstimativaEstado>(
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
          BlocListener<ApontamentoEstimativaBloc, ApontamentoEstimativaEstado>(
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
            BlocBuilder<ApontamentoEstimativaBloc, ApontamentoEstimativaEstado>(
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
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 80),
                            child: TextField(
                              decoration: InputDecoration(labelText: 'Boletim'),
                              enabled: false,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration:
                                InputDecoration(labelText: 'Qtd de Sequencia'),
                            enabled: false,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: IconButton(
                            color: Colors.red,
                            icon: Icon(Icons.delete),
                            onPressed: () => _mostrarModal(context),
                            tooltip: 'Apagar todos os registros',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                      itemCount: estado.apontamentos.length,
                      itemBuilder: (context, indice) {
                        final apontamento = estado.apontamentos[indice];
                        return ApontamentoFormulario(
                          apontamento: apontamento,
                          onChanged: (apontamento) {
                            context
                                .bloc<ApontamentoEstimativaBloc>()
                                .add(EditarApontamento(
                                  apontamento: apontamento,
                                  indice: indice,
                                ));
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              backgroundColor: Color(0xFFFAFAFA),
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
        content: Text(
            'Deseja excluir TODAS as sequencias selecionadas desse boletim?'),
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
                .add(ApagarApontamentos()),
          ),
        ],
      ),
    );
  }
}
