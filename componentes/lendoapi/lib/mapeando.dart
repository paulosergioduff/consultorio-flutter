class Mapeando {
  final int userId;
  final int id;
  final String dadoExtraido;

  Mapeando({this.userId, this.id, this.dadoExtraido});

  factory Mapeando.fromJson(Map<String, dynamic> json) {
    return Mapeando(
      userId: json['userId'],
      id: json['id'],
      dadoExtraido: json['content'],
    );
  }
}
