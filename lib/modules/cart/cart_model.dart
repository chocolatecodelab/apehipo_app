class CartModel {
  final String? id;
  final String nama;
  final String harga;
  final String foto;

  CartModel({
    this.id,
    required this.nama,
    required this.harga,
    required this.foto,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        id: json['id'],
        nama: json['nama'],
        harga: json['harga'],
        foto: json['foto']);
  }
}
