import 'package:flutter/material.dart';
import 'package:nex/dialogs/editar_personagem.dart';

class CardAgente extends StatelessWidget {
  final Map<String, dynamic> personagem;
  final String nome;
  final String especialidade;
  final VoidCallback onDelete;
  final VoidCallback onAtualizar;

  const CardAgente({
    super.key,
    required this.personagem,
    required this.nome,
    required this.especialidade,
    required this.onDelete,
    required this.onAtualizar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0x40FF5A1F),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Color(0xff8B0F16),
              border: Border.all(color: Color(0xffFF5A1F), width: 3),
            ),
            child: Icon(
              Icons.perm_contact_cal_rounded,
              color: Color(0xffFF5A1F),
              size: 40,
            ),
          ),

          SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  nome,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: "UnZialish",
                    color: Color(0xffFFFFFF),
                  ),
                ),

                Text(
                  especialidade,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "INTTERNO",
                    color: Color(0xffFFFFFF),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 25),
              Row(
                spacing: 5,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFF5A1F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: const Color(0x15ffffff),
                            title: Text(
                              personagem["nome"],
                              style: TextStyle(
                                color: Color(0xffFF5A1F),
                                fontFamily: "UnZialish",
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/card_nex.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Classe: ${personagem["classe"]}",
                                      style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontFamily: "INTTERNO",
                                      ),
                                    ),
                                    Text(
                                      "Nível: ${personagem["nivel"]}",
                                      style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontFamily: "INTTERNO",
                                      ),
                                    ),
                                    Text(
                                      "NEX: ${personagem["nex"]}",
                                      style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontFamily: "INTTERNO",
                                      ),
                                    ),
                                    Text(
                                      "HP: ${personagem["hp"]}",
                                      style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontFamily: "INTTERNO",
                                      ),
                                    ),
                                    Text(
                                      "Sanidade: ${personagem["sanidade"]}",
                                      style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontFamily: "INTTERNO",
                                      ),
                                    ),
                                    Text(
                                      "Força: ${personagem["forca"]}",
                                      style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontFamily: "INTTERNO",
                                      ),
                                    ),
                                    Text(
                                      "Agilidade: ${personagem["agilidade"]}",
                                      style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontFamily: "INTTERNO",
                                      ),
                                    ),
                                    Text(
                                      "Intelecto: ${personagem["intelecto"]}",
                                      style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontFamily: "INTTERNO",
                                      ),
                                    ),
                                    Text(
                                      "Presença: ${personagem["presenca"]}",
                                      style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontFamily: "INTTERNO",
                                      ),
                                    ),
                                    Text(
                                      "Vigor: ${personagem["vigor"]}",
                                      style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontFamily: "INTTERNO",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  backgroundColor: Color(0xffFF5A1F),
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);

                                  final resultado = await showDialog(
                                    context: context,
                                    builder: (_) => EditarPersonagemDialog(
                                      personagem: personagem,
                                    ),
                                  );

                                  if (resultado == true) {
                                    onAtualizar();
                                  }
                                },
                                child: const Text(
                                  "Editar",
                                  style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontFamily: "INTTERNO",
                                  ),
                                ),
                              ),

                              TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  backgroundColor: Color(0xffFF5A1F),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Fechar",
                                  style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontFamily: "INTTERNO",
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "ACESSAR FICHA",
                      style: TextStyle(
                        fontFamily: "INTTERNO",
                        color: Color(0xffFFFFFf),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff8B0F16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: onDelete,
                    child: const Text(
                      "EXCLUIR",
                      style: TextStyle(
                        fontFamily: "INTTERNO",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
