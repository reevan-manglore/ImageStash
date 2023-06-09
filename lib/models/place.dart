import 'dart:io';

import './place_location.dart';

class Place {
  final String id;
  final String title;
  final File image;
  final PlaceLocation? location;

  Place({
    required this.id,
    required this.title,
    this.location,
    required this.image,
  });
}
