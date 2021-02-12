import 'package:agronomico/base/base_inherited.dart';
import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:agronomico/comum/utilidades/navegacao.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_bloc.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_event.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_header.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_item.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_state.dart';
import 'package:agronomico/paginas/apontamento_broca_lista/apontamento_broca_lista_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApontamentoBrocaFormContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ApontamentoBrocaFormBloc, ApontamentoBrocaFormState>(
      listenWhen: (previous, current) =>
          previous.mensagemErro != current.mensagemErro ||
          current.voltarParaListagem != null,
      listener: (_, state) {
        if (state.mensagemErro != null && state.mensagemErro.isNotEmpty) {
          final snack = SnackBar(
            content: Text(state.mensagemErro),
            duration: Duration(minutes: 1),
          );
          Scaffold.of(context).showSnackBar(snack);
        }

        if (state.voltarParaListagem != null && state.voltarParaListagem) {
          if (state.novoApontamento)
            navegar(context: context, pagina: ApontamentoBrocaListaPage());
          else
            Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<ApontamentoBrocaFormBloc, ApontamentoBrocaFormState>(
        builder: (context, state) {
          final apontamentos = state.brocas
              .map((e) => ApontamentoBrocaFormItem(
                    broca: e,
                    controllerTotal: TextEditingController(
                      text: e.qtEntrenos.toInt().toString().padLeft(2, '0'),
                    ),
                    controllerBrocados: TextEditingController(
                      text: e.qtBrocados.toInt().toString().padLeft(2, '0'),
                    ),
                    onChanged: (broca) => context
                        .bloc<ApontamentoBrocaFormBloc>()
                        .add(MarcaParaSalvar(broca: broca)),
                  ))
              .toList();

          return WillPopScope(
            onWillPop: () => _confirmaSair(
              context,
              apontamentos.map((e) => e.valores).toList(),
              state.salvo,
            ),
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  BaseInherited.of(context).empresaAutenticada.cdInstManfro,
                ),
              ),
              body: Center(
                child: state.carregando
                    ? Center(child: CircularProgressIndicator())
                    : apontamentos.length > 0 || state.primeiraBroca != null
                        ? ListView.builder(
                            addAutomaticKeepAlives: true,
                            itemCount: apontamentos.length + 1,
                            padding: EdgeInsets.all(8),
                            itemBuilder: (_, index) {
                              if (index == 0) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: ApontamentoBrocaFormHeader(
                                      broca: state.brocas.length > 0
                                          ? state.brocas?.first
                                          : state.primeiraBroca,
                                      canas: state.canas,
                                      controller: TextEditingController(
                                          text: state.canas.toString()),
                                      novoApontamento: state.novoApontamento,
                                      tiposFitossanidade:
                                          state.tiposFitossanidade,
                                      onChanged: (cdFitoss) => context
                                          .bloc<ApontamentoBrocaFormBloc>()
                                          .add(AlteraTipoBroca(
                                              cdFitoss: cdFitoss,
                                              brocas: apontamentos
                                                  .map((e) => e.valores)
                                                  .toList())),
                                      alterarQuantidade: (quantidade) => context
                                          .bloc<ApontamentoBrocaFormBloc>()
                                          .add(AlteraQuantidade(
                                            brocas: apontamentos
                                                .map((a) => a.valores)
                                                .toList(),
                                            quantidade:
                                                int.tryParse(quantidade),
                                          ))),
                                );
                              }
                              return apontamentos[index - 1];
                            },
                          )
                        : Container(),
              ),
              backgroundColor: Color(0xFFFAFAFA),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.save),
                onPressed: () => context
                    .bloc<ApontamentoBrocaFormBloc>()
                    .add(SalvarApontamentos(
                      empresa: BaseInherited.of(context).empresaAutenticada,
                      brocas: apontamentos.map((e) => e.valores).toList(),
                    )),
                tooltip: 'Salvar',
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool> _confirmaSair(
    BuildContext context,
    List<ApontBrocaModel> brocas,
    bool salvo,
  ) async {
    final bool res = salvo ||
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Deseja sair?'),
            content: Text(
                'Ao sair sem salvar, você perderá todos os dados editados!'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancelar'),
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).pop(false);
                  context.bloc<ApontamentoBrocaFormBloc>().add(
                        SalvarApontamentos(
                          empresa: BaseInherited.of(context).empresaAutenticada,
                          brocas: brocas,
                          voltar: true,
                        ),
                      );
                },
                child: Text('Salvar'),
              ),
              FlatButton(
                textColor: Colors.red,
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Sair'),
              ),
            ],
          ),
        );
    return res ?? false;
  }
}
