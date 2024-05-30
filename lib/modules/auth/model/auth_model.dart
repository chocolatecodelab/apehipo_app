class AuthModel {
  final String username, role, nama, idUser,idKebun;

  AuthModel({
    required this.username,
    required this.role,
    required this.nama,
    required this.idUser,
    required this.idKebun,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      username: json['username'],
      role: json['role'],
      // fcmToken: json['fcmToken'],
      nama: json['nama'] ?? "",
      idUser: json['id_user'] ?? "",
      idKebun: json['id_kebun'] ?? "",
    );
  }
}
