import 'package:flutter/material.dart';
import 'package:secondapp/pages/home_page.dart';
import 'package:secondapp/pages/dados_cadastrais/cadastro_page_shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController =
      TextEditingController(text: "julio@gmail.com");
  final TextEditingController _senhaController =
      TextEditingController(text: "julio123");

  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Expanded(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(children: [
              //image
              Row(
                children: [
                  Expanded(child: Container()),
                  Expanded(
                    flex: 9,
                    child: Image.network(
                      "https://hermes.digitalinnovation.one/assets/diome/logo.png",
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const Text('Ja tem Cadastro',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(
                height: 5,
              ),
              const Text('Faça seu login e make the change_',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                      color: Colors.white)),
              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: _emailController,
                style: const TextStyle(fontSize: 20, color: Colors.white),
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.purpleAccent,
                  ),
                  contentPadding: EdgeInsets.only(top: 3),
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _senhaController,
                style: const TextStyle(fontSize: 20, color: Colors.white),
                obscureText: obscure,
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.purpleAccent,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      icon: Icon(
                        obscure ? Icons.visibility : Icons.visibility_off,
                        color: Colors.purpleAccent,
                      )),
                  contentPadding: const EdgeInsets.only(top: 0),
                  hintText: 'Senha',
                  hintStyle: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {
                      if (_emailController.text == "julio@gmail.com" &&
                          _senhaController.text == "julio123") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage()));
                      } else {
                        showDialog(
                            context: context,
                            builder: (((context) {
                              return AlertDialog(
                                title: const Text("Erro ao realizar login"),
                                content:
                                    const Text("Login ou senha incorreto!"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "OK",
                                        style: TextStyle(color: Colors.green),
                                      ))
                                ],
                              );
                            })));
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.purpleAccent,
                    ),
                    child: const Text('ENTRAR',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
              ),
              const SizedBox(
                height: 60,
              ),
              const Text('Esqueci minha senha',
                  style: TextStyle(fontSize: 16, color: Colors.yellow)),
              const SizedBox(height: 10),
              const Text('Criar conta',
                  style: TextStyle(fontSize: 16, color: Colors.green))
            ]),
          ),
        )),
      ),
    );
  }
}
