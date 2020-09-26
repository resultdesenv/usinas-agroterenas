import 'dart:convert';
import 'dart:io';
import 'package:apontamento/comum/modelo/dispositivo_model.dart';
import 'package:apontamento/comum/repositorios/preferencia_repository.dart';
import 'package:apontamento/comum/repositorios/sequencia_repository.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:apontamento/base/base_bloc.dart';
import 'package:apontamento/base/base_event.dart';
import 'package:apontamento/comum/sincronizacao/sincronizacao_autenticacao.dart';
import 'package:apontamento/comum/sincronizacao/sincronizacao_completa_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:imei_plugin/imei_plugin.dart';

import '../env.dart';
import 'configuracao.dart';
import 'configuracaoRepository.dart';
import 'configuracao_model.dart';

class ConfiguracaoBloc extends Bloc<ConfiguracaoEvent, ConfiguracaoState> {
  final BaseBloc baseBloc;
  final ConfiguracaoRepository configuracaoRepository;
  final SincronizacaoCompletaRepository sincronizacaoCompletaRepository;
  final SincronizacaoSequenciaRepository sincronizacaoSequenciaRepository;
  final SincronizacaoAutenticacao sincronizacaoAutenticacao;
  final PreferenciaRepository preferenciaRepository;

  ConfiguracaoBloc({
    @required this.baseBloc,
    @required this.configuracaoRepository,
    @required this.sincronizacaoCompletaRepository,
    @required this.sincronizacaoAutenticacao,
    @required this.sincronizacaoSequenciaRepository,
    @required this.preferenciaRepository,
  }) : super(ConfiguracaoState());

  @override
  Stream<ConfiguracaoState> mapEventToState(ConfiguracaoEvent event) async* {
    if (event is Iniciar) {
      String chave = await preferenciaRepository.get(idPreferencia: 'chave');
      String url = await preferenciaRepository.get(idPreferencia: 'url');
      String dispositivoTexto =
          await preferenciaRepository.get(idPreferencia: 'dispositivo');

      DispositivoModel dispositivoModel;
      if (dispositivoTexto != null)
        dispositivoModel =
            DispositivoModel.fromJson(jsonDecode(dispositivoTexto));

      final sequencias =
          await sincronizacaoSequenciaRepository.buscarListaSequenciaDb();

      yield ConfiguracaoState(
        chave: chave,
        url: url,
        carregando: false,
        dispositivo: dispositivoModel,
        sequencias: sequencias,
      );
    }

    if (event is AtualizarConfiguracao) {
      try {
        yield state.juntar(salvando: true);
        final ConfiguracaoModel configuracao =
            await configuracaoRepository.buscarConfiguracoes(event.chave);

        String imei = await ImeiPlugin.getImei();

        final dispositivo = await this
            .configuracaoRepository
            .cadastrarDispositivo(url: configuracao.url, imei: imei);

        await preferenciaRepository.salvar(
            idPreferencia: 'dispositivo',
            valorPreferencia: jsonEncode(dispositivo.toJson()));

        await preferenciaRepository.salvar(
            idPreferencia: 'chave', valorPreferencia: configuracao.chave);
        await preferenciaRepository.salvar(
            idPreferencia: 'url', valorPreferencia: configuracao.url);

        final dio = Dio(BaseOptions(baseUrl: configuracao.url));

        sincronizacaoAutenticacao.updateDio(dio);
        final token = await sincronizacaoAutenticacao.index();

        await sincronizacaoCompletaRepository.index(token, dio: dio);

        baseBloc.add(
            AtualizarBase(url: configuracao.url, chave: configuracao.chave));

        final sequencias =
            await sincronizacaoSequenciaRepository.buscarListaSequenciaDb();

        yield ConfiguracaoState(
          chave: configuracao.chave,
          url: configuracao.url,
          salvando: false,
          configurado: true,
          dispositivo: dispositivo,
          sequencias: sequencias,
        );
      } catch (e) {
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
