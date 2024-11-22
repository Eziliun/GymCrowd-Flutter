import 'package:flutter/material.dart';
import 'package:gym_crowd/components/academiaDetails.dart';
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
  List<Map<String, dynamic>> academiasLocations = [];
  final ApiService apiService = ApiService();
  MapController mapController = MapController();

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
        academiasLocations = academias.map((academia) {
          return {
            'location': LatLng(academia.latitude, academia.longitude),
            'nome': academia.nome_fantasia,
            'lotacao': academia.lotacao, 
            'endereco': academia.endereco, 
          };
        }).toList();
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
            icon: const Icon(Icons.menu,
                color: Colors.white), // Ícone "hamburguer" branco
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
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFFFF6000)), // Cor laranja
              ),
            ) // Mostra indicador de carregamento com cor laranja
          : FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: _currentLocation!,
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'], // Usando tiles do OpenStreetMap
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentLocation!,
                      width: 50, 
                      height: 50, 
                      child: GestureDetector(
                        onTap: () {
                          // Ação ao clicar no marcador
                          print("Marcador da localização atual clicado!");
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(
                                    0.8), // Fundo semi-transparente
                                shape: BoxShape.circle, // Formato circular
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.3), // Sombra leve
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons
                                  .person, // Ícone de localização mais tradicional
                              color: Colors.white, // Cor do ícone
                              size: 30, // Tamanho do ícone
                            ),
                          ],
                        ),
                      ),
                    ),
                    for (var location in academiasLocations)
                      Marker(
                        point: location['location'],
                        width: 50, 
                        height: 50, 
                        child: GestureDetector(
                          onTap: () {
                            _showAcademiaDetails(context,
                                location); 
                            mapController.move(location['location'],
                                14); 
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(
                                      0.8), // Fundo semi-transparente azul
                                  shape: BoxShape.circle, // Formato circular
                                  border: Border.all(
                                    color: Colors
                                        .white, // Borda branca para destaque
                                    width: 2.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.3), // Sombra leve
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons
                                    .fitness_center, // Ícone relacionado à academia
                                color: Colors.white, // Cor do ícone
                                size: 30, // Tamanho do ícone
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Botão de redefinir zoom
          FloatingActionButton(
            heroTag: 'resetZoom',
            onPressed: () {
              mapController.move(
                  _currentLocation!, 13.0); // Volta ao zoom inicial
            },
            backgroundColor: const Color(0xFFFF6000),
            child: const Icon(Icons.zoom_out_map, color: Colors.white),
          ),
          const SizedBox(height: 16), // Espaço entre os botões
          // Botão existente
          FloatingActionButton(
            heroTag: 'addAcademia',
            onPressed: () {
              showAcademiaDialog(context);
            },
            backgroundColor: const Color(0xFFFF6000),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
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

void _showAcademiaDetails(BuildContext context, Map<String, dynamic> academia) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return AcademiaDetailsBottomSheet(
        nome: academia['nome'],
        endereco: academia['endereco'],
        lotacao: academia['lotacao'], // Passa a lotação para o componente
      );
    },
  );
}
