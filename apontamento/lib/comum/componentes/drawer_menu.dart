import 'package:apontamento/base/base_inherited.dart';
import 'package:apontamento/comum/utilidades/navegacao.dart';
import 'package:apontamento/configuracao/configuracao.dart';
import 'package:apontamento/paginas/login/login.dart';
import 'package:apontamento/paginas/menu_apontamentos/pagina_menu_apontamentos.dart';
import 'package:apontamento/paginas/menu_sincronizacao/menu_sincronizacao.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(context) {
    return SafeArea(
        child: Drawer(
            child: Column(children: [
      UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
              child: Text(BaseInherited.of(context)
                  .usuarioAutenticada
                  .login[0]
                  .toUpperCase())),
          accountName: Text(BaseInherited.of(context).usuarioAutenticada.login),
          accountEmail:
              Text(BaseInherited.of(context).empresaAutenticada.cdInstManfro)),
      Expanded(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
        ListTile(
            leading: Icon(Icons.assessment),
            title: Text('Apontamentos'),
            onTap: () =>
                _goTo(context: context, pagina: PaginaMenuApontamentos())),
        ListTile(
            leading: Icon(Icons.sync),
            title: Text('Sincronização'),
            onTap: () => _goTo(context: context, pagina: MenuSincronizacao())),
        ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuração'),
            onTap: () => _goTo(context: context, pagina: ConfiguracaoPage())),
        Spacer(),
        ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('Sair'),
            onTap: () => _goTo(context: context, pagina: LoginPage()))
      ]))
    ])));
  }

  _goTo({@required BuildContext context, @required Widget pagina}) {
    navegar(context: context, pagina: pagina);
  }
}
