import 'package:apontamento/comun/modelo/usuario_salvo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_bloc.dart';
import 'login_event.dart';

class LoginUltimosUsuarios extends StatelessWidget {
  final List<UsuarioSalvo> usuarios;

  LoginUltimosUsuarios({@required this.usuarios});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: usuarios
            .map((usuario) => ListTile(
                onTap: () {
                  BlocProvider.of<LoginBloc>(context).add(Logar(
                      usuario: usuario.login,
                      senha: usuario.password,
                      cmEmpresa: usuario.idEmpresa.toString(),
                      salvar: false));
                },
                leading:
                    CircleAvatar(child: Text(usuario.login[0].toUpperCase())),
                title: Text(usuario.login),
                subtitle: Text(usuario.cdInstManfro.toString())))
            .toList());
  }
}
