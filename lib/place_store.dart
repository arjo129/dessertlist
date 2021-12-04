import 'dart:convert';
import 'secrets.dart';
import 'place_details.dart';
import 'package:http/http.dart' as http;

class PlaceStore {
  List<PlaceDetails> placeDetails;

  String rootURL;

  String apiSecret;

  PlaceStore()
      : placeDetails = [],
        rootURL = "https://laksa.arjo129.com/dessertlist/api/",
        apiSecret = apiKey;

  Future<void> add(PlaceDetails placeDetails) async {
    var jsonBody = JsonEncoder().convert(placeDetails.toJson());
    await http.post(Uri.parse(rootURL + "places?access_code=" + apiSecret),
        headers: {"Content-Type": "application/json"}, body: jsonBody);
    await fetchList();
  }

  Future<void> removeAt(int index) async {
    await http.delete(Uri.parse(
        rootURL + "places/" + index.toString() + "?access_code=" + apiSecret));
    await fetchList();
  }

  Future<void> fetchList() async {
    var places =
        await http.get(Uri.parse(rootURL + "?access_code=" + apiSecret));
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
