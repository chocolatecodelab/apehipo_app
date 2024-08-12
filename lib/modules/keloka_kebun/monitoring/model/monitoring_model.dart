// To parse this JSON data, do
//
//     final monitoringModel = monitoringModelFromJson(jsonString);

import 'dart:convert';

MonitoringModel monitoringModelFromJson(String str) => MonitoringModel.fromJson(json.decode(str));

String monitoringModelToJson(MonitoringModel data) => json.encode(data.toJson());

class MonitoringModel {
    String idMonitoring;
    String idRumah;
    String tanggal;
    String ppm;
    String ph;

    MonitoringModel({
        required this.idMonitoring,
        required this.idRumah,
        required this.tanggal,
        required this.ppm,
        required this.ph,
    });

    factory MonitoringModel.fromJson(Map<String, dynamic> json) => MonitoringModel(
        idMonitoring: json["id_monitoring"],
        idRumah: json["id_rumah"],
        tanggal: json["tanggal"],
        ppm: json["ppm"],
        ph: json["ph"],
    );

    Map<String, dynamic> toJson() => {
        "id_monitoring": idMonitoring,
        "id_rumah": idRumah,
        "tanggal": tanggal,
        "ppm": ppm,
        "ph": ph,
    };
}
