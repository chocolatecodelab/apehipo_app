class CartModel {
  final String? id;
  final String nama;
  final String harga;
  final String foto;
  int amount;

  CartModel(
      {this.id,
      required this.nama,
      required this.harga,
      required this.foto,
      required this.amount});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        id: json['id'],
        nama: json['nama'],
        harga: json['harga'],
        foto: json['foto'],
        amount: json['amount']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id_produk': id,
      'nama': nama,
      'harga': harga.toString(),
      'foto': foto,
      'qty': amount.toString(),
    };
  }
}
