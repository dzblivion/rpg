import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditarPersonagemDialog extends StatefulWidget {
  final Map<String, dynamic> personagem;

  const EditarPersonagemDialog({super.key, required this.personagem});

  @override
  State<EditarPersonagemDialog> createState() => _EditarPersonagemDialogState();
}

class _EditarPersonagemDialogState extends State<EditarPersonagemDialog> {
  final nomeController = TextEditingController();
  final classeController = TextEditingController();
  final nivelController = TextEditingController();
  final nexController = TextEditingController();
  final hpController = TextEditingController();
  final sanidadeController = TextEditingController();
  final forcaController = TextEditingController();
  final agilidadeController = TextEditingController();
  final intelectoController = TextEditingController();
  final presencaController = TextEditingController();
  final vigorController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nomeController.text = widget.personagem["nome"].toString();
    classeController.text = widget.personagem["classe"].toString();
    nivelController.text = widget.personagem["nivel"].toString();
    nexController.text = widget.personagem["nex"].toString();
    hpController.text = widget.personagem["hp"].toString();
    sanidadeController.text = widget.personagem["sanidade"].toString();
    forcaController.text = widget.personagem["forca"].toString();
    agilidadeController.text = widget.personagem["agilidade"].toString();
    intelectoController.text = widget.personagem["intelecto"].toString();
    presencaController.text = widget.personagem["presenca"].toString();
    vigorController.text = widget.personagem["vigor"].toString();
  }

  Future<void> editarPersonagem() async {
    try {
      await http.put(
        Uri.parse(
          "http://127.0.0.1:5000/personagens/${widget.personagem["id"]}",
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "nome": nomeController.text,
          "classe": classeController.text,
          "nivel": int.parse(nivelController.text),
          "nex": int.parse(nexController.text),
          "hp": int.parse(hpController.text),
          "sanidade": int.parse(sanidadeController.text),
          "forca": int.parse(forcaController.text),
          "agilidade": int.parse(agilidadeController.text),
          "intelecto": int.parse(intelectoController.text),
          "presenca": int.parse(presencaController.text),
          "vigor": int.parse(vigorController.text),
        }),
      );

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro: $e")));
    }
  }

  Widget campoNumero(TextEditingController controller, String label) {
    return TextField(
      style: TextStyle(
        fontFamily: "Bitcount Regular",
        color: Color(0xff3a3a3a),
      ),
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontFamily: "Bitcount Regular",
          color: Color(0xffffffff),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xffFF5A1F),
      title: Text(
        "Editar Personagem",
        style: TextStyle(color: Color(0xffffffff), fontFamily: "UnZialish"),
      ),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: TextStyle(
                  fontFamily: "Bitcount Regular",
                  color: Color(0xff3a3a3a),
                ),
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome",
                  labelStyle: TextStyle(
                    fontFamily: "Bitcount Regular",
                    color: Color(0xffffffff),
                  ),
                ),
              ),

              TextField(
                style: TextStyle(
                  fontFamily: "Bitcount Regular",
                  color: Color(0xff3a3a3a),
                ),
                controller: classeController,
                decoration: const InputDecoration(
                  labelText: "Classe",
                  labelStyle: TextStyle(
                    fontFamily: "Bitcount Regular",
                    color: Color(0xffffffff),
                  ),
                ),
              ),

              campoNumero(nivelController, "Nível"),
              campoNumero(nexController, "NEX"),
              campoNumero(hpController, "HP"),
              campoNumero(sanidadeController, "Sanidade"),
              campoNumero(forcaController, "Força"),
              campoNumero(agilidadeController, "Agilidade"),
              campoNumero(intelectoController, "Intelecto"),
              campoNumero(presencaController, "Presença"),
              campoNumero(vigorController, "Vigor"),
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
            backgroundColor: Color(0xffffffff),
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Cancelar",
            style: TextStyle(color: Color(0xff3a3a3a), fontFamily: "INTTERNO"),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Color(0xff3a3a3a),
          ),
          onPressed: editarPersonagem,
          child: const Text(
            "Salvar",
            style: TextStyle(color: Color(0xffffffff), fontFamily: "INTTERNO"),
          ),
        ),
      ],
    );
  }
}
