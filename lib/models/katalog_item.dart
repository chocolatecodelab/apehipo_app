class KatalogItem {
  final int? id;
  final String name;
  final String description;
  final double stock;
  final double price;
  final String imagePath;
  final int? favorit;
  final int? sold;
  final int? dilihat;

  KatalogItem({
    this.id,
    required this.name,
    required this.stock,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.favorit,
    required this.sold,
    required this.dilihat,
  });
}

var demoItems = [
  KatalogItem(
      id: 1,
      stock: 2,
      favorit: 2,
      dilihat: 3,
      sold: 3,
      name: "Organic Bananas",
      description: "7pcs, Priceg",
      price: 4.99,
      imagePath: "assets/images/grocery_images/banana.png"),
  KatalogItem(
      id: 2,
      stock: 2,
      favorit: 2,
      dilihat: 3,
      sold: 3,
      name: "Red Apple",
      description: "1kg, Priceg",
      price: 4.99,
      imagePath: "assets/images/grocery_images/apple.png"),
  KatalogItem(
      id: 3,
      stock: 2,
      favorit: 2,
      dilihat: 3,
      sold: 3,
      name: "Bell Pepper Red",
      description: "1kg, Priceg",
      price: 4.99,
      imagePath: "assets/images/grocery_images/pepper.png"),
  KatalogItem(
      id: 4,
      stock: 2,
      favorit: 2,
      dilihat: 3,
      sold: 3,
      name: "Ginger",
      description: "250gm, Priceg",
      price: 4.99,
      imagePath: "assets/images/grocery_images/ginger.png"),
  KatalogItem(
      id: 5,
      stock: 2,
      favorit: 2,
      dilihat: 3,
      sold: 3,
      name: "Meat",
      description: "250gm, Priceg",
      price: 4.99,
      imagePath: "assets/images/grocery_images/beef.png"),
  KatalogItem(
      id: 6,
      stock: 2,
      favorit: 2,
      dilihat: 3,
      sold: 3,
      name: "Chikken",
      description: "250gm, Priceg",
      price: 4.99,
      imagePath: "assets/images/grocery_images/chicken.png"),
];

var penawaranSpesial = [demoItems[0], demoItems[1], demoItems[3]];

var penjualanTerbaik = [demoItems[2], demoItems[3]];

var grosiran = [demoItems[4], demoItems[5]];

var beverages = [
  KatalogItem(
      id: 7,
      stock: 2,
      favorit: 2,
      dilihat: 3,
      sold: 3,
      name: "Dite Coke",
      description: "355ml, Price",
      price: 1.99,
      imagePath: "assets/images/beverages_images/diet_coke.png"),
  KatalogItem(
      id: 8,
      stock: 2,
      favorit: 2,
      dilihat: 3,
      sold: 3,
      name: "Sprite Can",
      description: "325ml, Price",
      price: 1.50,
      imagePath: "assets/images/beverages_images/sprite.png"),
  KatalogItem(
      id: 8,
      stock: 2,
      favorit: 2,
      dilihat: 3,
      sold: 3,
      name: "Apple Juice",
      description: "2L, Price",
      price: 15.99,
      imagePath: "assets/images/beverages_images/apple_and_grape_juice.png"),
  KatalogItem(
      id: 9,
      stock: 2,
      favorit: 2,
      dilihat: 3,
      sold: 3,
      name: "Orange Juice",
      description: "2L, Price",
      price: 1.50,
      imagePath: "assets/images/beverages_images/orange_juice.png"),
  KatalogItem(
      id: 10,
      stock: 2,
      favorit: 2,
      dilihat: 3,
      sold: 3,
      name: "Coca Cola Can",
      description: "325ml, Price",
      price: 4.99,
      imagePath: "assets/images/beverages_images/coca_cola.png"),
  KatalogItem(
      id: 11,
      stock: 2,
      favorit: 2,
      dilihat: 3,
      sold: 3,
      name: "Pepsi Can",
      description: "330ml, Price",
      price: 4.99,
      imagePath: "assets/images/beverages_images/pepsi.png"),
];
