import 'package:apehipo_app/auth/auth_controller.dart';
import 'package:apehipo_app/modules/account/account_controller.dart';
import 'package:apehipo_app/modules/account/account_model.dart';
import 'package:apehipo_app/modules/account/account_screen.dart';
import 'package:apehipo_app/widgets/confirmation_dialog.dart';
import 'package:apehipo_app/widgets/dynamic_button.dart';
import 'package:apehipo_app/widgets/success_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:apehipo_app/widgets/colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:apehipo_app/widgets/app_button.dart';
import '../../widgets/theme.dart';

import 'dart:io';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var controller = Get.put(AccountController());
  var auth = Get.put(AuthController());
  XFile? _selectedImage;
  final formFieldKey = GlobalKey<FormState>();

  // set nilai awal jika widget.katalogItem

  void initState() {
    super.initState();

    // Set nilai awal _nameController jika widget.katalogItem tidak null
    controller.foto.text = controller.map['foto'];
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
  Widget build(BuildContext context, {Widget? trailingWidget}) {
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
                getImageHeader(_selectedImage, controller.foto.text),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SafeArea(
                          child: Form(
                            key: formFieldKey,
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
                            "Pilih Foto Profil",
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
                    "Nama Lengkap", controller.nama, "Masukkan Nama Lengkap"),
                Divider(thickness: 1),
                getRowTextField(
                    "Username", controller.username, "Masukkan Username"),
                Divider(thickness: 1),
                getRowTextField("Email", controller.email, "Masukkan Email"),
                Divider(thickness: 1),
                getRowTextField("Alamat", controller.alamat, "Masukkan Alamat"),
                Divider(thickness: 1),
                getRowTextField("Nomor Telepon", controller.noTelpon,
                    "Masukkan Nomor Telepon"),
                Divider(thickness: 1),
                if (auth.box.read("role") == "petani")
                  getRowTextField("Nomor Rekening", controller.noRekening,
                      "Masukkan Nomor Rekening"),
                if (auth.box.read("role") == "petani") Divider(thickness: 1),
                SizedBox(height: 24.0),
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
                      controller.updateData(
                        auth.box.read("id_user"),
                        _selectedImage,
                      );
                      // SuccessConfirmationDialog(
                      //     message: "Anda berhasil menyimpan perubahan");
                    } else {
                      print("Gagal");
                    }
                  },
                ),
                SizedBox(height: 24.0),
                // getLupa("Lupa Password"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget getImageHeader(XFile? _selectedImage, String foto) {
  return CircleAvatar(
    radius: 64.0,
    backgroundColor: AppColors.primaryColor.withOpacity(0.7),
    child: ClipOval(
      child: _selectedImage == null
          ? Image.network(
              foto,
              fit: BoxFit.cover,
              width: 128,
              height: 128,
            )
          : Image.file(
              File(_selectedImage.path),
              fit: BoxFit.cover,
              width: 128,
              height: 128,
            ),
    ),
  );
}

Widget getRowTextArea(
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
        Icon(Icons.description_outlined),
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
            controller: controller,
            maxLines: 5,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              hintText: hintText,
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

Widget getButton(BuildContext context, String label, XFile _selectedImage,
    AccountController controller, AuthController auth,
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
        controller.updateData(auth.box.read("id_user"), _selectedImage);
      } else {
        print("Gagal");
      }
    },
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
