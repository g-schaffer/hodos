import 'package:flutter/material.dart';
import 'package:hodos/views/screens/login.dart';
import 'package:hodos/views/screens/search_route_page.dart';
import 'package:hodos/views/screens/user_page.dart';

class FlottantMenu extends StatelessWidget {
  const FlottantMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Button to search
          FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const SearchRoutePage(),
              ));

            },            elevation: 0,
            child: const Icon(
              Icons.search,
              color: (Colors.black),
            ),
          ),
          //Button to add
          FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 81, 114, 85),
            onPressed: () {},
            elevation: 10,
            child: const Icon(
              Icons.add,
              color: (Colors.black),
            ),
          ),
          //Profil button
          FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const UserProfil(),
        ));
      
            },
            elevation: 0,
            child: const Icon(
              Icons.account_circle,
              color: (Color.fromARGB(255, 81, 114, 85)),
            ),
          ),
        ],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
