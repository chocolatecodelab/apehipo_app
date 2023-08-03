class DashboardModel {
  final String nama;
  final String jenis;
  final String harga;
  final String stok;
  final String deskripsi;
  final String foto;
  final String klasifikasi;
  final String kodeKebun;

  DashboardModel(
      {required this.nama,
      required this.jenis,
      required this.harga,
      required this.stok,
      required this.deskripsi,
      required this.foto,
      required this.klasifikasi,
      required this.kodeKebun});

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
        nama: json['nama'],
        jenis: json['jenis'],
        harga: json['harga'],
        stok: json['stok'],
        deskripsi: json['deskripsi'],
        foto: json['foto'],
        klasifikasi: json['klasifikasi'],
        kodeKebun: json['kode_kebun']);
  }
}
