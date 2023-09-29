class NotificationModel {
  final String id;
  final String datetime;
  final String pesan;
  final String detailPesan;
  final String idPenerima;
  final String idPengirim;
  final String status;

  NotificationModel({
    required this.id,
    required this.datetime,
    required this.pesan,
    required this.detailPesan,
    required this.idPenerima,
    required this.idPengirim,
    required this.status,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        id: json['id'],
        datetime: json['date_time'],
        pesan: json['pesan'],
        detailPesan: json['detail_pesan'],
        idPenerima: json['id_penerima'],
        idPengirim: json['id_pengirim'],
        status: json["status"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date_time': datetime,
      'pesan': pesan,
      'detail_pesanan': detailPesan,
      'id_penerima': idPenerima,
      'id_pengirim': idPengirim,
      'status': status,
    };
  }
}
