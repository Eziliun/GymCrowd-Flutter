import 'package:flutter/material.dart';
import 'package:gym_crowd/components/dialogAcad.dart';
import 'package:gym_crowd/components/drawer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gym_crowd/services/api_service.dart'; // Importe o ApiService
import 'package:gym_crowd/models/academia_modelo.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  LatLng? _currentLocation;
  List<LatLng> academiasLocations = [];
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _fetchAcademiaLocations();
  }

  Future<void> _fetchAcademiaLocations() async {
    try {
      List<AcademiaModelo> academias = await apiService.fetchAcademias();
      setState(() {
        academiasLocations = academias
            .map((academia) => LatLng(academia.latitude, academia.longitude))
            .toList();
      });
    } catch (e) {
      print('Erro ao buscar localizações de academias: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationAlert(
        'Serviço de localização desativado',
        'Por favor, ative o serviço de localização do dispositivo.',
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showLocationAlert(
          'Permissão negada',
          'O aplicativo precisa da sua permissão para acessar a localização.',
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showLocationAlert(
        'Permissão negada permanentemente',
        'Por favor, permita o acesso à localização nas configurações do dispositivo.',
      );
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print('Erro ao obter a localização: $e');
    }
  }

  void _showLocationAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
            icon: const Icon(Icons.menu, color: Colors.white), // Ícone "hamburguer" branco
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: buildCustomDrawer(context),
      body: _currentLocation == null
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6000)), // Cor laranja
              ),
            ) // Mostra indicador de carregamento com cor laranja
          : FlutterMap(
              options: MapOptions(
                initialCenter: _currentLocation!,
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'], // Usando tiles do OpenStreetMap
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentLocation!,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_on, // Ícone de localização
                        color: Colors.red,
                        size: 40.0, // Tamanho do ícone
                      ),
                    ),
                    for (var location in academiasLocations)
                      Marker(
                        point: location,
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.blue,
                          size: 40.0,
                        ),
                      ),
                  ],
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAcademiaDialog(context); // Chama a função para exibir o dialog
        },
        backgroundColor: const Color(0xFFFF6000), // Cor de fundo laranja
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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