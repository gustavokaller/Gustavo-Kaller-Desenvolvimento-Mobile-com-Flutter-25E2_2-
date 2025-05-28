import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/mock_alunos.dart';
import '../models/aluno.dart';

class CadastroPage extends StatefulWidget {

  CadastroPage({super.key, required this.title});

  final String title;

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  @override

  final listaUsuarios = USUARIOS_MOCK;
  String lat = "";
  String lon = "";

  void initState() {
    super.initState();
    _carregarLocalizacao();
  }

  Future<void> _carregarLocalizacao() async {
    try {
      Position pos = await _obterLocalizacao();
      setState(() {
        lat = pos.latitude.toString();
        lon = pos.longitude.toString();
      });
    } catch (e) {
      print('Erro ao obter localização: $e');
    }
  }

  Future<Position> _obterLocalizacao() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Serviço de localização desabilitado');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permissão negada');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permissão permanentemente negada');
    }

    return await Geolocator.getCurrentPosition();
  }

  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments;

    final appBar = AppBar(
                        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                        title: Text(widget.title),
                      );
    final mediaQuery = MediaQuery.of(context);
    final bool isPortrait = mediaQuery.orientation == Orientation.portrait;
    final height = mediaQuery.size.height - mediaQuery.padding.top - appBar.preferredSize.height;

    final nomeController = TextEditingController();
    final emailController = TextEditingController();
    final telefoneController = TextEditingController();
    User? usuarioEditando;

    if(args != null && usuarioEditando == null) {
      final aluno = args as User;
      usuarioEditando = args as User;
      nomeController.text = aluno.name;
      emailController.text = aluno.email;
      telefoneController.text = aluno.telefone;
    }

    void salvarUsuario(String nome, String email, String telefone) {
      final usuario = User(
        id: usuarioEditando?.id ?? UniqueKey().toString(),
        name: nome,
        email: email,
        telefone: telefone,
        latitude: lat,
        longitude: lon,
      );

      setState(() {
        if (usuarioEditando == null) {
          listaUsuarios.add(usuario);
        } else {
          final index = listaUsuarios.indexWhere((u) => u.id == usuario.id);
          if (index != -1) {
            listaUsuarios[index] = usuario;
          }
        }
        Navigator.pop(context, true);
      });
    }




    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  Text(args != null ? "Alterar" : "Incluir",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),),
                  TextField(
                    controller: nomeController,
                    decoration: InputDecoration(
                      hintText: "Nome"
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Email"
                    ),
                  ),
                  TextField(
                    controller: telefoneController,
                    decoration: InputDecoration(
                        hintText: "Telefone"
                    ),
                  ),
                  Text("Localização: " + lat.toString() + ', ' + lon.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: ElevatedButton(
                      onPressed: () => {
                        salvarUsuario(
                            nomeController.text,
                            emailController.text,
                            telefoneController.text,

                        )
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        "Salvar",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}