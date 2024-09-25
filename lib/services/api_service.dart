/*import 'dart:convert'; // Para converter entre JSON e Map
import 'package:http/http.dart' as http; // Pacote para fazer requisições HTTP
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Para armazenar dados de forma segura
import '../models/login_modelo.dart'; // Importa o modelo de dados

// Classe que lida com as requisições à API
class ApiService {
  final String baseUrl = 'https://suaapi.com'; // URL base da API
  //final storage = FlutterSecureStorage(); // Instância para armazenar tokens de forma segura

  // Função para registrar um usuário na API
  Future<void> registerUser(LoginModelo user) async {
    // Faz uma requisição POST para o endpoint de registro
    final response = await http.post(
      Uri.parse('$baseUrl/register'), // Monta a URL da API
      headers: <String, String>{
        'Content-Type': 'application/json', // Define o tipo de conteúdo como JSON
      },
      body: jsonEncode(user.toJson()),  // Converte o objeto user para JSON
    );

    // Verifica se o registro foi bem-sucedido
    if (response.statusCode == 200) {
      // Caso o status seja 200, o registro foi bem-sucedido
      print('Usuário registrado com sucesso!');
    } else {
      // Caso contrário, ocorreu um erro
      throw Exception('Erro ao registrar usuário');
    }
  }

  // Função para fazer login na API
  Future<void> login(String email, String senha) async {
    // Faz uma requisição POST para o endpoint de login
    final response = await http.post(
      Uri.parse('$baseUrl/login'), // Monta a URL da API
      headers: <String, String>{
        'Content-Type': 'application/json', // Define o tipo de conteúdo como JSON
      },
      body: jsonEncode({'email': email, 'senha': senha}), // Converte email e senha para JSON
    );

    // Verifica se o login foi bem-sucedido
    if (response.statusCode == 200) {
      // Armazena o token de autenticação
      var data = jsonDecode(response.body); // Converte o corpo da resposta para Map
      await storage.write(key: 'token', value: data['token']); // Armazena o token de forma segura
      print('Login realizado com sucesso!');
    } else {
      // Caso contrário, ocorreu um erro
      throw Exception('Erro ao fazer login');
    }
  }
}*/
