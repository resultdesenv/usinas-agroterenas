import 'package:agronomico/comum/db/db.dart';
import 'package:agronomico/comum/modelo/empresa_model.dart';
import 'package:agronomico/comum/modelo/usuario_model.dart';
import 'package:agronomico/comum/modelo/usuario_salvo_model.dart';
import 'package:agronomico/comum/utilidades/custom_exception.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

class LoginRepository {
  final Db db;

  LoginRepository({@required this.db});

  Future<List<EmpresaModel>> buscarEmpresas(String usuario) async {
    final dbInstance = await db.get();
    final usuarioEncontrado =
        await dbInstance.query('usuario', where: "login = '$usuario' OR cdFunc = '$usuario'");

    if (usuarioEncontrado.length == 0)
      throw CustomException('Usuario não encontrado');

    final usuarioModel = Usuario.fromJson(usuarioEncontrado[0]);

    final List empresas = await dbInstance.rawQuery('''
        SELECT * FROM usuario_emp ue
          INNER JOIN empresa e ON e.cdInstManfro = ue.instancia
        WHERE ue.idUsuario = ${usuarioModel.idUsuario}
    ''');

    return empresas
        .map<EmpresaModel>((empresa) => EmpresaModel.fromJson(empresa))
        .toList();
  }

  Future<Usuario> logar({
    @required String usuario,
    @required String senha,
  }) async {
    final dbInstance = await db.get();
    final usuarioEncontrado = await dbInstance.query('usuario',
        where: "(login = '$usuario' OR cdFunc = '$usuario') AND password = '$senha'");

    if (usuarioEncontrado.length == 0) throw CustomException('Senha invalida');

    return Usuario.fromJson(usuarioEncontrado[0]);
  }

  Future<EmpresaModel> buscarEmpresaPorId(int id) async {
    final dbInstance = await db.get();
    final empresaEncontrado =
        await dbInstance.query('empresa', where: "cdEmpresa = $id");
    if (empresaEncontrado.length == 0)
      throw CustomException('Empresa não encontrado');
    return EmpresaModel.fromJson(empresaEncontrado[0]);
  }

  Future<bool> temUsuario() async {
    final dbInstance = await db.get();
    final usuarios = await dbInstance.query('usuario');
    return usuarios.length > 0;
  }

  salvarUsuario(Usuario usuario, EmpresaModel empresa) async {
    final dbInstance = await db.get();
    await dbInstance.insert(
        'usuario_salvos', UsuarioSalvo.fromUsuario(usuario, empresa).toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<UsuarioSalvo>> buscarUsuariosSalvos() async {
    final dbInstance = await db.get();
    final usuariosJson = await dbInstance.query('usuario_salvos');
    return usuariosJson
        .map<UsuarioSalvo>((usuario) => UsuarioSalvo.fromJson(usuario))
        .toList();
  }
}
