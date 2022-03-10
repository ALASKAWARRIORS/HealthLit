import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';  // new
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:gtk_flutter/Module1.dart';
import 'package:gtk_flutter/Module2.dart';
import 'package:gtk_flutter/flashcard.dart';
import 'package:gtk_flutter/src/signin.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart'; // new
import 'Module.dart';
import 'Module3.dart';
import 'flashcardView.dart';
import 'src/authentication.dart';                  // new


final firestoreInstance = FirebaseFirestore.instance;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
  // to here.
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Authentication>(
          create: (_) => Authentication(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<Authentication>().authStateChange, initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Tasks Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return CoursePage(title: '');
    }
    return SignIn();
  }
}

class CoursePage extends StatefulWidget {
  CoursePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Module Selection Page'),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Please select your desired module.",
                  style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.event_note),
                    title: Text('Food'),
                    subtitle: Text('Health Literacy Food.'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(width: 3),
                      TextButton(
                        child: const Text('OPEN'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => moduleOnePage()),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.event_note),
                    title: Text('Nutrition'),
                    subtitle: Text('Health Literacy Food Nutrition.'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(width: 3),
                      TextButton(
                        child: const Text('OPEN'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => moduleTwoPage()),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.event_note),
                    title: Text('Medication Dosing'),
                    subtitle: Text('Health Literacy Medication Dosing.'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(width: 3),
                      TextButton(
                        child: const Text('OPEN'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => moduleThreePage()),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
              RaisedButton(
                child: Text('Data Retrieval'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new dbStuff()));
                },
              ),
              RaisedButton(
                onPressed: () {
                  context.read<Authentication>().signOut();
                },
                child: Text("Sign out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class dbStuff extends StatelessWidget {
  final TextEditingController dataController = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Database Example')),
      //StreamBuilder recieves the database response snapshot and allows us to extract data.
        body: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('modules ').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children: snapshot.data.docs.map((document) {
                      return Center(
                        child: Container(
                          // width: MediaQuery.of(context).size.width/1.2,
                          // height: MediaQuery.of(context).size.width/3,
                          child: Text("Title: " + document['title'] + "\n"),
                        ),
                      );
                    }).toList(),
                  );
                }
                ),
            );
  }
}
class modOneGameWidget extends StatefulWidget{
  const modOneGameWidget({Key key}) : super(key : key);

  @override
  modOneGame createState() => modOneGame();
}

class modOneGame extends State<modOneGameWidget> {

  List<Flashcard> flashcards = [
    Flashcard('What is a food group?', 'Category of foods that contain similar '
  'nutrients.'),
    Flashcard('How many servings of grains are recommended?', '6-11 of bread, '
        'cereal, rice, and pasta'),
    Flashcard('What food group has good sources of vitamins,'
        'minerals, and complex carbohydrates?',
        'Grains, make half your grains '
            'whole grain bread, cereal, rice, and pasta')
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Module 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: FlipCard(
                front: FlashcardView(flashcards[currentIndex].question),
                back: FlashcardView(flashcards[currentIndex].answer),
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton.icon(
                  onPressed: showPreviousCard,
                  icon: Icon(Icons.chevron_left),
                  label: Text("Prev")
                ),
                OutlinedButton.icon(
                  onPressed: showNextCard,
                  icon: Icon(Icons.chevron_right),
                  label: Text("Next")
                )
              ]
            )
          ],
        )
      )
      );
  }
  void showNextCard() {
    setState(() {
      currentIndex =
          (currentIndex + 1 < flashcards.length) ? currentIndex + 1 : 0;
    });
  }
  void showPreviousCard() {
    setState(() {
      currentIndex =
          (currentIndex - 1 >= 0) ? currentIndex - 1 : flashcards.length - 1;
    });
  }


}

