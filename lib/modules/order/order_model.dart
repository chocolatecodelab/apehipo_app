class OrderModel {
  final String? idProduk;
  final String nama;
  final String foto;
  final String harga;
  final String amount;
  final String? idOrder;
  final String totalHarga;
  final String status;
  final String idUser;

  OrderModel({
    required this.idProduk,
    required this.nama,
    required this.foto,
    required this.harga,
    required this.amount,
    required this.idOrder,
    required this.totalHarga,
    required this.status,
    required this.idUser,
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
      idUser: json['id_user'],
    );
  }
}
