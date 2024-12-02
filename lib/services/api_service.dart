import 'dart:convert';
import 'package:gym_crowd/models/academia_modelo.dart';
import 'package:http/http.dart' as http;
import 'package:gym_crowd/models/login_modelo.dart';
import 'package:shared_preferences/shared_preferences.dart'; 

class ApiService {
  // Base URL da API
  final String baseUrl = 'http://192.168.1.109:5000';

  // Método para salvar o token no armazenamento local
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Método para buscar o token salvo
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }


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
      final token = responseData['token'];  
      final nomeUsuario = responseData['nome_usuario']; // Extraído da resposta
      final userEmail = responseData['email']; // Extraído da resposta
      
      // Salva os dados do usuário e o token
      await saveToken(token);
      await saveUserData(nomeUsuario, userEmail); // Salva o nome de usuário e email
      print(token);
      print('Login bem-sucedido: ${responseData['message']}');
    } else {
      print('Erro ao fazer login: ${response.body}');
      throw Exception('Erro ao fazer login: ${response.statusCode}');
    }
  } catch (e) {
    print('Exceção capturada: $e');
    throw Exception('Erro de conexão: $e');
  }
}

// Método para salvar os dados do usuário no armazenamento local
Future<void> saveUserData(String nomeUsuario, String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('nome_usuario', nomeUsuario);
  await prefs.setString('email', email);
}

// Método para buscar os dados do usuário logado
Future<Map<String, dynamic>?> fetchUserData() async {
  final token = await getToken();
  if (token == null) {
    print('Token não encontrado, usuário não está autenticado.');
    return null;
  }

  try {
    final response = await http.get(
      Uri.parse('$baseUrl/user'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Envia o token para autenticação
      },
    );

    if (response.statusCode == 200) {
      // Retorna os dados do usuário
      return jsonDecode(response.body);
    } else {
      // Exibe mais detalhes em caso de erro
      print('Erro ao buscar dados do usuário: ${response.statusCode} - ${response.body}');
      throw Exception('Falha ao carregar os dados do usuário: ${response.statusCode}');
    }
  } catch (e) {
    print('Exceção ao buscar dados do usuário: $e');
    throw Exception('Erro de conexão ao buscar dados do usuário');
  }
}

 Future<List<AcademiaModelo>> fetchAcademias() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/get_all_acads'));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      // Debug: Verifica a resposta da API
      print(responseData);

      // Popula a lista academias com objetos AcademiaModelo
      List<AcademiaModelo> academias = (responseData['Acads'] as List)
          .map((item) => AcademiaModelo.fromJson(item))
          .toList();
      
      // Debug: Verifica se as academias foram carregadas
      print(academias);
      return academias; // Retorna a lista de objetos AcademiaModelo
    } else {
      throw Exception('Falha ao carregar as academias');
    }
  } catch (e) {
    print('Erro ao buscar academias: $e');
    throw Exception('Erro de conexão ao buscar academias');
  }
}

}

