class TanamModel {
  String id, namaSayur, gambar, tanggal, jumlah, masaTanam, keterangan, ppm, ph, tanggalSemai;

  TanamModel({
    required this.id,
    required this.namaSayur,
    required this.gambar,
    required this.tanggal,
    required this.jumlah,
    required this.masaTanam,
    required this.keterangan,
    required this.ppm,
    required this.ph,
    required this.tanggalSemai,
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
      ppm: json['ppm'],
      ph: json['ph'],
      tanggalSemai: json['tanggal_semai'],
    );
  }
}
