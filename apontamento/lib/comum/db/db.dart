import 'dart:async';

import 'package:apontamento/comum/db/scripts/iniciarDb.dart';
import 'package:apontamento/env.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Db {
  Future<Database> get() async {
    final String diretorioBancos = await getDatabasesPath();
    final String diretorio = join(diretorioBancos, nomeDb);
    final db = await openDatabase(
      diretorio,
      version: 1,
      onCreate: criar,
      onUpgrade: atualizar,
      onDowngrade: atualizar,
    );
    return db;
  }

  Future<void> criar(Database db, int novaVersao) async {
    print('Criando DB');
    await IniciarDb(db: db).index();
    print('Banco criado!');
  }

  Future<void> atualizar(Database db, int versaoAntiga, int novaVersao) async {
    print('Atualizar');
    try {
      await _limpar();
      await criar(db, novaVersao);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _limpar() async {
    final db = await this.get();
    final tabelas =
        await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    for (int i = 0; i < tabelas.length; i++) {
      final name = tabelas[i]['name'];
      if (name != 'android_metadata') {
        await db.delete('$name');
      }
    }
  }
}
