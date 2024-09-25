class LoginModelo {
  String id;
  String nome;
  String email;
  String cpf;
  String senha;

  LoginModelo(
      {required this.id,
      required this.nome,
      required this.email,
      required this.cpf,
      required this.senha});

  factory LoginModelo.fromJson(Map<String, dynamic> json) {
    return LoginModelo(
      id: json['id'], 
      nome: json['nome'], 
      email: json['email'], 
      cpf: json['cpf'], 
      senha: json['senha'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, 
      'nome': nome, 
      'email': email, 
      'cpf': cpf, 
      'senha': senha 
    };
  }
}
