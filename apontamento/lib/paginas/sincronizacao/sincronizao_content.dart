import 'package:apontamento/paginas/sincronizacao/sincronizacao_item_lista.dart';
import 'package:flutter/material.dart';
import 'package:apontamento/paginas/sincronizacao/sincronizacao.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SincronizacaoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SincronizacaoBloc, SincronizacaoState>(
        listener: (context, state) {
      if (state.mensagem != null)
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(state.mensagem)));
    }, child: BlocBuilder<SincronizacaoBloc, SincronizacaoState>(
            builder: (context, state) {
      return ListView(
          children: state.itensSincronizacao
              .map((item) => SincronizacaoItemLista(
                  item: item,
                  safras: state.safras,
                  safraSelecionada: state.safraSelecionada))
              .toList());
    }));
  }
}
