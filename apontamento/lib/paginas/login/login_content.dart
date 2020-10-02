import 'package:apontamento/base/base_bloc.dart';
import 'package:apontamento/base/base_event.dart';
import 'package:apontamento/comum/modelo/empresa_model.dart';
import 'package:apontamento/comum/modelo/usuario_model.dart';
import 'package:apontamento/configuracao/configuracao_page.dart';
import 'package:apontamento/paginas/menu_apontamentos/pagina_menu_apontamentos.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../env.dart';
import 'login.dart';
import 'login_ultimos_usuarios.dart';

class LoginContent extends StatefulWidget {
  @override
  _LoginContentState createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final _usuario = TextEditingController();
  final _empresa = TextEditingController();
  final _senha = TextEditingController();

  _buscarEmpresas(String usuario) {
    BlocProvider.of<LoginBloc>(context).add(BuscarEmpresas(usuario: usuario));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext context, LoginState state) {
      if (state.autenticado == true)
        _irParaTelaInicial(
            usuario: state.usuarioAutenticada,
            empresa: state.empresaAutenticada);
      if (state.irParaConfiguracao == true)
        _irParaConfiguracao(context, sincronizacaoInicial: true);
      if (state.mensagem != null) _snackbar(state.mensagem);
    }, child: BlocBuilder<LoginBloc, LoginState>(
            builder: (BuildContext context, LoginState state) {
      if (!state.pronto)
        return Container(
            color: Colors.white,
            constraints: BoxConstraints.expand(),
            child: Center(child: CircularProgressIndicator()));
      return SingleChildScrollView(
          padding: const EdgeInsets.only(
              bottom: 16.0, right: 16.0, left: 16.0, top: 64),
          child: Card(
              elevation: 8.0,
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(children: <Widget>[
                    CachedNetworkImage(
                        placeholder: (context, url) => CircularProgressIndicator(),
                        imageUrl: kUrlImagem),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                        child: TextFormField(
                            controller: _usuario,
                            decoration: InputDecoration(
                                labelText: 'Usuário',
                                suffixIcon: IconButton(
                                    onPressed: () =>
                                        _buscarEmpresas(_usuario.value.text),
                                    icon: Icon(Icons.search))),
                            onFieldSubmitted: (v) => _buscarEmpresas(v))),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                        child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'Empresa/Instância *',
                            ),
                            value: _empresa.value.text,
                            autovalidate: true,
                            validator: (v) => (v ?? '').isEmpty
                                ? 'Selecione a empresa'
                                : null,
                            items: state.empresas.length == 0
                                ? []
                                : [
                                    DropdownMenuItem(
                                        child: Text('Selecione'), value: ''),
                                    ...state.empresas
                                        .map<DropdownMenuItem>(
                                            (empresa) => DropdownMenuItem(
                                                  child: Text(
                                                      '${empresa.cdInstManfro} - ${empresa.deEmpresa}'),
                                                  value: empresa.cdEmpresa
                                                      .toString(),
                                                ))
                                        .toList()
                                  ],
                            onChanged: (v) {
                              _empresa.text = v;
                            })),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                        child: TextFormField(
                            controller: _senha,
                            decoration: InputDecoration(labelText: 'Senha'),
                            obscureText: true)),
                    ListTile(
                        leading: Checkbox(
                            value: state.lembrar,
                            onChanged: (v) {
                              BlocProvider.of<LoginBloc>(context)
                                  .add(AtualizarLembrar(lembrar: v));
                            }),
                        title: Text('Lembrar Usuario')),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                            height: 48.0,
                            width: double.infinity,
                            child: RaisedButton(
                                elevation: 0.0,
                                color: Theme.of(context).primaryColor,
                                onPressed: () => _submit(salvar: state.lembrar),
                                child: state.carregando
                                    ? Center(
                                        child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white)))
                                    : Text('ENTRAR',
                                        style:
                                            TextStyle(color: Colors.white))))),
                    LoginUltimosUsuarios(usuarios: state.usuariosSalvos),
                    FlatButton(
                        child: Text('CONFIGURAÇÃO',
                            style: Theme.of(context).textTheme.button),
                        onPressed: () => _irParaConfiguracao(context)),
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(state.versao ?? '',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87))),
                  ]))));
    }));
  }

  _submit({@required bool salvar}) async {
    BlocProvider.of<LoginBloc>(context).add(Logar(
        usuario: _usuario.text,
        senha: _senha.text,
        cmEmpresa: _empresa.value.text,
        salvar: salvar));
  }

  _irParaTelaInicial({
    @required Usuario usuario,
    @required EmpresaModel empresa,
  }) {
    BlocProvider.of<BaseBloc>(context).add(
        InserirInformacoesUsuario(usuario: usuario, empresaModel: empresa));
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: PaginaMenuApontamentos()));
  }

  _irParaConfiguracao(context, {bool sincronizacaoInicial = false}) async {
    if (sincronizacaoInicial) {
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft, child: ConfiguracaoPage()));
    } else {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft, child: ConfiguracaoPage()));
    }
  }

  _snackbar(message) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
