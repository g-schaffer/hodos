import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../constants.dart';

class ProfilDescription extends StatelessWidget {
  final String image;
  final String username;
  final String description;

  const ProfilDescription({
    Key? key,
    required this.image,
    required this.username,
    required this.description
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      const Positioned(
        top: 5,
        child: BackButton()),


      Positioned(
        top: 60,
        left: 20,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.54,
            child: Text(
              username,
              style: TextStyle(fontSize: 35),
              softWrap: true,
            ),)
          ),

        Positioned(
          top: 145,
          left: 20,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.54,
            child: Text(
              description,
              softWrap: true,
            ),
          ),
        ),

        Positioned(
        top: 55,
        right: 35,
        child: CircleAvatar(
          backgroundImage: NetworkImage(image),
          radius: 69)),


        Positioned(
          right: 22,
          bottom: 95,
            child: IconButton(
              icon: Icon(Icons.settings),
              iconSize: 45,
              color: Colors.black87,
              onPressed: () async {
               // String? tokenAccess = await storage.read(key: "token_access");
                try {
                  var body = <String, dynamic>{};
                  body["refresh"] = "string";
                  final response = await http.post(
                    Uri.parse(ApiConstants.baseUrl + ApiConstants.logout),
                    // headers: {
                    //   'Authorization': 'Bearer $tokenAccess',
                    // },

                    body: body,
                  );
                  if (response.statusCode == 200) {
                    // Handle successful logout
                  } else {
                    // Handle error
                  }
                } catch (e) {
                  // Handle error
                 }
              },
            ),
        ),


        Positioned(
          right: 15,
          bottom: 270,
          child: IconButton(
            icon: Icon(Icons.logout, color: Colors.red,),
            iconSize: 30,
            onPressed: () async {
              try {
                var body = <String, dynamic>{};
                body["refresh"] = "string";
                final response = await http.post(
                  Uri.parse(ApiConstants.baseUrl + ApiConstants.logout),
                  body: body,
                );
                if (response.statusCode == 200) {
                  // Handle successful logout
                } else {
                  // Handle error
                }
              } catch (e) {
                // Handle error
              }
            },
          ),
        ),


        Positioned.fill(
            top: 210,
            child: Row(
              children: [
                Expanded(child: TextButton(
                  onPressed: () {},
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    width: 130,
                    child: const Text(
                      'Follow',
                      style: TextStyle(color: Colors.white, fontSize: 13.0),
                    ),
                  ),
                )),
          Expanded(child: TextButton(
                  onPressed: () {},
                  child: Container(
                    color: Colors.grey,
                    width: 130,
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: const Text(
                      'Send Message',
                      style: TextStyle(color: Colors.white, fontSize: 13.0),
                    ),
                  ),
                ),)],)),
    ]);
  }
}