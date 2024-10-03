import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gym_crowd/models/login_modelo.dart'; // Importe o model que você criou

class ApiService {
  // Base URL da API
  final String baseUrl = 'http://192.168.0.13:5000';

  // Método para criar um novo usuário
  Future<void> createUser(LoginModelo user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register_user'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Usuário criado com sucesso');
      } else {
        print('Erro ao criar usuário: ${response.body}');
        throw Exception('Erro ao criar usuário: ${response.statusCode}');
      }
    } catch (e) {
      print('Exceção capturada: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  // Método para fazer login
Future<void> loginUser(String email, String password) async {
  try {
    // Monta o corpo da requisição com as credenciais
    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password,
    };

    // Faz a requisição POST para o endpoint de login
    final response = await http.post(
      Uri.parse('$baseUrl/login_user'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginData),
    );

    // Verifica se o login foi bem-sucedido
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Login bem-sucedido: ${responseData['message']}');

      // Aqui você pode tratar a resposta, como salvar um token de autenticação
      // ou redirecionar o usuário
    } else {
      print('Erro ao fazer login: ${response.body}');
      throw Exception('Erro ao fazer login: ${response.statusCode}');
    }
  } catch (e) {
    print('Exceção capturada: $e');
    throw Exception('Erro de conexão: $e');
  }
}
}

