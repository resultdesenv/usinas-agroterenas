import 'package:agronomico/base/base_inherited.dart';
import 'package:agronomico/comum/componentes/drawer_menu.dart';
import 'package:agronomico/comum/componentes/menu_apontamentos_item.dart';
import 'package:agronomico/paginas/menu_apontamentos/menu_opcoes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../env.dart';

class PaginaMenuApontamentos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            BaseInherited.of(context).empresaAutenticada?.cdInstManfro ?? ''),
      ),
      body: Stack(
        children: [
          Center(
              child: CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(),
                  imageUrl: kUrlImagem)),
          GridView(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            children: menuOpcoes
                .map((e) => MenuApontamentosItem(
                      titulo: e['titulo'],
                      icone: e['icone'],
                      pagina: e['pagina'],
                      context: context,
                    ))
                .toList(),
          ),
        ],
      ),
      backgroundColor: Color(0xFFFFFFFF),
      drawer: DrawerMenu(),
    );
  }
}
