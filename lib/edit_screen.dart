import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'place_details.dart';

class EditScreen extends StatelessWidget {
  PlaceDetails place;

  EditScreen({Key? key})
      : place = PlaceDetails(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add a place'),
        ),
        body: Center(
          child: Form(
            child: Column(
              children: <Widget>[
                // Add TextFormFields and ElevatedButton here.
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.business),
                    hintText: 'Name of the place',
                    labelText: 'Name *',
                  ),
                  validator: (String? value) {
                    return (value != null && value.length > 0)
                        ? 'Name can not be empty'
                        : null;
                  },
                  onChanged: (str) {
                    place.name = str;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.place),
                    hintText: 'The location of the place',
                    labelText: 'Location *',
                  ),
                  validator: (String? value) {
                    return (value != null && value.length > 0)
                        ? 'Name can not be empty'
                        : null;
                  },
                  onChanged: (str) {
                    place.location = str;
                  },
                ),
                TextFieldTags(
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
                    onTag: (tag) {
                      place.tags.add(tag);
                    },
                    onDelete: (tag) {
                      place.tags.remove(tag);
                    },
                    validator: (tag) {
                      if (tag.length > 15) {
                        return "hey that's too long";
                      }
                      return null;
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, place);
                    },
                    child: const Text('Add Place'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
