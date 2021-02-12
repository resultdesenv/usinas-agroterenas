import 'package:agronomico/comum/db/db.dart';
import 'package:agronomico/comum/repositorios/preferencia_repository.dart';
import 'package:agronomico/comum/repositorios/upnivel3_consulta_repository.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_bloc.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_content.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TalhaoUnicoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TalhaoUnicoBloc>(
      create: (_) => TalhaoUnicoBloc(
        preferenciaRepository: PreferenciaRepository(db: Db()),
        upNivel3ConsultaRepository: UpNivel3ConsultaRepository(db: Db()),
      )..add(IniciarTalhaoUnico()),
      child: Scaffold(
        body: TalhaoUnicoContent(),
      ),
    );
  }
}
