import 'dart:convert';

import 'place_details.dart';
import 'package:http/http.dart' as http;

class PlaceStore {
  List<PlaceDetails> placeDetails;

  String rootURL;

  PlaceStore()
      : placeDetails = [],
        rootURL = "http://192.168.50.24:8000/";

  Future<void> add(PlaceDetails placeDetails) async {
    var jsonBody = JsonEncoder().convert(placeDetails.toJson());
    await http.post(Uri.parse(rootURL + "places"),
        headers: {"Content-Type": "application/json"}, body: jsonBody);
    await fetchList();
  }

  Future<void> removeAt(int index) async {
    await http.delete(Uri.parse(rootURL + "places/" + index.toString()));
    await fetchList();
  }

  Future<void> fetchList() async {
    var places = await http.get(Uri.parse("http://192.168.50.24:8000/"));
    var placeJsons = jsonDecode(utf8.decode(places.bodyBytes)) as List;
    placeDetails.clear();
    placeJsons.forEach((element) {
      placeDetails.add(PlaceDetails.fromJson(element));
    });
  }

  List<PlaceDetails> getDetails() {
    return placeDetails;
  }

  int length() {
    return placeDetails.length;
  }

  PlaceDetails operator [](int i) {
    return placeDetails[i];
  }
}
