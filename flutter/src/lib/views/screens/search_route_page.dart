import 'package:flutter/material.dart';
import 'package:hodos/views/widgets/widgets.dart';
import 'package:hodos/models/route.dart';
import 'package:hodos/views/widgets/custom_input_field.dart';
import 'package:flutter/services.dart';

class SearchRoutePage extends StatelessWidget {
  const SearchRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Get the list with the API
    RouteT route = RouteT(
        "Titre",
        "description",
        "https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6.jpg",
        4653,
        15030,
        1.5,
        "Thomas DESCHOMBECK",
        13,
        45.746284061664156,
        4.835110613348637);
    RouteT route2 = RouteT(
        "Titre2",
        "description",
        "https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6.jpg",
        120,
        3000,
        4.5,
        "Thomas DESCHOMBECK",
        10,
        45.746284061664156,
        4.835110613348637);
    List<RouteT> listRoutes = [
      route,
      route2,
      route,
      route,
      route2,
      route2,
      route,
      route2,
      route2
    ];

    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 90,
          child: Container(
            margin:
                const EdgeInsets.only(bottom: 15, top: 40, left: 40, right: 40),
            child: const CustomInputField(
              labelText: "",
              suffixicon: (Icons.search),
              obscureText: false,
              formProperty: 'search',
              formValues: {
                'search': "",
              },
            ),
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            padding:
                const EdgeInsets.only(bottom: 10, top: 10, left: 20, right: 20),
            children: List.generate(listRoutes.length, (index) {
              return TripCard(listRoutes.elementAt(index));
            }),
          ),
        )
      ]),
      persistentFooterButtons: const [FlottantMenu()],
    );
  }
}
