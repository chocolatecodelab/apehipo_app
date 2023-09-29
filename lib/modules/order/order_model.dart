class OrderModel {
  final String? idProduk;
  final String nama;
  final String foto;
  final String harga;
  final String amount;
  final String? idOrder;
  final String totalHarga;
  final String status;
  final String idPembeli;
  final String? statusTransaksi;
  final String idPenjual;

  OrderModel({
    required this.idProduk,
    required this.nama,
    required this.foto,
    required this.harga,
    required this.amount,
    required this.idOrder,
    required this.totalHarga,
    required this.status,
    required this.idPembeli,
    required this.statusTransaksi,
    required this.idPenjual,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      idProduk: json['id_produk'],
      nama: json['nama'],
      foto: json['foto'],
      harga: json['harga'],
      amount: json['qty'],
      idOrder: json['id_order'],
      totalHarga: json['total_harga_produk'],
      status: json['status'],
      idPembeli: json['id_pembeli'],
      statusTransaksi: json['status_transaksi'],
      idPenjual: json['id_penjual'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_produk': idProduk,
      'nama': nama,
      'foto': foto,
      'harga': harga,
      'qty': amount,
      'id_order': idOrder,
      'total_harga_produk': totalHarga,
      'status': status,
      'id_pembeli': idPembeli,
    };
  }
}
