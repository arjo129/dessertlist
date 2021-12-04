import 'package:flutter/material.dart';
import 'edit_screen.dart';
import 'place_store.dart';
import 'place_details.dart';
import 'view_place.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.pink,
        ),
        home: const MyHomePage(title: 'Dessert List'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PlaceStore places = PlaceStore();

  void _addPlace() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditScreen()),
    );

    if (result is PlaceDetails) {
      await places.add(result);
      setState(() {
        // This call to setState tells the Flutter framework that something has
        // changed in this State, which causes it to rerun the build method below
        // so that the display can reflect the updated values. If we changed
        // _counter without calling setState(), then the build method would not be
        // called again, and so nothing would appear to happen.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: places.length(),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Container(
              height: 50,
              color: Colors.pink.shade100,
              child: Center(child: Text(places[index].name)),
            ),
            onTap: () async {
              final res = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewPlace(place: places[index])));
              if (res is DeleteAction) {
                await places.removeAt(index);
                setState(() {});
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPlace,
        tooltip: 'Add Place',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
