import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FutureBuilder(
        future:_initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error");
          }
          if (snapshot.connectionState == ConnectionState.done)
          {
            return MaterialApp(
              title: "Web Portal",
              home: UserSearchForm(),
            );
          }
          return CircularProgressIndicator();
        }
      ),
    );
  }
}

// Define a custom Form widget.
class UserSearchForm extends StatefulWidget {
  const UserSearchForm({Key? key}) : super(key: key);

  @override
  _UserSearchFormState createState() => _UserSearchFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _UserSearchFormState extends State<UserSearchForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final userController = TextEditingController();
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");
  String input = "";
  String firstName = "";

  void updateInput(String newString)
  {
    setState(() {
      input = input + newString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Web Portal"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 40,
              color: Colors.grey,
              child: Center(
                child: TextField(
                  controller: userController,
                  decoration: InputDecoration(
                    hintText: 'Search for a User',
                  )
                )
              )
            ),
            OutlinedButton(
              onPressed: () {
                userCollection.get().then((QuerySnapshot querySnapshot) {
                  querySnapshot.docs.forEach((doc) {
                    firstName = doc["FirstName"] + " " + doc["LastName"] +"\n";
                    updateInput(firstName);
                  });
                });
              },
              child: Text("Search"),
            ),
            Text(input)
          ]
        ),
      ),
    );
  }
}


