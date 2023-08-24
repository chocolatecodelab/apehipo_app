class OrderModel {
  final String totalHargaProduk, status;

  OrderModel({required this.totalHargaProduk, required this.status});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        totalHargaProduk: json['total_harga_produk'], status: "status");
  }
}
