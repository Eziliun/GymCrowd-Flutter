import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF6000),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/GymCrowdLogo2.png', // Caminho para a imagem no diretório assets
                height: 300, // Altura da imagem
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Nome de Usuário',
                  labelStyle: TextStyle(color: Color(0xFFFF6000)),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xFFFF6000)),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'CPF',
                  labelStyle: TextStyle(color: Color(0xFFFF6000)),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: Color(0xFFFF6000)),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
                  labelStyle: TextStyle(color: Color(0xFFFF6000)),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6000),
                      minimumSize: const Size(300, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Adicione a lógica de registro aqui
                    },
                    child: const Text('Enviar',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
