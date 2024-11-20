class AcademiaModelo {
  //String id;
  String cnpj_matriz;
  String endereco;
  double latitude;
  double longitude;
  int lotacao;
  String nome_fantasia;

  AcademiaModelo(
      {//required this.id,
      required this.cnpj_matriz,
      required this.endereco,
      required this.latitude,
      required this.longitude,
      required this.lotacao,
      required this.nome_fantasia
      
      });

  factory AcademiaModelo.fromJson(Map<String, dynamic> json) {
    return AcademiaModelo(
      //id: json['id'], 
      cnpj_matriz: json['cnpj_matriz'], 
      endereco: json['endereco'], 
      latitude: json['latitude'], 
      longitude: json['longitude'],
      lotacao: json['lotacao'],
      nome_fantasia: json['nome_fantasia'] 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //'id': id, 
      'cnpj_matriz': cnpj_matriz, 
      'endereco': endereco, 
      'latitude': latitude, 
      'longitude': longitude,
      'lotacao': lotacao,
      'nome_fantasia': nome_fantasia, 
    };
  }
}
