class HidrocommerceModel {
  final String kode;
  final String nama;
  final String jenis;
  final String harga;
  final String stok;
  final String deskripsi;
  final String foto;
  final String status;
  final String idUser;
  final String namaPetani;
  final String alamatPetani;
  final String fotoPetani;
  final String? noTelpon;

  HidrocommerceModel(
      {required this.kode,
      required this.nama,
      required this.jenis,
      required this.harga,
      required this.stok,
      required this.deskripsi,
      required this.foto,
      required this.status,
      required this.idUser,
      required this.namaPetani,
      required this.alamatPetani,
      required this.fotoPetani,
      this.noTelpon});

  factory HidrocommerceModel.fromJson(Map<String, dynamic> json) {
    return HidrocommerceModel(
        kode: json['kode'],
        nama: json['produk_nama'],
        jenis: json['jenis'],
        harga: json['harga'],
        stok: json['stok'],
        deskripsi: json['deskripsi'],
        foto: json['produk_foto'],
        status: json['status'],
        idUser: json['id_user'],
        namaPetani: json['petani_nama'],
        alamatPetani: json['alamat'],
        fotoPetani: json['petani_foto'],
        noTelpon: json['no_telpon']);
  }
}

class HidrocommerceKlasifikasi {
  final List<HidrocommerceModel> semuaProduk;
  final List<HidrocommerceModel> penjualanTerbaik;
  final List<HidrocommerceModel> penjualanEksklusif;
  final List<HidrocommerceModel> sedangLaris;

  HidrocommerceKlasifikasi(
      {required this.semuaProduk,
      required this.penjualanTerbaik,
      required this.penjualanEksklusif,
      required this.sedangLaris});

  factory HidrocommerceKlasifikasi.fromJson(Map<String, dynamic> json) {
    return HidrocommerceKlasifikasi(
      semuaProduk: json['semua_produk'],
      penjualanTerbaik: json['penjualan_terbaik'],
      penjualanEksklusif: json['penjualan_eksklusif'],
      sedangLaris: json['sedang_laris'],
    );
  }
}
