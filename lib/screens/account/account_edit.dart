import 'package:flutter/material.dart';
import 'package:apehipo_app/styles/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:apehipo_app/common_widgets/app_button.dart';

import 'dart:io';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _paymentInfoController = TextEditingController();
  XFile? _selectedImage;
  String _dummyImagePath = "assets/images/pulses.png";

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
          'Edit Profil',
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
                            Icons.person,
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
                  child: Text('Pilih Foto Profil'),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    floatingLabelStyle: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                    border: _getRoundedBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors
                            .primaryColor, // Set the focused border color
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
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                    floatingLabelStyle: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                    border: _getRoundedBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors
                            .primaryColor, // Set the focused border color
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    floatingLabelStyle: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                    border: _getRoundedBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors
                            .primaryColor, // Set the focused border color
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
                  controller: _paymentInfoController,
                  decoration: InputDecoration(
                    labelText: 'Informasi Pembayaran',
                    floatingLabelStyle: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                    border: _getRoundedBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors
                            .primaryColor, // Set the focused border color
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
                getLupa("Lupa Password"),
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

Widget getLupa(String label, {Widget? trailingWidget}) {
  return Container(
    width: double.maxFinite,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 0,
        backgroundColor: Colors.red[400],
        textStyle: TextStyle(
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(vertical: 24),
        minimumSize: const Size.fromHeight(50),
      ),
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
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
