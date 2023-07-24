import 'dart:io';
import 'package:apehipo_app/widgets/confirmation_dialog.dart';
import 'package:apehipo_app/widgets/app_button.dart';
import 'package:apehipo_app/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/theme.dart';

class StoreManagementPage extends StatefulWidget {
  @override
  _StoreManagementPageState createState() => _StoreManagementPageState();
}

class _StoreManagementPageState extends State<StoreManagementPage> {
  TextEditingController _storeNameController = TextEditingController();
  TextEditingController _storeDescriptionController = TextEditingController();
  TextEditingController _storeAddressController = TextEditingController();
  TextEditingController _storePhoneNumberController = TextEditingController();
  XFile? _selectedImage;
  String _dummyImagePath = "assets/images/store_placeholder.jpg";

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
  Widget build(BuildContext context, {Widget? trailingWidget}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kelola Toko',
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
                  offset: Offset(0, 4), // Controls the position of the shadow
                ),
              ],
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 22, 22, 22),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getImageHeader(),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
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
                    maximumSize: Size(200, 50),
                  ),
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: <Widget>[
                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Pilih Foto Toko",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.add_a_photo_outlined)
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
                SizedBox(height: 16.0),
                Divider(thickness: 1),
                getRowTextField(
                    "Nama Toko", _storeNameController, "Masukkan Nama Toko"),
                Divider(thickness: 1),
                getRowTextField("Deskripsi Toko", _storeDescriptionController,
                    "Masukkan Deskripsi Toko"),
                Divider(thickness: 1),
                getRowTextField("Alamat Toko", _storeAddressController,
                    "Masukkan Alamat Toko"),
                Divider(thickness: 1),
                getRowTextField("Nomor Telepon Toko",
                    _storePhoneNumberController, "Masukkan Nomor Telepon Toko"),
                Divider(thickness: 1),
                SizedBox(height: 24.0),
                getButton(context, "Simpan", onPressed: () {}),
                SizedBox(height: 24.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget getImageHeader() {
  String imagePath = "assets/images/account_image.jpg";
  return CircleAvatar(
    radius: 64.0,
    backgroundImage: AssetImage(imagePath),
    backgroundColor: AppColors.primaryColor.withOpacity(0.7),
  );
}

Widget getRowTextField(
    String label, TextEditingController? controller, String? hintText,
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
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: TextField(
            controller: controller,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              hintText: hintText,
              labelText: null,
              contentPadding: EdgeInsets.only(left: 40.0),
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

Widget getButton(BuildContext context, String label,
    {required Function() onPressed}) {
  return AppButton(
    label: label,
    fontWeight: FontWeight.w300,
    padding: EdgeInsets.symmetric(vertical: 25),
    onPressed: () async {
      bool? confirmationResult = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmationDialog(
              message: "Apakah anda yakin ingin menyimpan perubahan?");
        },
      );
      if (confirmationResult == true) {
        print("Hello");
      } else {
        print("gagal");
      }
    },
  );
}

void main() {
  runApp(MaterialApp(
    home: StoreManagementPage(),
  ));
}
