import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hodos/models/tag.dart';
import 'package:hodos/models/route.dart';
import 'package:hodos/models/comment.dart';

void main() => runApp(const DetailRoute());

class DetailRoute extends StatelessWidget {
  const DetailRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO
    RouteT route = RouteT(
        "Titre2",
        "description",
        "https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6.jpg",
        120,
        3000,
        4.5,
        "Taboulette",
        53,
        45.746284061664156,
        4.835110613348637);

    // TODO
    String access_token =
        "pk.eyJ1IjoidGhvbWFzZGVzY2hvbWJlY2siLCJhIjoiY2trNzNuMjltMGEzbjJ3bzB6aTg0ODBiYSJ9.PbzRPhAK49o9iDdwcwc_qQ";
    String beginMarkerLat = "45.746284061664156";
    String beginMarkerLng = "4.835110613348637";
    String arrivalMarkerLat = "45.74682686491151";
    String arrivalMarkerLng = "4.836805769566171";

    String widthScreen =
        (MediaQuery.of(context).size.width * 1.5).toString().split('.')[0];
    String heightMap = "375";

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
                child: Image(
                  image: NetworkImage(
                      "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/geojson(%7B%22type%22%3A%22Feature%22%2C%22properties%22%3A%7B%22marker-size%22%3A%22s%22%2C%22marker-color%22%3A%22%23ee3636%22%7D%2C%22geometry%22%3A%7B%22type%22%3A%22MultiPoint%22%2C%22coordinates%22%3A%5B%5B" +
                          beginMarkerLng +
                          "%2C" +
                          beginMarkerLat +
                          "%5D%2C%5B" +
                          arrivalMarkerLng +
                          "%2C%20" +
                          arrivalMarkerLat +
                          "%5D%5D%7D%7D%0A)/" +
                          route.lng.toString() +
                          "," +
                          route.lat.toString() +
                          ",16,0,0/" +
                          widthScreen +
                          "x" +
                          heightMap +
                          "?access_token=" +
                          access_token),
                  // fit: BoxFit.fill,
                )),
            PicturesContainer(),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(children: [
                Info(route),
                InfoCreator(route.creator),
                TagContainer(),
                CommentContainer(),
              ])),
            ),
            StartButton(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}

class PicturesContainer extends StatefulWidget {
  const PicturesContainer({Key? key}) : super(key: key);

  @override
  _PicturesContainerState createState() => _PicturesContainerState();
}

class _PicturesContainerState extends State<PicturesContainer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          Container(
            margin: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Image(
                image: NetworkImage(
                    'https://www.epitech.eu/fr/wp-content/uploads/2020/06/IMG_3971.jpg'),
                width: 150,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Image(
                image: NetworkImage(
                    'https://www.epitech.eu/fr/wp-content/uploads/2020/06/IMG_3971.jpg'),
                width: 150,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Image(
                image: NetworkImage(
                    'https://www.epitech.eu/fr/wp-content/uploads/2020/06/IMG_3971.jpg'),
                width: 150,
              ),
            ),
          ),
        ]));
  }
}

class Info extends StatefulWidget {
  final RouteT route;

  const Info(this.route);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          Table(
            children: [
              TableRow(children: [
                Row(children: [
                  // Image(
                  //   image: AssetImage('lib/assets/icons/icon_distance.png'),
                  //   width: 20,
                  //   height: 20,
                  // ),
                  Text('Parcouru par: ' + widget.route.traveledBy.toString(),
                      textAlign: TextAlign.center),
                ]),
                Row(children: [
                  // Image(
                  //   image: AssetImage('lib/assets/icons/icon_distance.png'),
                  //   width: 20,
                  //   height: 20,
                  // ),
                  Text('Distance: ' + widget.route.getStrDistanceKm() + " km",
                      textAlign: TextAlign.center),
                ]),
              ]),
              TableRow(children: [
                Row(children: [
                  // Image(
                  //   image: AssetImage('lib/assets/icons/icon_distance.png'),
                  //   width: 20,
                  //   height: 20,
                  // ),
                  Text('Note: ' + widget.route.rating.toString() + "/5",
                      textAlign: TextAlign.center),
                ]),
                Row(children: [
                  // Image(
                  //   image: AssetImage('lib/assets/icons/icon_distance.png'),
                  //   width: 20,
                  //   height: 20,
                  // ),
                  Text(
                      'Temps moyen: ' +
                          widget.route.avgTime.toString() +
                          " min",
                      textAlign: TextAlign.center),
                ]),
              ]),
            ],
          ),
        ]));
  }
}

