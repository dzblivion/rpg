import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nex/dialogs/criar_personagem.dart';
import 'package:nex/pages/initial.dart';
import 'info.dart';
import 'ficha.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  final String nickname;
  final int id;
  const Dashboard({super.key, required this.nickname, required this.id});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<dynamic> personagens = [];

  @override
  void initState() {
    super.initState();
    listarPersonagens();
  }

  Future<void> listarPersonagens() async {
    final prefs = await SharedPreferences.getInstance();
    int? usuarioId = prefs.getInt("id");

    final response = await http.get(
      Uri.parse("http://127.0.0.1:5000/personagens?usuario_id=$usuarioId"),
    );

    if (response.statusCode == 200) {
      final dados = jsonDecode(response.body);

      if (!mounted) return;

      setState(() {
        personagens = dados["personagens"];
      });
    }
  }

  Future<void> deletarPersonagem(int personagemId) async {
    try {
      final response = await http.delete(
        Uri.parse("http://127.0.0.1:5000/personagens/$personagemId"),
      );

      if (response.statusCode == 200) {
        await listarPersonagens();

        if (!mounted) return;

        final dados = jsonDecode(response.body);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(dados["mensagem"])));
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao deletar personagem")));
    }
  }

  Future<void> confirmarSaida() async {
    final resultado = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xff3a3a3a),
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${widget.nickname}, ",
                  style: TextStyle(
                    fontFamily: "Bitcount SemiBold",
                    color: Color(0xffFF5A1F),
                    fontSize: 25,
                  ),
                ),
                TextSpan(
                  text: "você deseja sair?",
                  style: TextStyle(
                    fontFamily: "Bitcount Regular",
                    color: Color(0xffFF5A1F),
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Color(0xffffffff)),
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                "Cancelar",
                style: TextStyle(
                  fontFamily: "Bitcount SemiBold",
                  color: Color(0xffFF5A1F),
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Color(0xffffffff)),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                "Sair",
                style: TextStyle(
                  fontFamily: "Bitcount SemiBold",
                  color: Color(0xffFF5A1F),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (resultado == true) {
      await sair();
    }
  }

  Future<void> sair() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => InitialApp()),
    );
  }

  List agentes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 200,
        backgroundColor: Color(0xffFF5A1F),
        child: Column(
          spacing: 20,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
              ),
            ),
            Text(
              "Nex",
              style: TextStyle(
                color: Color(0xff3a3a3a),
                fontSize: 50,
                fontFamily: "UnZialish",
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard, color: Color(0xff3a3a3a)),
              title: Text(
                "Dashboard",
                style: TextStyle(
                  color: Color(0xff3a3a3a),
                  fontFamily: "Bitcount SemiBold",
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Color(0xff3a3a3a)),
              title: Text(
                "Sobre",
                style: TextStyle(
                  color: Color(0xff3a3a3a),
                  fontFamily: "Bitcount SemiBold",
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Info()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Color(0xff3a3a3a)),
              title: Text(
                "Sair",
                style: TextStyle(
                  color: Color(0xff3a3a3a),
                  fontFamily: "Bitcount SemiBold",
                ),
              ),
              onTap: confirmarSaida,
            ),
          ],
        ),
      ),
      body: Container(
        color: Color(0xff3a3a3a),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1600),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffFF5A1F),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Color(0xff3a3a3a),
                                  ),
                                ),

                                SizedBox(width: 20),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Olá,",
                                      style: TextStyle(
                                        color: Color(0xffFF5A1F),
                                        fontFamily: "Bitcount Regular",
                                        fontSize: 20,
                                        height: 1,
                                      ),
                                    ),

                                    Text(
                                      widget.nickname,
                                      style: TextStyle(
                                        color: Color(0xffFF5A1F),
                                        fontFamily: "Bitcount SemiBold",
                                        fontSize: 35,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0x80FF5A1F),
                            ),
                            onPressed: () async {
                              final criado = await showDialog<bool>(
                                context: context,
                                builder: (_) => const CriarPersonagemDialog(),
                              );

                              if (criado == true) {
                                await listarPersonagens();
                              }
                            },
                            child: Text(
                              "CRIAR PERSONAGEM",
                              style: TextStyle(
                                fontFamily: "INTTERNO",
                                color: Color(0xffFF5A1F),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Text(
                    "AGENTES",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xffFF5A1F),
                      fontFamily: "INTTERNO",
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: personagens.length,
                      itemBuilder: (context, index) {
                        return CardAgente(
                          personagem: personagens[index],
                          nome: personagens[index]["nome"],
                          especialidade: personagens[index]["classe"],
                          onDelete: () async {
                            bool? confirmar = await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Color(0xff3a3a3a),
                                  title: const Text(
                                    "Excluir Personagem",
                                    style: TextStyle(
                                      color: Color(0xffFF5A1F),
                                      fontFamily: "Bitcount SemiBold",
                                    ),
                                  ),
                                  content: Text(
                                    "Deseja excluir ${personagens[index]["nome"]}?",
                                    style: TextStyle(
                                      color: Color(0xffFF5A1F),
                                      fontFamily: "Bitcount Regular",
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        backgroundColor: Color(0xffffffff),
                                      ),
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text(
                                        "Cancelar",
                                        style: TextStyle(
                                          color: Color(0xffFF5A1F),
                                          fontFamily: "INTTERNO",
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        backgroundColor: Color(0xffffffff),
                                      ),
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text(
                                        "Excluir",
                                        style: TextStyle(
                                          color: Color(0xffFF5A1F),
                                          fontFamily: "INTTERNO",
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirmar == true) {
                              await deletarPersonagem(personagens[index]["id"]);
                            }
                          },
                          onAtualizar: listarPersonagens,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
