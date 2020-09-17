import 'dart:io';
import 'package:path/path.dart';
import 'package:apontamento/base/base_bloc.dart';
import 'package:apontamento/base/base_event.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_autenticacao.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_completa_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../env.dart';
import 'configuracao.dart';
import 'configuracaoRepository.dart';
import 'configuracao_model.dart';

class ConfiguracaoBloc extends Bloc<ConfiguracaoEvent, ConfiguracaoState> {
  final BaseBloc baseBloc;
  final ConfiguracaoRepository configuracaoRepository;
  final SincronizacaoCompletaRepository sincronizacaoCompletaRepository;
  final SincronizacaoAutenticacao sincronizacaoAutenticacao;

  ConfiguracaoBloc({
    @required this.baseBloc,
    @required this.configuracaoRepository,
    @required this.sincronizacaoCompletaRepository,
    @required this.sincronizacaoAutenticacao,
  }) : super(ConfiguracaoState());

  @override
  Stream<ConfiguracaoState> mapEventToState(ConfiguracaoEvent event) async* {
    if (event is Iniciar) {
      final prefs = await SharedPreferences.getInstance();
      String chave = prefs.getString('chave');
      String url = prefs.getString('url');
      yield ConfiguracaoState(chave: chave, url: url, carregando: false);
    }

    if (event is AtualizarConfiguracao) {
      try {
        yield state.juntar(salvando: true);
        final ConfiguracaoModel configuracao =
            await configuracaoRepository.buscarConfiguracoes(event.chave);

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('chave', configuracao.chave);
        prefs.setString('url', configuracao.url);

        final token = await sincronizacaoAutenticacao.index();

//        await sincronizacaoLimparRepository.index([
//          'usuario',
//          'empresa',
//          'usuario_emp',
//          'safra',
//          'apont_estimativa',
//          'dispositivo',
//          'sequencia',
//          'upnivel3',
//          'preferencia',
//        ]);

        await sincronizacaoCompletaRepository.index(token);

        baseBloc.add(
            AtualizarBase(url: configuracao.url, chave: configuracao.chave));

        yield ConfiguracaoState(
            chave: configuracao.chave,
            url: configuracao.url,
            salvando: false,
            configurado: true);
      } catch (e) {
        print(e);
        yield state.juntar(
            salvando: false,
            mensagem: e.toString() ??
                'Tivemos um problema, tente novamente mais tarde');
      }
    }

    if (event is EnviarEmail) {
      yield state.juntar(enviandoEmail: true);
      try {
        String databasesPath = await getDatabasesPath();
        String path = join(databasesPath, nomeDb);
        File db = File(path);
        final pathTemp = await getTemporaryDirectory();
        final temp = db.copySync('${pathTemp.path}/database.db');

        final date = DateTime.now();
        final Email email = Email(
          body: 'Enviando banco de dados para análise.',
          subject:
              'Banco de Dados - ${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}',
          recipients: [emailSuporte],
          attachmentPaths: [
            temp.path,
          ],
          isHTML: false,
        );

        await FlutterEmailSender.send(email);
        yield state.juntar(
            enviandoEmail: false, mensagem: 'E-mail enviado com sucesso');
      } catch (e) {
        yield state.juntar(enviandoEmail: false, mensagem: e.toString());
      }
    }
  }
}
