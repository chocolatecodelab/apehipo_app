class ProductModel {
  final String id, title;

  ProductModel({required this.id, required this.title});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(id: json['id'], title: json['title']);
  }
}
