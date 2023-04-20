import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/great_places_provider.dart';

import './screens/home_page.dart';
import './screens/place_detail_screen.dart';
import './screens/add_place_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GreatPlacesProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          useMaterial3: true,
        ),
        routes: {
          HomePage.routeName: (context) => HomePage(),
          PlaceDetailScreen.routeName: (context) => PlaceDetailScreen(),
          AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
        },
        initialRoute: "/",
      ),
    );
  }
}
