class CatalogModel {
  final String kode, nama, jenis, harga, stok, deskripsi, foto, status, idUser;

  CatalogModel(
      {required this.kode,
      required this.nama,
      required this.jenis,
      required this.harga,
      required this.stok,
      required this.deskripsi,
      required this.foto,
      required this.status,
      required this.idUser});

  factory CatalogModel.fromJson(Map<String, dynamic> json) {
    return CatalogModel(
        kode: json['kode'],
        nama: json['nama'],
        jenis: json['jenis'],
        harga: json['harga'],
        stok: json['stok'],
        deskripsi: json['deskripsi'],
        foto: json['foto'],
        status: json['status'],
        idUser: json['id_user']);
  }
}

class Status {
  final List<CatalogModel> catalogTampil;
  final List<CatalogModel> catalogArsip;

  Status({required this.catalogTampil, required this.catalogArsip});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
        catalogTampil: json['data_tampil'], catalogArsip: json['data_arsip']);
  }
}
