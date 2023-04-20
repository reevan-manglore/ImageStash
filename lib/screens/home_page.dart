//in udemy course this file is named as places_list_screen

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../provider/great_places_provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
          future: Provider.of<GreatPlacesProvider>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (context, AsyncSnapshot dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (dataSnapshot.hasError) {
              return Center(
                child: Text("An error occured while loading data"),
              );
            }
            return Consumer<GreatPlacesProvider>(
              child: Center(
                child: Text(
                  "No Products found\n press '+' to add data",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              builder: (context, placeData, child) {
                if (placeData.items.length > 0) {
                  return ListView.builder(
                    itemBuilder: (ctx, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              FileImage(placeData.items[index].image),
                        ),
                        title: Text(placeData.items[index].title),
                      );
                    },
                    itemCount: placeData.items.length,
                  );
                } else {
                  return child!;
                }
              },
            );
          }),
    );
  }
}
