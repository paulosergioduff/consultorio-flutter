class MapeandoParametro {
  final int userId;
  final int id;
  final String dadoExtraido;

  MapeandoParametro({this.userId, this.id, this.dadoExtraido});

  factory MapeandoParametro.fromJson(Map<String, dynamic> json) {
    return MapeandoParametro(
      userId: json['userId'],
      id: json['id'],
      dadoExtraido: json['content'],
    );
  }
}
