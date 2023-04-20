import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path/path.dart' as path;

//print path is /data/user/0/com.example.native_device_features_tutorial/app_flutter/
class ImageInput extends StatefulWidget {
  Function _whenImagePicked;

  ImageInput(this._whenImagePicked);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  XFile? _selectedFile;
  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage() async {
    final _imageSource = await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text("Choose Image from"),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
        children: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pop(ImageSource.camera);
            },
            style: ButtonStyle(
              alignment: Alignment.topLeft,
            ),
            icon: Icon(
              Icons.camera_alt,
            ),
            label: Text(
              "From Camera",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pop(ImageSource.gallery);
            },
            style: ButtonStyle(
              alignment: Alignment.topLeft,
            ),
            icon: Icon(
              Icons.filter,
            ),
            label: Text(
              "From  Gallery",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
    if (_imageSource != null) {
      final temp = await _picker.pickImage(
        source: _imageSource,
        maxWidth: 300,
        maxHeight: 300,
      );
      if (temp != null) {
        setState(() {
          _selectedFile = temp;
        });
        Directory appDiredctory =
            await pathProvider.getApplicationDocumentsDirectory();
        String fileName = path.basename(_selectedFile!.path);

        _selectedFile!.saveTo("${appDiredctory.path}/$fileName");
        print("${appDiredctory.path}/$fileName");
        widget._whenImagePicked(File("${appDiredctory.path}/$fileName"));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: _selectedFile != null
              ? Image.file(
                  File(_selectedFile!.path),
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Center(
                  child: Text(
                    "No Image Choosen",
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
        SizedBox(
          width: 20,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.camera),
          label: Text("Choose Image"),
        ),
      ],
    );
  }
}
