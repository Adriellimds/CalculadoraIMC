class Usuario {
  final String nome;
  final String sobrenome;
  final String email;
  final String senha;

  Usuario({
    required this.nome,
    required this.sobrenome,
    required this.email,
    required this.senha,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'sobrenome': sobrenome,
      'email': email,
      'password': senha,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nome: map['nome'],
      sobrenome: map['sobrenome'],
      email: map['email'],
      senha: map['password'],
    );
  }
}