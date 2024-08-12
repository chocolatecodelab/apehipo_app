import 'dart:io';

import '../controller/catalog_controller.dart';
import '../model/catalog_model.dart';
import '../../../widgets/confirmation_dialog.dart';
import '../../../widgets/colors.dart';
import '../../../widgets/dynamic_button.dart';
import '../../../widgets/success_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import '../../../widgets/theme.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../widgets/app_text.dart';

// import 'favourite_toggle_icon_widget.dart';

class CatalogEditScreen extends StatefulWidget {
  final CatalogModel katalogItem;
  final String? heroSuffix;

  const CatalogEditScreen(this.katalogItem, {this.heroSuffix});

  @override
  _CatalogEditScreenState createState() => _CatalogEditScreenState();
}

class _CatalogEditScreenState extends State<CatalogEditScreen> {
  int amount = 1;
  bool isPreOrder = false;
  XFile? _selectedImage;
  var controller = Get.put(CatalogController());
  final formFieldKey = GlobalKey<FormState>();
  String selectedValue = 'Sayuran';

  void initState() {
    super.initState();

    // Set nilai awal _nameController jika widget.katalogItem tidak null
    controller.nama.text = widget.katalogItem.nama;
    controller.deskripsi.text = widget.katalogItem.deskripsi;
    controller.harga.text = widget.katalogItem.harga.toString();
    controller.stok.text = widget.katalogItem.stok.toString();
    controller.foto.text = widget.katalogItem.foto;
    controller.status.text = widget.katalogItem.status;
    controller.jenis.text = selectedValue;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    setState(() {
      _selectedImage = pickedImage;
    });
  }

