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
  late Future<void> fut;

  void _addPlace() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditScreen()),
    );

    if (result is PlaceDetails) {
      await places.add(result);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    fut = places.fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: FutureBuilder<void>(
        future: fut,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return ListView.separated(
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
                          builder: (context) =>
                              ViewPlace(place: places[index])));
                  if (res is DeleteAction) {
                    await places.removeAt(index);
                    setState(() {});
                  }
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        },
      )),
      // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButton: FloatingActionButton(
        onPressed: _addPlace,
        tooltip: 'Add Place',
        child: const Icon(Icons.add),
      ),
    );
  }
}
