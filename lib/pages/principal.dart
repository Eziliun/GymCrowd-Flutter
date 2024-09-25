import 'package:flutter/material.dart';
import 'package:gym_crowd/pages/introduction.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100, // Define a altura da AppBar para acomodar a imagem
        backgroundColor: const Color(0xFFFF6000),
        title: Image.asset(
          'assets/GymCrowdLogoWhite.png', // Caminho para a imagem no diretório assets
          height: 80, // Define a altura da imagem
        ),
        centerTitle: true, // Centraliza a imagem na AppBar
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu,
                color: Colors.white), // Ícone "hamburguer" branco
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width *
            0.7, // Aumenta a largura do Drawer para 70% da tela
        child: Drawer(
          child: Column(
            children: <Widget>[
              // Adiciona espaçamento no topo da imagem
              Padding(
                padding: const EdgeInsets.only(
                    top: 40.0), // Espaçamento de 16 pixels no topo
                child: Container(
                  width: double.infinity,
                  height: 150, // Ajuste a altura conforme necessário
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Image.asset(
                    'assets/GymCrowdLogo2.png', // Caminho para a imagem no diretório assets
                    fit: BoxFit
                        .cover, // Ajusta a imagem para cobrir o espaço disponível
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
                    minimumSize: const Size(double.infinity,
                        48), // Botão ocupa a largura disponível
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IntroductionPage()),
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
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(-3.801716, -38.497009),
          initialZoom: 13.0, // Mudança: 'initialZoom' em vez de 'zoom'
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'], // Usando tiles do OpenStreetMap
          ),
          const MarkerLayer(
            markers: [
              Marker(
                point: LatLng(-3.801716, -38.497009),
                width: 40,
                height: 40,
                child: Icon(
                    Icons.location_on,  // Ícone de localização
                    color: Colors.red,
                    size: 40.0,        // Tamanho do ícone
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
