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
  final String kodeKebun;

  HomeModel(
      {required this.kode,
      required this.nama,
      required this.jenis,
      required this.harga,
      required this.stok,
      required this.deskripsi,
      required this.foto,
      required this.klasifikasi,
      required this.status,
      required this.kodeKebun});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
        kode: json['kode'],
        nama: json['nama'],
        jenis: json['jenis'],
        harga: json['harga'],
        stok: json['stok'],
        deskripsi: json['deskripsi'],
        foto: json['foto'],
        klasifikasi: json['klasifikasi'],
        status: json['status'],
        kodeKebun: json['id_user']);
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
