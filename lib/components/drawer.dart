import 'package:flutter/material.dart';
import 'package:gym_crowd/pages/introduction.dart';



Widget buildCustomDrawer(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.7, // Aumenta a largura do Drawer para 70% da tela
    child: Drawer(
      child: Column(
        children: <Widget>[
          // Adiciona espaçamento no topo da imagem
          Padding(
            padding: const EdgeInsets.only(top: 40.0), // Espaçamento de 16 pixels no topo
            child: Container(
              width: double.infinity,
              height: 150, // Ajuste a altura conforme necessário
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Image.asset(
                'assets/GymCrowdLogo2.png', // Caminho para a imagem no diretório assets
                fit: BoxFit.cover, // Ajusta a imagem para cobrir o espaço disponível
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('Nome: Fulano de Tal'),
          ),
          const ListTile(
            leading: Icon(Icons.email),
            title: Text('Email: fulanodetal@gmail.com'),
          ),
          // Adicione mais itens conforme necessário
          const Spacer(), // Empurra o botão para o final do Drawer
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6000), // Cor laranja
                minimumSize: const Size(double.infinity, 48), // Botão ocupa a largura disponível
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IntroductionPage()),
                );
              },
              child: const Text(
                'Sair',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
