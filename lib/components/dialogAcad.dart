import 'package:flutter/material.dart';

class AcademiaDialog extends StatefulWidget {
  @override
  _AcademiaDialogState createState() => _AcademiaDialogState();
}

class _AcademiaDialogState extends State<AcademiaDialog> {
  String? _selectedAcademia; // Valor selecionado no Dropdown
  final List<String> academias = ['Academia A', 'Academia B', 'Academia C']; // Lista fixa

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Bordas arredondadas
      ),
      title: Center(
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
