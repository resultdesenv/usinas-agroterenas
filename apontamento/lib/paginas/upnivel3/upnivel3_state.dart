import 'package:apontamento/comun/modelo/upnivel3_model.dart';
import 'package:equatable/equatable.dart';

class UpNivel3State extends Equatable {
  final bool carregando;
  final List<UpNivel3Model> lista;
  final List<UpNivel3Model> selecionadas;
  final Map<String, dynamic> filtros;
  final String mensagemErro;
  final Map<String, List<String>> listaDropDown;

  UpNivel3State({
    this.carregando = false,
    this.lista = const [],
    this.selecionadas = const [],
    this.filtros = const {},
    this.mensagemErro,
    this.listaDropDown = const {},
  });

  UpNivel3State juntar({
    bool carregando,
    List<UpNivel3Model> lista,
    List<UpNivel3Model> selecionadas,
    Map<String, dynamic> filtros,
    String mensagemErro,
    Map<String, List<String>> listaDropDown,
  }) {
    return UpNivel3State(
      carregando: carregando ?? this.carregando,
      lista: lista ?? this.lista,
      selecionadas: selecionadas ?? this.selecionadas,
      filtros: filtros ?? this.filtros,
      listaDropDown: listaDropDown ?? this.listaDropDown,
      mensagemErro: mensagemErro,
    );
  }

  @override
  List<Object> get props => [
        carregando,
        lista,
        filtros,
        selecionadas,
        mensagemErro,
        listaDropDown,
      ];
}
