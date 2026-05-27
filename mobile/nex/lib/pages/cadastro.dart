import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nex/pages/login.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool carregando = false;

  Future<void> registrar() async {
    setState(() {
      carregando = true;
    });

    try {
      final response = await http.post(
        Uri.parse("http://http://127.0.0.1:5000//registrar"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "nome": nomeController.text,
          "email": emailController.text,
          "senha": senhaController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (!mounted) return;

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(data["mensagem"])));

        nomeController.clear();
        emailController.clear();
        senhaController.clear();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(data["mensagem"])));
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao conectar com a API")));
    }

    setState(() {
      carregando = false;
    });
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff3a3a3a),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Nex  ",
                  style: TextStyle(
                    color: Color(0xffFF5A1F),
                    fontFamily: "UnZialish",
                    fontSize: MediaQuery.of(context).size.height * 0.1,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(40),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                color: Color(0xffFF5A1F),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0X25000000),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: Offset(0, -10),
                  ),
                ],
              ),
              child: Column(
                spacing: MediaQuery.of(context).size.height * 0.05,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Criar conta",
                    style: TextStyle(
                      color: Color(0xff8B0F16),
                      fontFamily: "UnZialish",
                      fontSize: 30,
                    ),
                  ),
                  TextField(
                    controller: nomeController,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                      labelText: "Nickname",
                      labelStyle: const TextStyle(
                        color: Color(0xff8B0F16),
                        fontSize: 20,
                        fontFamily: "Bitcount Regular",
                      ),

                      filled: true,
                      fillColor: Color(0x303a3a3a),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xff8B0F16),
                          width: 2,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xff8B0F16),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    controller: nomeController,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                      labelText: "E-mail",
                      labelStyle: const TextStyle(
                        color: Color(0xff8B0F16),
                        fontSize: 20,
                        fontFamily: "Bitcount Regular",
                      ),

                      filled: true,
                      fillColor: Color(0x303a3a3a),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xff8B0F16),
                          width: 2,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xff8B0F16),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    controller: nomeController,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: const TextStyle(
                        color: Color(0xff8B0F16),
                        fontSize: 20,
                        fontFamily: "Bitcount Regular",
                      ),

                      filled: true,
                      fillColor: Color(0x303a3a3a),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xff8B0F16),
                          width: 2,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xff8B0F16),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      spacing: 10,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.resolveWith<Color>((
                                  Set<WidgetState> states,
                                ) {
                                  if (states.contains(WidgetState.hovered)) {
                                    return Color(0xff8B0F16);
                                  }
                                  return Color(0x808B0F16);
                                }),
                            foregroundColor:
                                WidgetStateProperty.resolveWith<Color>((
                                  Set<WidgetState> states,
                                ) {
                                  if (states.contains(WidgetState.hovered)) {
                                    return Color(0xffffffff);
                                  }
                                  return Color(0x80ffffff);
                                }),
                            side: WidgetStateProperty.all(
                              BorderSide(color: Color(0xff8B0F16), width: 3),
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(50),
                              ),
                            ),
                            fixedSize: WidgetStateProperty.all(
                              Size(
                                MediaQuery.of(context).size.width * 0.6,
                                MediaQuery.of(context).size.height * 0.08,
                              ),
                            ),
                          ),
                          child: Text(
                            "Começar",
                            style: TextStyle(
                              fontFamily: "INTTERNO",
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Text(
                          "ou faça login com",
                          style: TextStyle(
                            fontFamily: "Bitcount Regular",
                            color: Color(0xff8B0F16),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.email),
                              color: Color(0xff8B0F16),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.email),
                              color: Color(0xff8B0F16),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.email),
                              color: Color(0xff8B0F16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
