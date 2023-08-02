class ProductModel {
  final String kode;
  final String nama;
  final String jenis;
  final String harga;
  final String stok;
  final String deskripsi;
  final String foto;
  final String kodeKebun;

  ProductModel(
      {required this.kode,
      required this.nama,
      required this.jenis,
      required this.harga,
      required this.stok,
      required this.deskripsi,
      required this.foto,
      required this.kodeKebun});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        kode: json['kode'],
        nama: json['nama'],
        jenis: json['jenis'],
        harga: json['harga'],
        stok: json['stok'],
        deskripsi: json['deskripsi'],
        foto: json['foto'],
        kodeKebun: json['kode_kebun']);
  }
}
