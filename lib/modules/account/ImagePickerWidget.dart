import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  List<File> selectedImages = [];

  Future<void> _pickImages() async {
    final List<XFile>? images = await ImagePicker().pickMultiImage();

    if (images != null) {
      List<File> newImages = [];

      for (var image in images) {
        File file = File(image.path);
        newImages.add(file);
      }

      setState(() {
        selectedImages = newImages;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _pickImages,
          style: ElevatedButton.styleFrom(
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            elevation: 0,
            backgroundColor: Colors.grey,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
            padding: EdgeInsets.symmetric(vertical: 24),
            minimumSize: const Size.fromHeight(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pilih Gambar',
                textAlign: TextAlign.center,
              ),
              SizedBox(width: 8),
              Icon(Icons.add_a_photo_outlined),
            ],
          ),
        ),
        SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: selectedImages.length,
            itemBuilder: (context, index) {
              return Image.file(selectedImages[index]);
            },
          ),
        ),
      ],
    );
  }
}
