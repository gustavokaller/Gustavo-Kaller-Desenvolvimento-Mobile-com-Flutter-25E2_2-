import 'package:alunos/pages/home_page.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

class LoginPage extends StatelessWidget {

  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  void autenticar(BuildContext context){
    Navigator.pushNamed(context, Routes.HOME);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ACESSO AO APP",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Informe seus dados de acesso abaixo",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "Email"
                ),
              ),
              TextField(
                controller: senhaController,
                decoration: InputDecoration(
                    hintText: "Senha"
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: ElevatedButton(
                    onPressed: () {
                      //auth
                      autenticar(context);
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
                    child: Text("Acessar")
                ),
              ),
              Text("* como se trata de um teste. não é necessário informar login e senha no momento. Clique apenas no botão Acessar.",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}