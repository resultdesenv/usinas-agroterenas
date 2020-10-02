import 'package:apontamento/base/base_inherited.dart';
import 'package:apontamento/comum/componentes/drawer_menu.dart';
import 'package:apontamento/paginas/sincronizacao_out/sincronizacao_out_bloc.dart';
import 'package:apontamento/paginas/sincronizacao_out/sincronizacao_out_event.dart';
import 'package:apontamento/paginas/sincronizacao_out/sincronizacao_out_item.dart';
import 'package:apontamento/paginas/sincronizacao_out/sincronizacao_out_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SincronizacaoOutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SincronizacaoOutBloc, SincronizacaoOutState>(
      listener: (context, estado) {
        if (estado.mensagemErro != null && estado.mensagemErro.isNotEmpty) {
          final snackbar = SnackBar(content: Text(estado.mensagemErro));
          Scaffold.of(context).showSnackBar(snackbar);
        }
      },
      listenWhen: (anterior, atual) =>
          atual.mensagemErro != anterior.mensagemErro,
      child: BlocBuilder<SincronizacaoOutBloc, SincronizacaoOutState>(
        builder: (context, estado) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                BaseInherited.of(context).empresaAutenticada.cdInstManfro,
              ),
            ),
            drawer: DrawerMenu(),
            body: estado.carregando
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 8),
                          itemCount: estado.sincronizacaoItens.length,
                          itemBuilder: (context, index) => SincronizacaoOutItem(
                            carregando: estado.carregandoItens.contains(index),
                            item: estado.sincronizacaoItens[index],
                            sincronizar: () => context
                                .bloc<SincronizacaoOutBloc>()
                                .add(SincronizarOut(index: index)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 56,
                        child: RaisedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(Icons.refresh, color: Colors.white),
                              ),
                              Text(
                                'Sincronizar Tudo',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            if (estado.carregandoItens.length == 0) {
                              context
                                  .bloc<SincronizacaoOutBloc>()
                                  .add(SincronizarTudo());
                            }
                          },
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
