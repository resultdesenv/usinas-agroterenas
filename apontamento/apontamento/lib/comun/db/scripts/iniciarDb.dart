import 'package:apontamento/comun/db/scripts/empresa.dart';
import 'package:apontamento/comun/db/scripts/estimativa.dart';
import 'package:apontamento/comun/db/scripts/preferencia.dart';
import 'package:apontamento/comun/db/scripts/safra.dart';
import 'package:apontamento/comun/db/scripts/sequencia.dart';
import 'package:apontamento/comun/db/scripts/upnivel3.dart';
import 'package:apontamento/comun/db/scripts/usuario.dart';
import 'package:apontamento/comun/db/scripts/usuarioSalvos.dart';
import 'package:apontamento/comun/db/scripts/usuario_emp.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meta/meta.dart';

import 'dispositivo.dart';
import 'historico_sincronizacao.dart';

class IniciarDb {
  final Database db;

  IniciarDb({@required this.db});

  index() async {
    try {
      await db.execute(tabelaUsuario);
      await db.execute(tabelaUsuarioSalvos);
      await db.execute(tabelaEmpresa);
      await db.execute(tabelaUsuarioEmp);
      await db.execute(tabelaSafra);
      await db.execute(tabelaEstimativa);
      await db.execute(tabelaDispositivo);
      await db.execute(tabelaSequencia);
      await db.execute(tabelaUpnivel3);
      await db.execute(tabelaPreferencia);
      await db.execute(historicoSincronizacao);
    } catch (e) {
      print(e);
    }
  }
}
