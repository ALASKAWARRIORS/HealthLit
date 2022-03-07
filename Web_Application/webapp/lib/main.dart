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

enum filterType {F_Name, L_Name, Age, Sex, U_ID, Email}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _UserSearchFormState extends State<UserSearchForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final moduleController = TextEditingController();
  final userController = TextEditingController();
  final CollectionReference moduleCollection = FirebaseFirestore.instance.collection("modules");
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  String input = "";
  filterType? _filter = filterType.F_Name;
  
  Future<void> addModule(String input) async {
    int counter = 1;
    await moduleCollection.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        counter = counter + 1;
        });
    });
    print(counter);
    String newMod = "Module" + counter.toString();
    print(newMod);
    moduleCollection.add({
      "title": newMod,
      "content": input
    });
    print("finished");
  }

  Future<void> getAllUsers() async {
    String newString = "";
    await userCollection.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        newString = newString + doc["First_Name"] + " " + doc["Last_Name"] + " " + doc["Age"].toString() + " " + doc["Sex"] + "  " + doc["User_ID"] + " " + doc["Email"] + "\n";
      });
    });
    setState(() {
      input = newString;
    });
  }

  Future<void> getUsersFN (String F_Name) async {
    String newString = "";
    await userCollection.where("First_Name", isEqualTo: F_Name).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        newString = newString + doc["First_Name"] + " " + doc["Last_Name"] + " " + doc["Age"].toString() + " " + doc["Sex"] + "  " + doc["User_ID"] + " " + doc["Email"] + "\n";
      });
    });
    print("Done");
    setState(() {
      input = newString;
      print(input);
    });
  }  

  Future<void> getUsersLN (String L_Name) async {
    String newString = "";
    await userCollection.where("Last_Name", isEqualTo: L_Name).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        newString = newString + doc["First_Name"] + " " + doc["Last_Name"] + " " + doc["Age"].toString() + " " + doc["Sex"] + "  " + doc["User_ID"] + " " + doc["Email"] + "\n";
      });
    });
    setState(() {
      input = newString;
    });
  }  

  Future<void> getUsersAge (String Age) async {
    String newString = "";
    await userCollection.where("Age", isEqualTo: int.parse(Age)).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        newString = newString + doc["First_Name"] + " " + doc["Last_Name"] + " " + doc["Age"].toString() + " " + doc["Sex"] + "  " + doc["User_ID"] + " " + doc["Email"] + "\n";
      });
    });
    setState(() {
      input = newString;
    });
  }  

  Future<void> getUsersSex (String Sex) async {
    String newString = "";
    await userCollection.where("Sex", isEqualTo: Sex).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        newString = newString + doc["First_Name"] + " " + doc["Last_Name"] + " " + doc["Age"].toString() + " " + doc["Sex"] + "  " + doc["User_ID"] + " " + doc["Email"] + "\n";
      });
    });
    setState(() {
      input = newString;
    });
  }
  Future<void> getUsersUID (String User_ID) async {
    String newString = "";
    await userCollection.where("User_ID", isEqualTo: User_ID).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        newString = newString + doc["First_Name"] + " " + doc["Last_Name"] + " " + doc["Age"].toString() + " " + doc["Sex"] + "  " + doc["User_ID"] + " " + doc["Email"] + "\n";
      });
    });
    setState(() {
      input = newString;
    });
  }  

  Future<void> getUsersEmail (String Email) async {
    String newString = "";
    await userCollection.where("Email", isEqualTo: Email).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        newString = newString + doc["First_Name"] + " " + doc["Last_Name"] + " " + doc["Age"].toString() + " " + doc["Sex"] + "  " + doc["User_ID"] + " " + doc["Email"] + "\n";
      });
    });
    setState(() {
      input = newString;
    });
  }    

  void updateInput(String input)
  {
    print(input);
    if(input.isEmpty)
    {
      getAllUsers();
    }
    else if(_filter == filterType.F_Name)
    {
      
      getUsersFN(input);
    }
    else if(_filter == filterType.L_Name)
    {
      
      getUsersLN(input);
    }
    else if(_filter == filterType.Age)
    {
      
      getUsersAge(input);
    }
    else if(_filter == filterType.Sex)
    {
      
      getUsersSex(input);
    }
    else if(_filter == filterType.U_ID)
    {
      
      getUsersUID(input);
    }
    else if(_filter == filterType.Email)
    {
      
      getUsersEmail(input);
    }
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
              height: 50,
              color: Colors.grey,
              child: Center(
                child: TextField(
                  controller: moduleController,
                  decoration: InputDecoration(
                    hintText: 'Copy and Paste Module Here'
                  )
                )
              )
            ),
            OutlinedButton(
              onPressed: () {
                addModule(moduleController.text);
              },
              child: Text("Upload"),
            ),
            RadioListTile(
              title: Text("First Name"),
              value: filterType.F_Name, 
              groupValue: _filter, 
              onChanged: (filterType? value) {
                setState(() {
                  _filter = value;
                });
              }
            ),
            RadioListTile(
              title: Text("Last Name"),
              value: filterType.L_Name, 
              groupValue: _filter, 
              onChanged: (filterType? value) {
                setState(() {
                  _filter = value;
                });
              }
            ),
            RadioListTile(
              title: Text("Age"),
              value: filterType.Age, 
              groupValue: _filter, 
              onChanged: (filterType? value) {
                setState(() {
                  _filter = value;
                });
              }
            ),
            RadioListTile(
              title: Text("Sex"),
              value: filterType.Sex, 
              groupValue: _filter, 
              onChanged: (filterType? value) {
                setState(() {
                  _filter = value;
                });
              }
            ),
            RadioListTile(
              title: Text("User ID"),
              value: filterType.U_ID, 
              groupValue: _filter, 
              onChanged: (filterType? value) {
                setState(() {
                  _filter = value;
                });
              }
            ),
            RadioListTile(
              title: Text("Email Adress"),
              value: filterType.Email, 
              groupValue: _filter, 
              onChanged: (filterType? value) {
                setState(() {
                  _filter = value;
                });
              }
            ),
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
                updateInput(userController.text);
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


