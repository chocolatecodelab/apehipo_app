class HomeModel {
  final String kode;
  final String nama;
  final String jenis;
  final String harga;
  final String stok;
  final String deskripsi;
  final String foto;
  final String klasifikasi;
  final String status;
  final String idUser;
  final String namaPetani;
  final String alamatPetani;
  final String fotoPetani;

  HomeModel({
    required this.kode,
    required this.nama,
    required this.jenis,
    required this.harga,
    required this.stok,
    required this.deskripsi,
    required this.foto,
    required this.klasifikasi,
    required this.status,
    required this.idUser,
    required this.namaPetani,
    required this.alamatPetani,
    required this.fotoPetani,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      kode: json['kode'],
      nama: json['produk_nama'],
      jenis: json['jenis'],
      harga: json['harga'],
      stok: json['stok'],
      deskripsi: json['deskripsi'],
      foto: json['produk_foto'],
      klasifikasi: json['klasifikasi'],
      status: json['status'],
      idUser: json['id_user'],
      namaPetani: json['petani_nama'],
      alamatPetani: json['alamat'],
      fotoPetani: json['petani_foto'],
    );
  }
}

class Klasifikasi {
  final List<HomeModel> semuaProduk;
  final List<HomeModel> penjualanTerbaik;
  final List<HomeModel> penjualanEksklusif;
  final List<HomeModel> sedangLaris;

  Klasifikasi(
      {required this.semuaProduk,
      required this.penjualanTerbaik,
      required this.penjualanEksklusif,
      required this.sedangLaris});

  factory Klasifikasi.fromJson(Map<String, dynamic> json) {
    return Klasifikasi(
      semuaProduk: json['semua_produk'],
      penjualanTerbaik: json['penjualan_terbaik'],
      penjualanEksklusif: json['penjualan_eksklusif'],
      sedangLaris: json['sedang_laris'],
    );
  }
}
