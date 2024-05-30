class ReportModel {
  int totalSayurDisemai, totalSayurDitanam, totalSayurDipanen, jumlahSayur;

  ReportModel({
    required this.totalSayurDisemai,
    required this.totalSayurDitanam,
    required this.totalSayurDipanen,
    required this.jumlahSayur,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      totalSayurDisemai: json['total sayur disemai'],
      totalSayurDitanam: json['total sayur ditanam'],
      totalSayurDipanen: json['total sayur dipanen'],
      jumlahSayur: json['jumlah sayur'],
    );
  }
}
