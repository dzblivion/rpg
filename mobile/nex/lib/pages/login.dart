import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                    "Entrar",
                    style: TextStyle(
                      color: Color(0xff8B0F16),
                      fontFamily: "UnZialish",
                      fontSize: 30,
                    ),
                  ),
                  TextField(
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
