import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'place_details.dart';

class DeleteAction {}

class ViewPlace extends StatelessWidget {
  PlaceDetails place;

  ViewPlace({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text(place.name), actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete Item',
            onPressed: () {
              Navigator.pop(context, DeleteAction());
            },
          )
        ]),
        body: Center(
            child: Column(
          children: [
            Text(place.location),
            TextFieldTags(
                initialTags: place.tags.toList(),
                tagsStyler: TagsStyler(
                  tagTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  tagDecoration: BoxDecoration(
                    color: Colors.pink.shade200,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  tagCancelIcon: Icon(Icons.cancel,
                      size: 16.0, color: Colors.pink.shade400),
                  tagPadding: const EdgeInsets.all(10.0),
                ),
                textFieldStyler: TextFieldStyler(
                  icon: const Icon(Icons.tag),
                ),
                onTag: (tag) {},
                onDelete: (tag) {},
                validator: (tag) {
                  if (tag.length > 15) {
                    return "hey that's too long";
                  }
                  return null;
                }),
          ],
        )));
  }
}
