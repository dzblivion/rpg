import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3a3a3a),
      appBar: AppBar(
        backgroundColor: Color(0xffFF5A1F),
        title: Text(
          "Sobre o Nex:",
          style: TextStyle(color: Color(0xff3a3a3a), fontFamily: "UnZialish"),
        ),
        iconTheme: IconThemeData(color: Color(0xff3a3a3a)),
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              "O NEX é um sistema desenvolvido para tornar a criação e o gerenciamento de fichas de RPG mais simples, rápidos e organizados. Inspirado pela experiência de jogadores e mestres de mesa, o aplicativo foi projetado para centralizar todas as informações importantes dos personagens em um único lugar, permitindo acesso fácil e intuitivo durante as sessões.",
              style: TextStyle(
                color: Color(0xffFF5A1F),
                fontFamily: "Bitcount Regular",
              ),
            ),
            Text(
              "Com o NEX, é possível criar personagens personalizados, registrar atributos, níveis, status, habilidades e demais características essenciais da ficha. O sistema busca oferecer praticidade sem abrir mão da imersão, permitindo que os jogadores foquem na narrativa, na estratégia e na evolução de seus personagens.",
              style: TextStyle(
                color: Color(0xffFF5A1F),
                fontFamily: "Bitcount Regular",
              ),
            ),
            Text(
              "Mais do que uma ferramenta de gerenciamento, o NEX representa a união entre tecnologia e criatividade, oferecendo uma experiência moderna para aqueles que desejam organizar suas campanhas e aventuras de forma eficiente.",
              style: TextStyle(
                color: Color(0xffFF5A1F),
                fontFamily: "Bitcount Regular",
              ),
            ),
            Text(
              "Desenvolvido por Antonio Cesar e Lucas Paulino, projeto acadêmico.",
              style: TextStyle(
                color: Color(0xffFF5A1F),
                fontFamily: "Bitcount Regular",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
