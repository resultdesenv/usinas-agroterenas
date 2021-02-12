import 'package:agronomico/base/base_inherited.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_bloc.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_event.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TalhaoUnicoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TalhaoUnicoBloc, TalhaoUnicoState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Column(children: [
              Text('TALHÃO'),
              Text(
                BaseInherited.of(context).empresaAutenticada.cdInstManfro,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade200),
              )
            ]),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              state.loading ? LinearProgressIndicator() : Container(),
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Zona',
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        initialValue: state.filtros['cdUpnivel2'],
                        onChanged: (value) => context
                            .bloc<TalhaoUnicoBloc>()
                            .add(AlteraFiltros(filtros: {
                              ...state.filtros,
                              'cdUpnivel2': value
                            })),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(labelText: 'Safra'),
                        items: (state.listaDropDown['cdSafra'] ?? [])
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item ?? '',
                                  child:
                                      Text(item.isEmpty ? 'Selecione' : item),
                                ))
                            .toList(),
                        onChanged: (value) => context
                            .bloc<TalhaoUnicoBloc>()
                            .add(AlteraFiltros(
                                filtros: {...state.filtros, 'cdSafra': value})),
                        value: state.filtros['cdSafra'],
                      ),
                    ),
                    SizedBox(width: 16),
                    FloatingActionButton(
                      child: Icon(Icons.search),
                      onPressed: () =>
                          context.bloc<TalhaoUnicoBloc>().add(BuscaListaTalhoes(
                                salvaFiltros: true,
                                filtros: state.filtros,
                              )),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
