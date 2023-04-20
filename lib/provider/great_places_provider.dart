//in udemy course this file is named ad GreatPlaces
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../models/place_location.dart';
import '../helpers/db_helper.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return List.from(_items);
  }

  Future<void> fetchAndSetPlaces() async {
    final places = await DbHelper.getPlaces();
    final tempList = places.map((val) {
      return Place(
        id: val['id'].toString(),
        title: val['title'].toString(),
        image: File(
          val['image'].toString(),
        ),
      );
    }).toList();
    _items = tempList;

    notifyListeners();
  }

  void addPlace(Place p) async {
    _items.add(p);
    final statusCode = await DbHelper.insert(
      {
        "id": p.id,
        "title": p.title,
        "image": p.image.path,
      },
    );
    print(statusCode);
    notifyListeners();
  }
}