class InfoCreator extends StatefulWidget {
  final String creator;

  const InfoCreator(this.creator);

  @override
  _InfoCreatorState createState() => _InfoCreatorState();
}

class _InfoCreatorState extends State<InfoCreator> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        child: Text(
          "Created by: " + widget.creator,
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
        ));
  }
}

class TagContainer extends StatefulWidget {
  const TagContainer({Key? key}) : super(key: key);

  @override
  _TagContainerState createState() => _TagContainerState();
}

class _TagContainerState extends State<TagContainer> {
  @override
  Widget build(BuildContext context) {
    // TODO
    TagC tag1 = TagC("titre", 250, 130, 80, 13);
    TagC tag2 = TagC("titre", 135, 46, 189, 8);
    TagC tag3 = TagC("titre", 168, 100, 100, 4);
    TagC tag4 = TagC("titre", 100, 50, 100, 4);
    TagC tag5 = TagC("titre", 230, 120, 230, 1);
    TagC tag6 = TagC("titre", 30, 50, 13, 1);
    TagC tag7 = TagC("titre", 30, 80, 100, 1);

    List<TagC> listTags = [tag1, tag2, tag3, tag4, tag5, tag6, tag7];

    int width = 100;
    int height = 30;

    return Container(
      height: 110,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: GridView.builder(
          itemCount: listTags.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: height / width),
          itemBuilder: (context, position) {
            return Tag(listTags[position]);
          }),
    );
  }
}

class CommentContainer extends StatefulWidget {
  const CommentContainer({Key? key}) : super(key: key);

  @override
  _CommentContainerState createState() => _CommentContainerState();
}

class _CommentContainerState extends State<CommentContainer> {
  @override
  Widget build(BuildContext context) {
    // TODO
    CommentC comment = CommentC(
        "Le contenu du commentaire",
        "https://www.fakepersongenerator.com/Face/male/male1084657983306.jpg",
        "Taboulette");
    List<CommentC> listComments = [
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment,
      comment
    ];

    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listComments.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Comment(listComments[index]);
        });
  }
}

class StartButton extends StatelessWidget {
  const StartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
      onPressed: () {},
      child: Text('Demarrer'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ));
  }
}

class Comment extends StatefulWidget {
  final CommentC comment;

  const Comment(this.comment);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(1, 1),
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        child: Column(children: [
          Row(children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image(
                image: NetworkImage(widget.comment.urlImageCreator),
                width: 50,
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.comment.usernameCreator,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // Text(widget.nbReview.toString() + " reviews"),
                  ],
                )),
            // const LikeButton(),
          ]),
          // RatingBarIndicator(
          //   rating: widget.rating,
          //   itemCount: 5,
          //   itemSize: 30.0,
          //   itemBuilder: (context, _) => const Icon(
          //     Icons.star,
          //     color: Colors.amber,
          //   ),
          // ),
          Row(children: [
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  widget.comment.message,
                )
                // child: RichText(
                //   text: TextSpan(
                //     text: 'A line with a newline character\n',
                //     // children: [
                //     //   TextSpan(
                //     //     text: 'A second line',
                //     //   ),
                //     // ]
                //   )
                // )
                )
          ]),
        ]));
  }
}

class Tag extends StatefulWidget {
  final TagC tag;

  const Tag(this.tag);

  @override
  _TagState createState() => _TagState();
}

class _TagState extends State<Tag> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      color: Color.fromRGBO(widget.tag.r, widget.tag.g, widget.tag.b, 1),
      child: Row(children: [
        Spacer(),
        Text("#",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        Spacer(),
        Text(widget.tag.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        Spacer(),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.only(right: 10),
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Center(
                child: Text(widget.tag.votes.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ))),
          ),
        ),
      ]),
    );
  }
}
