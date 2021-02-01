import 'package:agronomico/base/base_inherited.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_bloc.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_event.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_header.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_item.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApontamentoBrocaFormContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ApontamentoBrocaFormBloc, ApontamentoBrocaFormState>(
      listenWhen: (previous, current) =>
          previous.mensagemErro != current.mensagemErro,
      listener: (_, state) {
        if (state.mensagemErro != null && state.mensagemErro.isNotEmpty) {
          final snack = SnackBar(
            content: Text(state.mensagemErro),
            duration: Duration(minutes: 1),
          );
          Scaffold.of(context).showSnackBar(snack);
        }
      },
      child: BlocBuilder<ApontamentoBrocaFormBloc, ApontamentoBrocaFormState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  BaseInherited.of(context).empresaAutenticada.cdInstManfro),
            ),
            body: Center(
              child: state.carregando
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: state.brocas.length + 1,
                      padding: EdgeInsets.all(8),
                      itemBuilder: (_, index) {
                        if (index == 0) {
                          final broca = state.brocas.first;
                          return ApontamentoBrocaFormHeader(
                            broca: broca,
                            tiposFItossanidade: state.tiposFitossanidade,
                            onChanged: (cdFitoss) => context
                                .bloc<ApontamentoBrocaFormBloc>()
                                .add(AlteraTipoBroca(cdFitoss: cdFitoss)),
                          );
                        }

                        return ApontamentoBrocaFormItem(
                          broca: state.brocas[index - 1],
                          indiceBroca: index - 1,
                          onChanged: (broca) => context
                              .bloc<ApontamentoBrocaFormBloc>()
                              .add(AlteraApontamento(
                                  broca: broca, indiceBroca: index - 1)),
                        );
                      },
                    ),
            ),
            backgroundColor: Color(0xFFEAEAEA),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.save),
              onPressed: () {},
              tooltip: 'Salvar',
            ),
          );
        },
      ),
    );
  }
}
