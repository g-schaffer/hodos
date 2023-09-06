import 'package:flutter/material.dart';
import 'package:hodos/models/route.dart';
import 'package:hodos/views/widgets/starRating.dart';
import 'package:hodos/views/screens/detail_route.dart';


class TripCard extends StatefulWidget {
  final RouteT route;

  const TripCard(this.route);

  @override
  _TripCard createState() => _TripCard();
}

class _TripCard extends State<TripCard> {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () =>   Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailRoute())),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              // image: AssetImage("assets/icons/icon_timer.png"),
              image: NetworkImage(widget.route.urlImage),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(children: [
            Spacer(),
            Container(
              child: Text(widget.route.title,
                style: TextStyle(color: Colors.white, fontSize:18, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(right:10, left:10)
            ),
            Container(
              child: StarRating(
                rating: widget.route.rating,
              ),
              margin: EdgeInsets.only(left:10),
            ), // Rate stars
            Container(
              margin: EdgeInsets.only(right:10, left:10, bottom:10),
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Expanded(child: Container()), // left space
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Image(
                              image: AssetImage('lib/assets/icons/icon_distance4.png'),
                              height: 20.0,
                              width: 20.0,
                              color: Colors.white
                            ),
                            margin: EdgeInsets.only(right:5)
                          ),
                          Text(
                            widget.route.getStrDistanceKm() + " Km",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ]
                      ),
                      Row(
                        children: [
                          Container(
                            child: Image(
                              image: AssetImage('lib/assets/icons/icon_timer.png'),
                              height: 20.0,
                              width: 20.0,
                              color: Colors.white
                            ),
                            margin: EdgeInsets.only(right:5)
                          ),
                          Text(
                            widget.route.getStrAvgTimeMin() + " Min",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ]
                      )
                    ]
                  )
                ]
              )
            ),
          ]),
        )
      )
    );
  }
}

