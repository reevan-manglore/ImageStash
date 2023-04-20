import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../provider/great_places_provider.dart';
import '../models/place.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place-screen";

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleControler = TextEditingController();
  File? _imageFile;
  void _whenImagePicked(File _fileArgument) {
    _imageFile = _fileArgument;
  }

  void _saveData() {
    if (_titleControler.text.isEmpty || _imageFile == null) {
      return;
    }

    Provider.of<GreatPlacesProvider>(context, listen: false).addPlace(
      Place(
          id: UniqueKey().toString(),
          title: _titleControler.text,
          image: _imageFile!),
    );
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new Place"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleControler,
                        decoration: InputDecoration(
                          label: const Text("Title"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ImageInput(_whenImagePicked),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _saveData,
              icon: Icon(Icons.add),
              label: Text("Add Place"),
            )
          ],
        ),
      ),
    );
  }
}
