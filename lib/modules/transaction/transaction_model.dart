class TransactionModel {
  final String? idProduk;
  final String nama;
  final String foto;
  final String harga;
  final String amount;
  final String totalHarga;
  String status;
  final String idOrder;
  final String idTransaksi;
  final String idPembeli;
  final String idPenjual;
  final String alamat;
  final String noTelpon;

  TransactionModel({
    required this.idProduk,
    required this.nama,
    required this.foto,
    required this.harga,
    required this.amount,
    required this.totalHarga,
    required this.status,
    required this.idOrder,
    required this.idTransaksi,
    required this.idPembeli,
    required this.idPenjual,
    required this.alamat,
    required this.noTelpon,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      idProduk: json['id_produk'],
      nama: json['nama'],
      foto: json['foto'],
      harga: json['harga'],
      amount: json['amount'],
      totalHarga: json['total_harga_produk'],
      status: json['status'],
      idOrder: json['id_order'],
      idTransaksi: json['id_transaksi'],
      idPenjual: json['id_penjual'],
      idPembeli: json['id_pembeli'],
      alamat: json['alamat'],
      noTelpon: json['no_telpon'],
    );
  }
}
