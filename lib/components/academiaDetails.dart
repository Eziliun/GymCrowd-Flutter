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
      // Cabeçalho estilizado
      Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color:  Color(0xFFFF6000), // Cor de destaque
          borderRadius:  BorderRadius.vertical(top: Radius.circular(16.0)), // Bordas arredondadas na parte superior
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: const Text(
          'Informações da Academia',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // Conteúdo principal estilizado
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16.0)), // Bordas arredondadas na parte inferior
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Sombra leve
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nome da academia
            Row(
              children: [
                const Icon(Icons.fitness_center, color: Color(0xFFFF6000), size: 28), // Ícone de academia
                const SizedBox(width: 8),
                Text(
                  nome,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Endereço
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, color: Colors.grey, size: 24), // Ícone de localização
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    endereco,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Lotação
            Row(
              children: [
                const Icon(Icons.people, color: Colors.grey, size: 24), // Ícone de pessoas
                const SizedBox(width: 8),
                Text(
                  'Lotação: $lotacao%',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
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
