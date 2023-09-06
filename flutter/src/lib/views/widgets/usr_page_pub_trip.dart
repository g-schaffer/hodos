// import 'dart:html';

import 'package:flutter/material.dart';

class PublishedTrips extends StatelessWidget {
  const PublishedTrips({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Expanded(
            child: Container(
                height: 145,
                child: const Trip(
                  title: "voyage n1",
                  image:
                      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                  description: "description",
                ))),
        Expanded(
            child: Container(
                height: 145,
                child: const Trip(
                  title: "voyage n2",
                  image:
                      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                  description: "description",
                )))
      ]),
      Row(children: [
        Expanded(
            child: Container(
          height: 145,
          child: const Trip(
            title: "voyage n3",
            image:
                "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Paris_Opera_full_frontal_architecture%2C_May_2009_%28cropped%29.jpg/1280px-Paris_Opera_full_frontal_architecture%2C_May_2009_%28cropped%29.jpg",
            description: "description",
          ),
        )),
        Expanded(
            child: Container(
                height: 145,
                child: const Trip(
                  title: "voyage n4",
                  image:
                      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                  description: "description",
                )))
      ])
    ]);
  }
}

class Trip extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const Trip(
      {Key? key,
      required this.image,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          left: 0,
          right: 0,
          child: Image(height: 160, image: NetworkImage(image)),
        ),
        Positioned(
            bottom: 45,
            left: 0,
            right: 45,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
        Positioned(
            bottom: 30,
            left: 0,
            right: 65,
            child: Text(
              description,
              textAlign: TextAlign.center,
            ))
      ],
    );
  }
}
