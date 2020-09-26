import 'package:apontamento/comum/utilidades/criptografiaSenha.dart';
import 'package:apontamento/paginas/login/login_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:package_info/package_info.dart';

import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({@required this.loginRepository}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is Started) {
      yield LoginState();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      final usuarios = await loginRepository.buscarUsuariosSalvos();

      final temUsuario = await loginRepository.temUsuario();

      if (!temUsuario)
        yield state.juntar(irParaConfiguracao: true);
      else
        yield state.juntar(
          versao: packageInfo.version,
          usuariosSalvos: usuarios,
          pronto: true,
        );
    }

    if (event is BuscarEmpresas) {
      yield state.juntar(buscandoEmpresas: true);
      try {
        final empresas = await loginRepository.buscarEmpresas(event.usuario);
        yield state.juntar(empresas: empresas, buscandoEmpresas: false);
      } catch (e) {
        yield state.juntar(
            buscandoEmpresas: false, mensagem: e.toString(), empresas: []);
      }
    }

    if (event is Logar) {
      yield state.juntar(carregando: true);
      try {
        final usuario = await loginRepository.logar(
            usuario: event.usuario, senha: event.senha);

        print('Senha Original: ${event.senha}');
        print('Senha Decode: ${CriptografiaSenha.decodePassword(event.senha)}');
        print('Senha Decode: ${CriptografiaSenha.encodePassword(event.senha)}');
        final empresa = await loginRepository
            .buscarEmpresaPorId(int.tryParse(event.cmEmpresa));

        if (event.salvar) await loginRepository.salvarUsuario(usuario, empresa);
        yield state.juntar(
            carregando: false,
            autenticado: true,
            usuarioAutenticada: usuario,
            empresaAutenticada: empresa);
      } catch (e) {
        yield state.juntar(carregando: false, mensagem: e.toString());
      }
    }

    if (event is AtualizarLembrar) {
      yield state.juntar(lembrar: event.lembrar);
    }
  }
}
