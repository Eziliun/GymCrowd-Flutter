import 'package:flutter/material.dart';
import 'package:gym_crowd/components/dialogAcad.dart';
import 'package:gym_crowd/components/drawer.dart';
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
      drawer:  buildCustomDrawer(context),
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
      // Código adicionado para incluir o FloatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAcademiaDialog(context); // Chama a função para exibir o dialog
        },
        backgroundColor: Colors.orange, // Cor de fundo laranja
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Localização no canto inferior direito
    );
  }

  // Função separada para exibir o AcademiaDialog
  void showAcademiaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AcademiaDialog(); // Exibe o componente AcademiaDialog
      },
    );
  }
}
