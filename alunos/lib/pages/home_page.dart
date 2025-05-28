import 'dart:ffi';

import 'package:alunos/routes.dart';
import 'package:flutter/material.dart';

import '../models/mock_alunos.dart';
import '../models/aluno.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final listaUsuarios = USUARIOS_MOCK;

  void alterarAluno(index){
    Navigator.pushNamed(context, Routes.CADASTRO, arguments: listaUsuarios[index]).then((value) {
      if (value == true) {
        setState(() {});
      }
    });
  }

  void excluirAluno(index) {
    setState(() {
      listaUsuarios.removeAt(index);
    });
  }

  void novoAluno() {
    Navigator.pushNamed(context, Routes.CADASTRO);
  }

  Widget gerarItemLista(index, bool isPortrait) {
    final usuario = listaUsuarios[index];

    return
      isPortrait ?
      Card(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            title: Text(usuario.name, style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.mail, color: Colors.black54),
                    SizedBox(width: 4),
                    Text(usuario.email),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.black54),
                    SizedBox(width: 4),
                    Text(usuario.telefone),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.black54),
                    SizedBox(width: 4),
                    Text('${usuario.latitude}, ${usuario.longitude}'),
                  ],
                )
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blueAccent),
                  onPressed: () {
                    alterarAluno(index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red[200]),
                  onPressed: () {
                    excluirAluno(index);
                  },
                ),
              ],
            ),
          ),
        )
    :
      Card(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(usuario.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.mail, color: Colors.black54),
                    SizedBox(width: 4),
                    Text(usuario.email),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.black54),
                    SizedBox(width: 4),
                    Text(usuario.telefone),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.black54),
                    SizedBox(width: 4),
                    Text('${usuario.latitude}, ${usuario.longitude}'),
                  ],
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blueAccent),
                  onPressed: () {
                    alterarAluno(index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red[200]),
                  onPressed: () {
                    excluirAluno(index);
                  },
                ),
              ],
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {


    final appBar = AppBar(
                        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                        title: Text(widget.title),
      actions: [
        Text("${listaUsuarios.length} Alunos cadastrados")
      ],
                      );
    final mediaQuery = MediaQuery.of(context);
    final bool isPortrait = mediaQuery.orientation == Orientation.portrait;
    final height = mediaQuery.size.height - mediaQuery.padding.top - appBar.preferredSize.height;

    final nomeController = TextEditingController();
    final emailController = TextEditingController();
    final telefoneController = TextEditingController();

    return Scaffold(
      appBar: appBar,
      body: ListView.builder(
                itemCount: USUARIOS_MOCK.length,
                itemBuilder: (context, index){
                  return gerarItemLista(index, isPortrait);
                },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: novoAluno,
        child: Icon(Icons.add),
        tooltip: "Adicionar novo aluno",
      ),




    );
  }
}