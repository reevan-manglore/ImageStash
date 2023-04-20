import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = "/place-detail-screen";
  final String _placeName = "mangalore";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details of $_placeName"),
      ),
    );
  }
}
