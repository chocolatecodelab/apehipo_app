import 'package:get/get.dart';

class SemaiModel {
  final String id, gambar, jenisSayur, tanggal, jumlah, waktu;

  SemaiModel({
    required this.id,
    required this.gambar,
    required this.jenisSayur,
    required this.tanggal,
    required this.jumlah,
    required this.waktu,
  });

  factory SemaiModel.fromJson(Map<String, dynamic> json) {
    return SemaiModel(
      id: json['id'],
      gambar: json['gambar'],
      jenisSayur: json['jenis_sayur'],
      tanggal: json['tanggal'],
      jumlah: json['jumlah'],
      waktu: json['waktu'],
    );
  }
}
