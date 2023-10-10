class AuthModel {
  final String username, role, nama, idUser;

  AuthModel({
    required this.username,
    required this.role,
    required this.nama,
    required this.idUser,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      username: json['username'],
      role: json['role'],
      nama: json['nama'] ?? "",
      idUser: json['id_user'] ?? "",
    );
  }
}
