class AccountModel {
  final String nama, username, email, alamat, noTelpon, foto, noRekening, role;

  AccountModel(
      {required this.nama,
      required this.username,
      required this.email,
      required this.alamat,
      required this.noTelpon,
      required this.foto,
      required this.noRekening,
      required this.role});

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
        nama: json['nama'],
        username: json['username'],
        email: json['email'],
        alamat: json['alamat'],
        noTelpon: json['noTelpon'],
        foto: json['foto'],
        role: json['role'],
        noRekening: json['no_rekening'] ?? "");
  }
}
