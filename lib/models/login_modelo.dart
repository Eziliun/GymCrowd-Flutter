class LoginModelo {
  String id;
  String nome;
  String email;
  String cpf;
  String senha;

  String? urlImagem;

  LoginModelo(
      {required this.id,
      required this.nome,
      required this.email,
      required this.cpf,
      required this.senha});

  LoginModelo.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nome = map['nome'],
        email = map['email'],
        cpf = map['cpf'],
        senha = map['senha'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'cpf': cpf,
      'senha': senha
    };
  }
}
