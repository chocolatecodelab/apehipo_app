import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });
}

class ManageProductsPage extends StatefulWidget {
  @override
  _ManageProductsPageState createState() => _ManageProductsPageState();
}

class _ManageProductsPageState extends State<ManageProductsPage> {
  List<Product> products = [
    Product(
      id: '1',
      name: 'Product 1',
      description: 'This is product 1',
      price: 10.0,
    ),
    Product(
      id: '2',
      name: 'Product 2',
      description: 'This is product 2',
      price: 20.0,
    ),
    Product(
      id: '3',
      name: 'Product 3',
      description: 'This is product 3',
      price: 30.0,
    ),
  ];

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  bool _isEditMode = false;
  late Product _selectedProduct;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _addProduct() {
    String name = _nameController.text.trim();
    String description = _descriptionController.text.trim();
    double price = double.parse(_priceController.text);

    Product newProduct = Product(
      id: DateTime.now().toString(),
      name: name,
      description: description,
      price: price,
    );

    setState(() {
      products.add(newProduct);
    });

    _clearForm();
  }

  void _updateProduct() {
    String name = _nameController.text.trim();
    String description = _descriptionController.text.trim();
    double price = double.parse(_priceController.text);

    Product updatedProduct = Product(
      id: _selectedProduct.id,
      name: name,
      description: description,
      price: price,
    );

    int productIndex =
        products.indexWhere((product) => product.id == _selectedProduct.id);

    setState(() {
      products[productIndex] = updatedProduct;
    });

    _clearForm();
    _toggleEditMode(false);
  }

  void _deleteProduct(Product product) {
    setState(() {
      products.remove(product);
    });
  }

  void _editProduct(Product product) {
    _nameController.text = product.name;
    _descriptionController.text = product.description;
    _priceController.text = product.price.toString();

    _selectedProduct = product;

    _toggleEditMode(true);
  }

  void _clearForm() {
    _nameController.text = '';
    _descriptionController.text = '';
    _priceController.text = '';
  }

  void _toggleEditMode(bool isEditMode) {
    setState(() {
      _isEditMode = isEditMode;
    });

    if (!isEditMode) {
      _selectedProduct = Product(
        id: '',
        name: '',
        description: '',
        price: 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelola Produk'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Produk',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = products[index];

                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text(product.description),
                    trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                    onTap: () {
                      _editProduct(product);
                    },
                    onLongPress: () {
                      _deleteProduct(product);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              _isEditMode ? 'Edit Produk' : 'Tambah Produk',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama Produk',
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Deskripsi Produk',
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Harga Produk',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _isEditMode ? _updateProduct : _addProduct,
                  child: Text(_isEditMode ? 'Simpan' : 'Tambah'),
                ),
                SizedBox(width: 8.0),
                if (_isEditMode)
                  ElevatedButton(
                    onPressed: () {
                      _toggleEditMode(false);
                      _clearForm();
                    },
                    child: Text('Batal'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ManageProductsPage(),
  ));
}
