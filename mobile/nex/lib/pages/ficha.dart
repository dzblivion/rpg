import 'package:flutter/material.dart';

class CardAgente extends StatelessWidget {
  final String nome;
  final String especialidade;

  const CardAgente({
    super.key,
    required this.nome,
    required this.especialidade,
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
              color: Colors.white,
              border: Border.all(color: Color(0xffFF5A1F), width: 3),
            ),
            child: Icon(Icons.person, color: Color(0xffFF5A1F), size: 40),
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
              SizedBox(height: 35),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFF5A1F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "ACESSAR FICHA",
                  style: TextStyle(
                    fontFamily: "INTTERNO",
                    color: Color(0xffFFFFFf),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
