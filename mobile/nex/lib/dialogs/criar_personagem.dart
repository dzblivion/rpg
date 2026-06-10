import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CriarPersonagemDialog extends StatefulWidget {
  const CriarPersonagemDialog({super.key});

  @override
  State<CriarPersonagemDialog> createState() => _CriarPersonagemDialogState();
}

class _CriarPersonagemDialogState extends State<CriarPersonagemDialog> {
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

  Future<void> criarPersonagem() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int? usuarioId = prefs.getInt("id");

      if (usuarioId == null) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Usuário não encontrado. Faça login novamente."),
          ),
        );
        return;
      }

      final response = await http.post(
        Uri.parse("http://127.0.0.1:5000/personagens"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "usuario_id": usuarioId,
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

      final dados = jsonDecode(response.body);

      if (response.statusCode == 201) {
        Navigator.pop(context, true);

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

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro: $e")));
    }
  }

  Widget campoNumero(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Criar Personagem"),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: "Nome"),
              ),

              TextField(
                controller: classeController,
                decoration: const InputDecoration(labelText: "Classe"),
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
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancelar"),
        ),
        ElevatedButton(onPressed: criarPersonagem, child: const Text("Criar")),
      ],
    );
  }
}
