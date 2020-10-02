import 'package:apontamento/paginas/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'configuracao.dart';
import 'configuracao_dispositivo.dart';
import 'configuracao_sequencias.dart';

class ConfiguracaoContent extends StatefulWidget {
  final _pKey = TextEditingController();
  final _pUrl = TextEditingController();

  @override
  _ConfiguracaoContentState createState() => _ConfiguracaoContentState();
}

class _ConfiguracaoContentState extends State<ConfiguracaoContent> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ConfiguracaoBloc, ConfiguracaoState>(
        listener: (context, state) {
      if (state.configurado) {
        BlocProvider.of<ConfiguracaoBloc>(context).add(Iniciar());
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: LoginPage()));
      } else if (state.mensagem != null) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(state.mensagem)));
      }
    }, child: BlocBuilder<ConfiguracaoBloc, ConfiguracaoState>(
            builder: (context, state) {
      if (state is ConfiguracaoState) {
        widget._pKey.text = state.chave;
        widget._pUrl.text = state.url;
        return SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                TextFormField(
                    controller: widget._pKey,
                    decoration: InputDecoration(labelText: 'Chave de acesso')),
                TextFormField(
                    controller: widget._pUrl,
                    enabled: false,
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(labelText: 'URL')),
                Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: SizedBox(
                        width: double.infinity,
                        height: 48.0,
                        child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            elevation: 0,
                            onPressed: state.salvando
                                ? null
                                : () async {
                                    BlocProvider.of<ConfiguracaoBloc>(context)
                                        .add(AtualizarConfiguracao(
                                      chave: widget._pKey.text,
                                    ));
                                  },
                            child: Text(state.salvando ? 'PROCESSANDO...' : 'TESTAR',
                                style: TextStyle(color: Colors.white))))),
                Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: SizedBox(
                        width: double.infinity,
                        height: 48.0,
                        child: OutlineButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: state.salvando
                                ? null
                                : () async {
                                    BlocProvider.of<ConfiguracaoBloc>(context)
                                        .add(EnviarEmail());
                                  },
                            child: Text('ENVIAR DB PARA ANALISE'))))
              ])),
          ConfiguracaoDispositivo(dispositivo: state.dispositivo),
              ConfiguracaoSequencias(sequencias: state.sequencias),
        ]));
      }
      return Container();
    }));
  }
}
