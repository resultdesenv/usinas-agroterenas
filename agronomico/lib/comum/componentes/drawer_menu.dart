import 'package:agronomico/base/base_inherited.dart';
import 'package:agronomico/comum/utilidades/navegacao.dart';
import 'package:agronomico/configuracao/configuracao.dart';
import 'package:agronomico/paginas/login/login.dart';
import 'package:agronomico/paginas/menu_apontamentos/pagina_menu_apontamentos.dart';
import 'package:agronomico/paginas/menu_sincronizacao/menu_sincronizacao.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Text(
                  BaseInherited.of(context)
                      .usuarioAutenticada
                      .login[0]
                      .toUpperCase(),
                ),
                backgroundColor: Theme.of(context).accentColor,
              ),
              accountName:
                  Text(BaseInherited.of(context).usuarioAutenticada.login),
              accountEmail: Text(
                  BaseInherited.of(context).empresaAutenticada.cdInstManfro),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ListTile(
                    leading: Icon(Icons.create),
                    title: Text('Apontamentos'),
                    onTap: () => navegar(
                      context: context,
                      pagina: PaginaMenuApontamentos(),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.sync),
                    title: Text('Sincronização'),
                    onTap: () => navegar(
                      context: context,
                      pagina: MenuSincronizacao(),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Configuração'),
                    onTap: () => navegar(
                      context: context,
                      pagina: ConfiguracaoPage(),
                    ),
                  ),
                  Spacer(),
                  ListTile(
                    leading: Icon(Icons.power_settings_new),
                    title: Text('Sair'),
                    onTap: () => navegar(context: context, pagina: LoginPage()),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
