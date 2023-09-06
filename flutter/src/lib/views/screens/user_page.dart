import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hodos/constants.dart';
import 'package:hodos/views/widgets/usr_page_top.dart';
import 'package:hodos/views/widgets/usr_page_pub_trip.dart';
import 'package:hodos/views/widgets/flottant_menu.dart';

class UserProfil extends StatelessWidget {
  const UserProfil({super.key});

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "User profil",
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
                body: SafeArea(
                    child: Column(children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height / 2.5,  // Also Including Tab-bar height.
                    child: const ProfilDescription(image: "https://www.treehugger.com/thmb/ifuEx0MOjhfNU2jHtMisIpy1NUQ=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__mnn__images__2018__06__nature-phpoto-day-squirrel-6b50719b524c4ecbb3152a32baa38367.jpg", username: "Jules CROIDIEU", description: "Un jour, j'étais à Lyon en vacances et je me suis demandé comment j'allais faire pour devenir le roi des rues."),),
                  const PreferredSize(
                    preferredSize: Size.fromHeight(10.0),
                    child: TabBar(
                      labelColor: Colors.black,
                      tabs: [
                        Tab(
                          text: 'Published trips',
                        ),
                        Tab(
                          text: 'Visited trips')])),
                  Expanded(
                    child: TabBarView(
                      children: [
                        const PublishedTrips(),
                        Container(
                          color: Colors.white,
                          child: const PublishedTrips(),
                        )
                      ],
                    ),
                  ),

                ])),
                persistentFooterButtons: const [FlottantMenu()],
                )));
  }
}
