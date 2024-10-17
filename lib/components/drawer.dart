import 'package:flutter/material.dart';
import 'package:gym_crowd/pages/introduction.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Método para salvar os dados do login no SharedPreferences
Future<void> saveUserData(String token, String nomeUsuario, String email) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
  await prefs.setString('nome_usuario', nomeUsuario);  
  await prefs.setString('email', email);
}

// Método para excluir o token e os dados do usuário
Future<void> removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token');
  await prefs.remove('nome_usuario');  
  await prefs.remove('email');
}

// Método para buscar os dados do usuário
Future<Map<String, String?>> getUserData() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final nome = prefs.getString('nome_usuario');  
    final email = prefs.getString('email');
    return {'nome': nome, 'email': email};
  } catch (e) {
    print('Erro ao buscar dados do usuário: $e');
    return {'nome': null, 'email': null};
  }
}

Widget buildCustomDrawer(BuildContext context) {
  return FutureBuilder<Map<String, String?>>(
    future: getUserData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return const Center(child: Text('Erro ao carregar dados do usuário'));
      }

      final userData = snapshot.data;
      final nomeUsuario = userData?['nome'];
      final emailUsuario = userData?['email'];

      // Verifica se os dados do usuário são nulos ou vazios
      if (nomeUsuario == null || emailUsuario == null) {
        return const Center(child: Text('Dados do usuário não disponíveis'));
      }

      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Drawer(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Image.asset(
                    'assets/GymCrowdLogo2.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text('Nome: $nomeUsuario'),
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: Text('Email: $emailUsuario'),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6000),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: () async {
                    await removeToken();
                    Navigator.pushReplacement(
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
    },
  );
}
