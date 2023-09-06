import 'package:flutter/material.dart';
import 'dart:math';

class CommentPage extends StatefulWidget {
  const CommentPage({Key key = const Key('CommentPage')}) : super(key: key);
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final List<Map<String, dynamic>> _tags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commentaire'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Commentaire sur votre chemin',
              ),
              controller: _commentController,
              maxLines: null, // Ajoutez cette ligne pour agrandir la hauteur du champ
              style: const TextStyle(fontSize: 18), // Optionnel : augmentez la taille de la police
            ),

            SizedBox(height: 20.0),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Ajouter un tag',
              ),
              controller: _tagController,
              onSubmitted: (value) {
                // Generate a random color
                final random = Random();
                final color = Color.fromARGB(
                  255,
                  random.nextInt(256),
                  random.nextInt(256),
                  random.nextInt(256),
                );
                // Check if the tag already exists
                bool tagExists = false;
                for (final tag in _tags) {
                  if (tag['text'] == value) {
                    tagExists = true;
                    break;
                  }
                }

                if (!tagExists) {
                  setState(() {
                    _tags.add(
                      {
                        'text': value,
                        'color': color,
                      },
                    );
                  });
                } else {
                  // Show an error message if the tag already exists
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tag déjà existant'),
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.fixed,
                    ),
                  );
                }

                // Clear the text field
                _tagController.clear();
              },
            ),
            SizedBox(height: 16.0),
            Text('Liste des tags'),
            SizedBox(height: 4.0),
            Wrap(
        spacing: 8.0,
              runSpacing: 16.0, // Ajoutez cette ligne pour augmenter l'espace vertical entre les tags
        children: List.generate(_tags.length, (index) {
          return Chip(
            label: Text(_tags[index]['text']),
            backgroundColor: _tags[index]['color'],
            onDeleted: () {
              setState(() {
                _tags.removeAt(index);
              });
            },
          );
        }),
      ),
      SizedBox(height: 16.0),

    ],
    ),
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Envoyer le commentaire et les tags au serveur
        },
        label: Text('Envoyer'),
        icon: Icon(Icons.check),
      ),
    );
  }
}