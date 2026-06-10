import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nex/pages/cadastro.dart';
import 'dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool senhaOculta = true;

  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  Future<void> entrar() async {
    try {
      final resposta = await http.post(
        Uri.parse("http://127.0.0.1:5000/entrar"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text,
          "senha": senhaController.text,
        }),
      );

      if (!mounted) return;

      final dados = jsonDecode(resposta.body);
      int usuarioId = dados["id"];
      String nickname = dados["nome"];

      if (resposta.statusCode == 201) {
        String token = dados["token"];

        final prefs = await SharedPreferences.getInstance();

        if (!mounted) return;

        await prefs.setString('token', token);
        await prefs.setInt('id', usuarioId);
        await prefs.setString('nome', nickname);
        await prefs.setBool('logado', true);

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(nickname: nickname, id: usuarioId),
          ),
        );

        debugPrint(token);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(dados["mensagem"])));

      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(dados["mensagem"])));
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao conectar com o servidor")),
      );

      debugPrint(e.toString());
    }
  }

  void recuperarSenhaDialog() {
    final emailRecuperacaoController = TextEditingController();
    final codigoRecuperacaoController = TextEditingController();
    final novaSenhaController = TextEditingController();

    String codigoReal = "";
    bool codigoConfirmado = false;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setState) {
            return AlertDialog(
              backgroundColor: const Color(0xff3a3a3a),
              title: const Text(
                "Recuperar Senha",
                style: TextStyle(
                  color: Color(0xffFF5A1F),
                  fontFamily: "INTTERNO",
                ),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: emailRecuperacaoController,
                      style: const TextStyle(
                        color: Color(0xffFFFFFF),
                        fontFamily: "Bitcount Regular",
                        fontSize: 15,
                      ),
                      decoration: const InputDecoration(
                        labelText: "E-mail",
                        labelStyle: TextStyle(
                          fontFamily: "Bitcount Regular",
                          color: Color(0xffFF5A1F),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.hovered)) {
                              return Color(0xffFF5A1F);
                            }
                            return Color(0x80FF5A1F);
                          },
                        ),
                        foregroundColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.hovered)) {
                              return Color(0xffffffff);
                            }
                            return Color(0x80ffffff);
                          },
                        ),
                        side: WidgetStateProperty.all(
                          BorderSide(color: Color(0xffFF5A1F), width: 3),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(50),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        final resposta = await http.post(
                          Uri.parse("http://127.0.0.1:5000/recuperar-senha"),
                          headers: {"Content-Type": "application/json"},
                          body: jsonEncode({
                            "email": emailRecuperacaoController.text,
                          }),
                        );

                        if (!mounted) return;

                        if (resposta.statusCode == 200) {
                          final dados = jsonDecode(resposta.body);

                          setState(() {
                            codigoReal = dados["codigo"].toString();
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Código enviado para o e-mail"),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Enviar código",
                        style: TextStyle(
                          fontFamily: "Bitcount Regular",
                          fontSize: 15,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: codigoRecuperacaoController,
                      style: const TextStyle(
                        color: Color(0xffFFFFFF),
                        fontFamily: "Bitcount Regular",
                        fontSize: 15,
                      ),
                      decoration: const InputDecoration(
                        labelText: "Código",
                        labelStyle: TextStyle(
                          fontFamily: "Bitcount Regular",
                          color: Color(0xffFF5A1F),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.hovered)) {
                              return Color(0xffFF5A1F);
                            }
                            return Color(0x80FF5A1F);
                          },
                        ),
                        foregroundColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.hovered)) {
                              return Color(0xffffffff);
                            }
                            return Color(0x80ffffff);
                          },
                        ),
                        side: WidgetStateProperty.all(
                          BorderSide(color: Color(0xffFF5A1F), width: 3),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(50),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        final resposta = await http.post(
                          Uri.parse(
                            "http://127.0.0.1:5000/utils/verifica-codigo",
                          ),
                          headers: {"Content-Type": "application/json"},
                          body: jsonEncode({
                            "codigo_digitado": codigoRecuperacaoController.text,
                            "codigo_real": codigoReal,
                          }),
                        );

                        if (!mounted) return;

                        if (resposta.statusCode == 200) {
                          setState(() {
                            codigoConfirmado = true;
                          });
                        }
                      },
                      child: const Text(
                        "Confirmar código",
                        style: TextStyle(
                          fontFamily: "Bitcount Regular",
                          fontSize: 15,
                        ),
                      ),
                    ),

                    if (codigoConfirmado) ...[
                      const SizedBox(height: 20),

                      TextField(
                        controller: novaSenhaController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Nova senha",
                        ),
                      ),

                      const SizedBox(height: 15),

                      ElevatedButton(
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
                        ),
                        onPressed: () async {
                          final resposta = await http.patch(
                            Uri.parse(
                              "http://127.0.0.1:5000/utils/atualizar-senha",
                            ),
                            headers: {"Content-Type": "application/json"},
                            body: jsonEncode({
                              "email": emailRecuperacaoController.text,
                              "senha": novaSenhaController.text,
                            }),
                          );

                          if (!mounted) return;

                          if (resposta.statusCode == 200) {
                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Senha atualizada com sucesso"),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Alterar senha",
                          style: TextStyle(fontFamily: "Bitcount Regular"),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
                Column(
                  children: [
                    Text(
                      "Nex  ",
                      style: TextStyle(
                        color: Color(0xffFF5A1F),
                        fontFamily: "UnZialish",
                        fontSize: MediaQuery.of(context).size.height * 0.1,
                      ),
                    ),
                    Text(
                      "é bom te ter de volta!",
                      style: TextStyle(
                        color: Color(0xffFF5A1F),
                        fontFamily: "INTTERNO",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(40),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.80,
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
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      color: Color(0xff8B0F16),
                      fontFamily: "UnZialish",
                      fontSize: 30,
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    style: const TextStyle(
                      color: Color(0xff8B0F16),
                      fontSize: 15,
                      fontFamily: "Bitcount SemiBold",
                    ),
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
                    controller: senhaController,
                    obscureText: senhaOculta,
                    style: const TextStyle(
                      color: Color(0xff8B0F16),
                      fontSize: 15,
                      fontFamily: "Bitcount SemiBold",
                    ),
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: const TextStyle(
                        color: Color(0xff8B0F16),
                        fontSize: 20,
                        fontFamily: "Bitcount Regular",
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            senhaOculta = !senhaOculta;
                          });
                        },
                        icon: Icon(
                          senhaOculta ? Icons.visibility_off : Icons.visibility,
                        ),
                        color: Color(0xff8B0F16),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Esqueceu a senha? ",
                        style: TextStyle(
                          fontFamily: "INTTERNO",
                          color: Color(0xff8B0F16),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          recuperarSenhaDialog();
                        },
                        child: Text(
                          "Recuperar senha",
                          style: TextStyle(
                            fontFamily: "INTTERNO",
                            color: Color(0xff8B0F16),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await entrar();
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
                            "ENTRAR",
                            style: TextStyle(
                              fontFamily: "INTTERNO",
                              fontSize: 25,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "ou faça seu cadastro com",
                          style: TextStyle(
                            fontFamily: "Bitcount Regular",
                            color: Color(0xff8B0F16),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Cadastro(),
                              ),
                            );
                          },
                          icon: Icon(Icons.app_registration_outlined),
                          color: Color(0xff8B0F16),
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
