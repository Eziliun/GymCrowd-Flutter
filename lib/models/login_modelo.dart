class LoginModelo {
  //String id;
  String nome_usuario;
  String email;
  String cpf;
  String password;

  LoginModelo(
      {//required this.id,
      required this.nome_usuario,
      required this.email,
      required this.cpf,
      required this.password});

  factory LoginModelo.fromJson(Map<String, dynamic> json) {
    return LoginModelo(
      //id: json['id'], 
      nome_usuario: json['nome_usuario'], 
      email: json['email'], 
      cpf: json['cpf'], 
      password: json['password'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //'id': id, 
      'nome_usuario': nome_usuario, 
      'email': email, 
      'cpf': cpf, 
      'password': password 
    };
  }
}
