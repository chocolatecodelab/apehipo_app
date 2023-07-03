import 'package:flutter/material.dart';
import 'package:apehipo_app/styles/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:apehipo_app/common_widgets/app_button.dart';

import 'dart:io';

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
  Widget build(BuildContext context) {
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
                SizedBox(
                  width: 128,
                  height: 128,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (_selectedImage != null) ...[
                        CircleAvatar(
                          radius: 64.0,
                          backgroundImage: _selectedImage != null
                              ? FileImage(File(_selectedImage!.path))
                              : AssetImage(_dummyImagePath) as ImageProvider,
                        ),
                        if (_selectedImage == null)
                          Icon(
                            Icons.store,
                            size: 64.0,
                          ),
                      ],
                    ],
                  ),
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
                  child: Text('Pilih Foto Toko'),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _storeNameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Toko',
                    floatingLabelStyle: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                    border: _getRoundedBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: _getRoundedBorder(),
                  ),
                  cursorColor: AppColors.primaryColor,
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _storeDescriptionController,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi Toko',
                    floatingLabelStyle: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                    border: _getRoundedBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: _getRoundedBorder(),
                  ),
                  cursorColor: AppColors.primaryColor,
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _storeAddressController,
                  decoration: InputDecoration(
                    labelText: 'Alamat Toko',
                    floatingLabelStyle: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                    border: _getRoundedBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: _getRoundedBorder(),
                  ),
                  cursorColor: AppColors.primaryColor,
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _storePhoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Nomor Telepon Toko',
                    floatingLabelStyle: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                    border: _getRoundedBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: _getRoundedBorder(),
                  ),
                  cursorColor: AppColors.primaryColor,
                ),
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

Widget getButton(BuildContext context, String label,
    {required Function() onPressed}) {
  return AppButton(
    label: label,
    fontWeight: FontWeight.w300,
    padding: EdgeInsets.symmetric(vertical: 25),
    onPressed: onPressed,
  );
}

void main() {
  runApp(MaterialApp(
    home: StoreManagementPage(),
  ));
}
