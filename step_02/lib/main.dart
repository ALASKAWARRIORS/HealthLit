import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';  // new
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:gtk_flutter/Module0.dart';
import 'package:gtk_flutter/Module1.dart';
import 'package:gtk_flutter/Module2.dart';
import 'package:gtk_flutter/loadpdf.dart';
import 'package:gtk_flutter/src/signin.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart'; // new
import 'Module.dart';
import 'Module3.dart';
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
        body: SingleChildScrollView(
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
                    title: Text('NVS Test'),
                    subtitle: Text('The Newest Vital Sign Test, Health Literacy Assessment'),
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
                                builder: (context) => moduleZeroPage()),
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
                                builder: (context) => loadPdfMod2()),
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
                                builder: (context) => loadPdfMod3()),
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
                      MaterialPageRoute(builder: (context) => loadPdf()));
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


