import 'package:flutter/material.dart';
import 'package:hodos/views/widgets/widgets.dart';
import 'package:hodos/models/route.dart';
import 'package:hodos/views/widgets/custom_input_field.dart';
import 'package:flutter/services.dart';

class SearchRoutePage extends StatefulWidget {
  const SearchRoutePage({Key? key}) : super(key: key);

  @override
  _SearchRoutePageState createState() => _SearchRoutePageState();
}

class _SearchRoutePageState extends State<SearchRoutePage> {
  String _searchText = "";

  @override
  Widget build(BuildContext context) {
    // TODO: Get the list with the API
    RouteT route = RouteT(
        "France",
        "description",
        "https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6.jpg",
        4653,
        15030,
        4,
        "Thomas DESCHOMBECK",
        133333,
        45.746284061664156,
        4.835110613348637);
    RouteT route2 = RouteT(
        "Egypte",
        "description",
        "https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6.jpg",
        120,
        3000,
        4.5,
        "Thomas DESCHOMBECK",
        10,
        45.746284061664156,
        4.835110613348637);
    RouteT route3 = RouteT(
        "Brésil",
        "description",
        "https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6.jpg",
        120,
        3000,
        2,
        "Jules Croid",
        10,
        45.746284061664156,
        4.835110613348637);
    List<RouteT> listRoutes = [      route,      route2,      route3    ];

    List<RouteT> filteredRoutes = listRoutes
        .where((route) => route.title.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // couleur de fond
        title: Padding(
          padding: const EdgeInsets.all(150.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchText = value;
              });
            },
            decoration: InputDecoration(
              hintText: "Rechercher",
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ),


      body: Column(children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: 4,
            padding: const EdgeInsets.only(bottom: 50, top: 50, left: 50, right: 50),
            children: List.generate(filteredRoutes.length, (index) {
              return TripCard(filteredRoutes.elementAt(index));
            }),
          ),
        )

      ]),
      persistentFooterButtons: const [FlottantMenu()],
    );
  }
}
