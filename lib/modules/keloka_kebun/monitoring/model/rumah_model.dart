// To parse this JSON data, do
//
//     final rumahModel = rumahModelFromJson(jsonString);

import 'dart:convert';

RumahModel rumahModelFromJson(String str) => RumahModel.fromJson(json.decode(str));

String rumahModelToJson(RumahModel data) => json.encode(data.toJson());

class RumahModel {
    String idRumah;
    String idKebun;
    String namaRumah;
    String kapasitas;
    String gambar;
    String deskripsi;

    RumahModel({
        required this.idRumah,
        required this.idKebun,
        required this.namaRumah,
        required this.kapasitas,
        required this.gambar,
        required this.deskripsi,
    });

    factory RumahModel.fromJson(Map<String, dynamic> json) => RumahModel(
        idRumah: json["id_rumah"],
        idKebun: json["id_kebun"],
        namaRumah: json["nama_rumah"],
        kapasitas: json["kapasitas"],
        gambar: json["gambar"],
        deskripsi: json["deskripsi"],
    );

    Map<String, dynamic> toJson() => {
        "id_rumah": idRumah,
        "id_kebun": idKebun,
        "nama_rumah": namaRumah,
        "kapasitas": kapasitas,
        "gambar": gambar,
        "deskripsi": deskripsi,
    };
}
