import 'package:flutter/material.dart';

class AcademiaDetailsBottomSheet extends StatelessWidget {
  final String nome;
  final String endereco;
  final int lotacao;

  const AcademiaDetailsBottomSheet({
    Key? key,
    required this.nome,
    required this.endereco,
    required this.lotacao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          color: const Color(0xFFFF6000), 
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: const Text(
            'Informações da academia',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white, 
              fontSize: 20, 
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Conteúdo principal
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nome,
                style: const TextStyle(
                  fontSize: 22, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12), 
              Row(
                children: [
                  const Text(
                    'Endereço: ',
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$endereco',
                    style: const TextStyle(
                      fontSize: 18, 
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12), 
              Row(
                children: [
                  const Text(
                    'Lotação: ',
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$lotacao%',
                    style: const TextStyle(
                      fontSize: 18, 
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
