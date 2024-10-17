import 'package:flutter/material.dart';
import 'package:gym_crowd/services/api_service.dart'; // Certifique-se de que o caminho esteja correto

class AcademiaDialog extends StatefulWidget {
  @override
  _AcademiaDialogState createState() => _AcademiaDialogState();
}

class _AcademiaDialogState extends State<AcademiaDialog> {
  String? _selectedAcademia; // Valor selecionado no Dropdown
  List<String> academias = []; // Lista para armazenar academias

  @override
  void initState() {
    super.initState();
    fetchAcademias(); // Chama a função para buscar as academias ao iniciar
  }

  Future<void> fetchAcademias() async {
    ApiService apiService = ApiService();
    try {
      // Obtém as academias da API
      academias = await apiService.fetchAcademias();
      setState(() {}); // Atualiza o estado para refletir as academias carregadas
    } catch (e) {
      print('Erro ao buscar academias: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Bordas arredondadas
      ),
      title: const Center(
        child: Text(
          'Selecione uma Academia',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      content: SizedBox(
        height: 100, // Ajuste conforme necessário
        child: DropdownButton<String>(
          isExpanded: true,
          value: _selectedAcademia,
          hint: Text('Escolha uma academia'),
          items: academias.map((academia) {
            return DropdownMenuItem<String>(
              value: academia,
              child: Text(academia),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedAcademia = value; // Atualiza a academia selecionada
            });
          },
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6000), // Cor laranja
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Apenas fecha o diálogo
            },
            child: const Text(
              'Confirmar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
