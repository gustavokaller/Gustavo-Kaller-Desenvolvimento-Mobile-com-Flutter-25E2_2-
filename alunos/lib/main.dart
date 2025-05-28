import 'package:alunos/pages/cadastro_page.dart';
import 'package:alunos/pages/home_page.dart';
import 'package:alunos/pages/login_page.dart';
import 'package:alunos/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Alunos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      routes: {
        Routes.LOGIN: (context) => LoginPage(),
        Routes.HOME: (context) => HomePage(title: 'Lista de Alunos'),
        Routes.CADASTRO: (context) => CadastroPage(title: 'Aluno'),
      },
    );
  }
}


