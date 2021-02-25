import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_monta_tabela.dart';
import 'package:flutter/material.dart';

class TalhaoUnicoTile extends StatelessWidget {
  final UpNivel3Model talhao;
  final Function(UpNivel3Model talhao) onPressed;

  TalhaoUnicoTile({
    @required this.talhao,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: TalhaoUnicoMontaTabela(
          talhao: talhao,
        ),
        trailing: SizedBox(
          height: 48,
          width: 48,
          child: FloatingActionButton(
            heroTag: 'buton-${talhao.props}',
            child: Icon(
              Icons.add_circle,
            ),
            onPressed: () => onPressed(talhao),
          ),
        ),
      ),
    );
  }
}
