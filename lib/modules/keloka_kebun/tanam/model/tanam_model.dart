class TanamModel {
  String id, namaSayur, gambar, tanggal, jumlah, masaTanam, keterangan;

  TanamModel({
    required this.id,
    required this.namaSayur,
    required this.gambar,
    required this.tanggal,
    required this.jumlah,
    required this.masaTanam,
    required this.keterangan,
  });

  factory TanamModel.fromJson(Map<String, dynamic> json) {
    return TanamModel(
      id: json['id'],
      namaSayur: json['nama_sayur'],
      gambar: json['gambar'],
      tanggal: json['tanggal_tanam'],
      jumlah: json['jumlah_bibit'],
      masaTanam: json['masa_tanam'],
      keterangan: json['keterangan'],
    );
  }
}
