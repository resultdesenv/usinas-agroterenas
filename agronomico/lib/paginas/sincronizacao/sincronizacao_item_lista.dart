import 'package:agronomico/base/base_inherited.dart';
import 'package:agronomico/comum/modelo/safra_model.dart';
import 'package:agronomico/comum/modelo/sincronizacao_item_atualizacao_model.dart';
import 'package:agronomico/paginas/sincronizacao/sincronizacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SincronizacaoItemLista extends StatefulWidget {
  final HistoricoItemAtualizacaoModel item;
  final List<SafraModel> safras;
  final SafraModel safraSelecionada;
  final Function abrirFiltros;

  SincronizacaoItemLista({
    @required this.item,
    this.safras,
    this.safraSelecionada,
    this.abrirFiltros,
  });

  @override
  _SincronizacaoItemListaState createState() => _SincronizacaoItemListaState();
}

class _SincronizacaoItemListaState extends State<SincronizacaoItemLista> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      widget.item.upnivel3
          ? Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonFormField(
                  value: widget.safraSelecionada?.cdSafra,
                  onChanged: (v) {
                    BlocProvider.of<SincronizacaoBloc>(context).add(
                      SelecionarSafra(
                        safra: widget.safras
                            .firstWhere((element) => element.cdSafra == v),
                      ),
                    );
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 9),
                    labelText: 'Selecione uma safra',
                  ),
                  itemHeight: 48,
                  items: widget.safras
                      .map((safra) => DropdownMenuItem(
                          child: Text(safra.cdSafra.toString()),
                          value: safra.cdSafra))
                      .toList(),
                ),
              ),
            ])
          : Container(),
      Column(
        children: [
          ListTile(
            onTap: () {
              if (widget.item.upnivel3 && widget.safraSelecionada == null)
                return Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Selecione a safra'),
                ));
              BlocProvider.of<SincronizacaoBloc>(context).add(
                SincronizarItem(
                  historicoItemAtualizacaoModel: widget.item,
                  empresaModel: BaseInherited.of(context).empresaAutenticada,
                ),
              );
            },
            title: Text(
              widget.item.nome,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            subtitle: Text(widget.item.atualizacao),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.abrirFiltros != null
                    ? IconButton(
                        icon: Icon(Icons.filter_list),
                        onPressed: widget.abrirFiltros,
                      )
                    : Container(),
                widget.item.atualizando
                    ? Container(
                        height: 28,
                        width: 28,
                        child: Center(child: CircularProgressIndicator()))
                    : Icon(Icons.refresh)
              ],
            ),
          ),
          Divider(),
        ],
      )
    ]);
  }
}
