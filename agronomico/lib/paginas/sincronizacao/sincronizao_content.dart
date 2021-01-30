import 'package:agronomico/base/base_inherited.dart';
import 'package:agronomico/paginas/sincronizacao/sincronizacao_item_lista.dart';
import 'package:flutter/material.dart';
import 'package:agronomico/paginas/sincronizacao/sincronizacao.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SincronizacaoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SincronizacaoBloc, SincronizacaoState>(
      listener: (context, state) {
        if (state.mensagem != null)
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(state.mensagem)),
          );
      },
      child: BlocBuilder<SincronizacaoBloc, SincronizacaoState>(
        builder: (context, state) {
          return Stack(children: [
            ListView(
                padding: const EdgeInsets.only(bottom: 56),
                children: state.itensSincronizacao
                    .map((item) => SincronizacaoItemLista(
                        item: item,
                        safras: state.safras,
                        safraSelecionada: state.safraSelecionada,
                        abrirFiltros: item.filterNivel2
                            ? () => _abrirFiltros(context, state.filtroNivel2)
                            : null))
                    .toList()),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 56,
                child: RaisedButton(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(Icons.refresh, color: Colors.white)),
                        Text(
                            state.itensSincronizacao
                                        .where((element) => element.atualizando)
                                        .length ==
                                    0
                                ? 'Sincronizar Tudo'
                                : 'Sincronizando...',
                            style: TextStyle(color: Colors.white, fontSize: 16))
                      ]),
                  color: state.itensSincronizacao
                              .where((element) => element.atualizando)
                              .length ==
                          0
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  onPressed: state.itensSincronizacao
                              .where((element) => element.atualizando)
                              .length ==
                          0
                      ? () {
                          if (state.safraSelecionada != null) {
                            BlocProvider.of<SincronizacaoBloc>(context).add(
                              SincronizarTudo(
                                itensSincronizacao: state.itensSincronizacao,
                                empresaModel: BaseInherited.of(context)
                                    .empresaAutenticada,
                              ),
                            );
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Selecione uma safra'),
                            ));
                          }
                        }
                      : null,
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }

  void _abrirFiltros(BuildContext context, String filtroNivel2) {
    final controller = TextEditingController(text: filtroNivel2);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Filtar'),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'\d'))
                ],
                controller: controller,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: false,
                  signed: false,
                ),
                decoration: InputDecoration(labelText: 'Nivel2'),
                onChanged: (value) =>
                    BlocProvider.of<SincronizacaoBloc>(context)
                        .add(AlteraFiltroNivel2(filtro: controller.text)),
              ),
            ],
          ),
        ),
        actions: [
          FlatButton(
            child: Text('Limpar'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).pop();
              BlocProvider.of<SincronizacaoBloc>(context)
                  .add(AlteraFiltroNivel2(filtro: ''));
            },
          ),
          FlatButton(
            child: Text('Fechar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