  OutlineInputBorder _getRoundedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Color.fromRGBO(128, 128, 128, 0.3),
        width: 1.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller = Get.put(CatalogController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Produk',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 0,
                  offset: Offset(0, 0), // Controls the position of the shadow
                ),
              ],
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 22, 22, 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getImageHeaderWidget(),
            SizedBox(
              height: 15,
            ),
            getPilihCover("Pilih gambar cover"),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: formFieldKey,
                child: Column(
                  children: [
                    Divider(
                      thickness: 1,
                    ),
                    Container(
                      width: 400,
                      child: DropdownButtonFormField<String>(
                        value: selectedValue,
                        onChanged: (newValue) {
                          setState(() {
                            selectedValue = newValue!;
                            controller.jenis.text = selectedValue;
                          });
                        },
                        items: ['Sayuran', 'Buah']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Pilih jenis',
                          border: OutlineInputBorder(),
                        ),
                        isDense: true,
                        isExpanded: true,
                      ),
                    ),
                    SizedBox(height: 16),
                    Divider(thickness: 1),
                    getCatalogRowName("Nama", "Contoh:\nPakcoy 1/2kg"),
                    Divider(thickness: 1),
                    getCatalogRowDeskripsi("Deskripsi",
                        "Contoh:\nApel ini adalah apel dari hasil perkebunan hidroponik. Ready daerah Banjarbaru. Free Ongkir daerah Landasan Ulin. "),
                    Divider(thickness: 1),
                    getCatalogRowHarga("Harga"),
                    Divider(thickness: 1),
                    getCatalogRowStok("Stok"),
                    Divider(thickness: 1),
                    // getCatalogRowPreOrder("Pre-Order"),
                    // Divider(thickness: 1),
                    SizedBox(height: 16),
                    DynamicButtonWidget(
                      label: "Simpan Perubahan",
                      textColor: Colors.white,
                      backgroundColor: AppColors.primaryColor,
                      iconData: Icons.add,
                      onPressed: () async {
                        bool? confirmationResult = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ConfirmationDialog(
                                message:
                                    "Apakah anda yakin ingin menyimpan perubahan?");
                          },
                        );
                        if (confirmationResult == true) {
                          String hasil = await controller.updateData(
                            widget.katalogItem.kode,
                            _selectedImage,
                          );
                          if (hasil == "sukses") {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SuccessConfirmationDialog(
                                    message: "Produk berhasil diubah",
                                    icon: Icons.check_circle_outline);
                              },
                            );
                            Get.back();
                          } else {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SuccessConfirmationDialog(
                                    message: "Produk gagal diubah",
                                    icon: Icons.close_rounded);
                              },
                            );
                          }
                          // SuccessConfirmationDialog(
                          //     message: "Anda berhasil menyimpan perubahan");
                        } else {
                          print("Gagal");
                        }
                      },
                    ),
                    SizedBox(height: 8),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getPilihCover(String label, {Widget? trailingWidget}) {
    return Container(
      width: 220,
      child: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Pilih dari Galeri'),
                      onTap: () {
                        _pickImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text('Ambil Foto'),
                      onTap: () {
                        _pickImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
          backgroundColor: AppColors.darkGrey,
          textStyle: TextStyle(
            color: Colors.white,
            fontFamily: gilroyFontFamily,
          ),
          padding: EdgeInsets.symmetric(vertical: 24),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.whiteGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.add_a_photo_outlined,
                  color: AppColors.whiteGrey,
                )
              ],
            )),
            if (trailingWidget != null)
              Positioned(
                top: 0,
                right: 25,
                child: trailingWidget,
              ),
          ],
        ),
      ),
    );
  }

  Widget getPilihGambar(String label, {Widget? trailingWidget}) {
    return Container(
      width: 120,
      height: 45,
      child: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.photo_library,
                      ),
                      title: Text('Pilih dari Galeri'),
                      onTap: () {
                        _pickImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text('Ambil Foto'),
                      onTap: () {
                        _pickImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
          backgroundColor: AppColors.darkGrey,
          textStyle: TextStyle(
            color: Colors.white,
            fontFamily: gilroyFontFamily,
          ),
          padding: EdgeInsets.symmetric(vertical: 24),
          minimumSize: const Size.fromHeight(40),
        ),
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.add_a_photo_outlined,
                  size: 14,
                )
              ],
            )),
            if (trailingWidget != null)
              Positioned(
                top: 0,
                right: 25,
                child: trailingWidget,
              ),
          ],
        ),
      ),
    );
  }

  Widget getImageHeaderWidget() {
    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF3366FF).withOpacity(0.1),
              const Color(0xFF3366FF).withOpacity(0.09),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Hero(
        tag: "KatalogItem:" +
            widget.katalogItem.nama +
            "-" +
            (widget.heroSuffix ?? ""),
        child: _selectedImage == null
            ? Image.network(widget.katalogItem.foto)
            : Image.file(File(_selectedImage!.path)),
      ),
    );
  }

  Widget getCatalogRowHarga(String label, {Widget? customWidget}) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Row(
        children: [
          if (customWidget != null) ...[
            customWidget,
            SizedBox(
              width: 20,
            ),
          ],
          Icon(Icons.price_change_outlined),
          SizedBox(
            width: 5,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: controller.harga,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                prefixText: "Rp",
                hintText: 'Masukkan harga',
                labelText: null,
                floatingLabelStyle: TextStyle(
                  color: AppColors.primaryColor,
                ),
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              cursorColor: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget getCatalogRowStok(String label, {Widget? customWidget}) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Row(
        children: [
          if (customWidget != null) ...[
            customWidget,
            SizedBox(
              width: 20,
            ),
          ],
          Icon(Icons.discount_outlined),
          SizedBox(
            width: 5,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: controller.stok,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'Masukkan stok',
                labelText: null,
                floatingLabelStyle: TextStyle(
                  color: AppColors.primaryColor,
                ),
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              cursorColor: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget getCatalogRowPreOrder(String label, {Widget? customWidget}) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Row(
        children: [
          if (customWidget != null) ...[
            customWidget,
            SizedBox(
              width: 20,
            ),
          ],
          Icon(Icons.calendar_today),
          SizedBox(
            width: 5,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Spacer(),
          Switch(
            value: isPreOrder,
            onChanged: (value) {
              setState(() {
                isPreOrder = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget getCatalogRowDeskripsi(String label, String? example,
      {Widget? customWidget}) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Row(
        children: [
          if (customWidget != null) ...[
            customWidget,
            SizedBox(
              width: 20,
            ),
          ],
          SizedBox(
            width: 5,
          ),
          Container(
            width: 120, // Gunakan nilai labelWidth untuk lebar label
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  example!,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: controller.deskripsi,
              maxLines: 5,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: 'Masukkan Deskripsi Produk',
                labelText: null,
                floatingLabelStyle: TextStyle(
                  color: AppColors.primaryColor,
                ),
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              cursorColor: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget getCatalogRowName(String label, String? example,
      {Widget? customWidget}) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Row(
        children: [
          if (customWidget != null) ...[
            customWidget,
            SizedBox(
              width: 20,
            ),
          ],
          SizedBox(
            width: 5,
          ),
          Container(
            width: 120, // Gunakan nilai labelWidth untuk lebar label
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  example!,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: TextField(
              controller: controller.nama,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: 'Masukkan Nama Produk',
                labelText: null,
                contentPadding: EdgeInsets.only(left: 20.0),
                floatingLabelStyle: TextStyle(
                  color: AppColors.primaryColor,
                ),
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              cursorColor: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget nutritionWidget() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text: "100gm",
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: Color(0xff7C7C7C),
      ),
    );
  }

  Widget ratingWidget() {
    Widget starIcon() {
      return Icon(
        Icons.star,
        color: Color(0xffF3603F),
        size: 20,
      );
    }

    return Row(
      children: [
        starIcon(),
        starIcon(),
        starIcon(),
        starIcon(),
        starIcon(),
      ],
    );
  }

  double getTotalPrice() {
    double harga = double.parse(widget.katalogItem.harga);
    return amount * harga;
  }

  double getTotalStock() {
    double stok = double.parse(widget.katalogItem.stok);
    return amount * stok;
  }
}
