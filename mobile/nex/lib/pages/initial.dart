import 'package:flutter/material.dart';
import 'package:nex/pages/cadastro.dart';

class InitialApp extends StatefulWidget {
  const InitialApp({super.key});

  @override
  State<InitialApp> createState() => _InitialAppState();
}

class _InitialAppState extends State<InitialApp> {
  @override
  Widget build(BuildContext context) {
    double responsive = MediaQuery.of(context).size.shortestSide;
    return Scaffold(
      backgroundColor: Color(0xff3A3A3A),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(responsive * 0.15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  Text(
                    "Nex",
                    style: TextStyle(
                      fontSize: responsive * 0.15,
                      color: Color(0xffFF5A1F),
                      fontFamily: "UnZialish",
                    ),
                  ),
                  Text(
                    "Quando o nex aumenta, a realidade enfraquece.",
                    style: TextStyle(
                      fontSize: responsive * 0.02,
                      color: Color(0xffFF5A1F),
                      fontFamily: "INTTERNO",
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Cadastro()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>((
                        Set<WidgetState> states,
                      ) {
                        if (states.contains(WidgetState.hovered)) {
                          return Color(0xffFF5A1F);
                        }
                        return Color(0x80FF5A1F);
                      }),
                      foregroundColor: WidgetStateProperty.resolveWith<Color>((
                        Set<WidgetState> states,
                      ) {
                        if (states.contains(WidgetState.hovered)) {
                          return Color(0xffffffff);
                        }
                        return Color(0xff3a3a3a);
                      }),
                      side: WidgetStateProperty.all(
                        BorderSide(color: Color(0xffFF5A1F), width: 3),
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
                        fontSize: responsive * 0.05,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Já tem uma conta? ",
                        style: TextStyle(
                          fontFamily: "Bitcount Regular",
                          color: Color(0xffFF5A1F),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Cadastro()),
                          );
                        },
                        child: Text(
                          "Entrar",
                          style: TextStyle(
                            fontFamily: "Bitcount SemiBold",
                            color: Color(0xffFF5A1F),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
