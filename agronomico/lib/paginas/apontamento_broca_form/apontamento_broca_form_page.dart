import 'package:agronomico/base/base_inherited.dart';
import 'package:agronomico/comum/db/db.dart';
import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:agronomico/comum/repositorios/apont_broca_consulta_repository.dart';
import 'package:agronomico/comum/repositorios/preferencia_repository.dart';
import 'package:agronomico/comum/repositorios/sequencia_repository.dart';
import 'package:agronomico/comum/repositorios/tipo_fitossanidade_consulta_repository.dart';
import 'package:agronomico/comum/sincronizacao/sincronizacao_historico_repository.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_bloc.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_content.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApontamentoBrocaFormPage extends StatelessWidget {
  final int cdFunc;
  final int dispositivo;
  final int noBoletim;
  final UpNivel3Model upnivel3;
  final bool novoApontamento;

  ApontamentoBrocaFormPage({
    this.upnivel3,
    this.cdFunc,
    this.dispositivo,
    this.noBoletim,
    this.novoApontamento = true,
  });

  @override
  Widget build(BuildContext context) {
    final instancia = BaseInherited.of(context).empresaAutenticada.cdInstManfro;

    return BlocProvider<ApontamentoBrocaFormBloc>(
      create: (_) => ApontamentoBrocaFormBloc(
        repositorioFitossanidade: TipoFitossanidadeConsultaRepository(db: Db()),
        repositorioBroca: ApontBrocaConsultaRepository(db: Db()),
        repositorioPreferencia: PreferenciaRepository(db: Db()),
        repositorioSequencia: SincronizacaoSequenciaRepository(
          db: Db(),
          dio: BaseInherited.of(context).dio,
          preferenciaRepository: PreferenciaRepository(db: Db()),
          sincronizacaoHistoricoRepository:
              SincronizacaoHistoricoRepository(db: Db()),
        ),
      )..add(IniciarFormBrocas(
          instancia: instancia,
          cdFunc: cdFunc,
          dispositivo: dispositivo,
          noBoletim: noBoletim,
          upnivel3: upnivel3,
          novoApontamento: novoApontamento,
          empresa: BaseInherited.of(context).empresaAutenticada)),
      child: Scaffold(
        body: ApontamentoBrocaFormContent(),
      ),
    );
  }
}
