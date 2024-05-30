class DataSayurModel {
  String namaSayur,
      tanggalSemai,
      tanggalPanen,
      jumlahSemai,
      jumlahTanam,
      jumlahPanen;

  DataSayurModel({
    required this.namaSayur,
    required this.tanggalSemai,
    required this.jumlahPanen,
    required this.jumlahSemai,
    required this.jumlahTanam,
    required this.tanggalPanen,
  });

  factory DataSayurModel.fromJson(Map<String, dynamic> json) {
    return DataSayurModel(
      namaSayur: json['nama_sayur'],
      tanggalSemai: json['tanggal_semai'],
      tanggalPanen: json['tanggal_panen'],
      jumlahSemai: json['jumlah_semai'],
      jumlahTanam: json['jumlah_tanam'],
      jumlahPanen: json['jumlah_panen'],
    );
  }
}
