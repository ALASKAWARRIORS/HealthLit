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

enum filterType {F_Name, L_Name, CF_Name, CL_Name, C_Age, U_ID, Email}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _UserSearchFormState extends State<UserSearchForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final moduleController = TextEditingController();
  final userController = TextEditingController();
  final CollectionReference moduleCollection = FirebaseFirestore.instance.collection("modules ");
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
    String newMod = "Module" + counter.toString();
    moduleCollection.add({
      "title": newMod,
      "content": input
    });
  }

  Future<void> getAllUsers() async {
    String newString = "";
    await userCollection.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        newString = newString + doc["Userfirstname"] + " " + doc["Userlastname"] + " " + doc["childfname"] + " " + doc["childlname"] + "  " + doc["childAge"] + " " + doc["email"] + " " + doc["uid"] + "\n";
      });
    });
    setState(() {
      input = newString;
    });
  }

  Future<void> getUsersFN (String F_Name) async {
    String newString = "";
    await userCollection.where("Userfirstname", isEqualTo: F_Name).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        newString = newString + doc["Userfirstname"] + " " + doc["Userlastname"] + " " + doc["childfname"] + " " + doc["childlname"] + "  " + doc["childAge"] + " " + doc["email"] + " " + doc["uid"] + "\n";
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
    await userCollection.where("Userlastname", isEqualTo: L_Name).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        newString = newString + doc["Userfirstname"] + " " + doc["Userlastname"] + " " + doc["childfname"] + " " + doc["childlname"] + "  " + doc["childAge"] + " " + doc["email"] + " " + doc["uid"] + "\n";
      });
    });
    setState(() {
      input = newString;
    });
  }  

  Future<void> getUsersChildAge (String Age) async {
    String newString = "";
    await userCollection.where("childAge", isEqualTo: Age).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        newString = newString + doc["Userfirstname"] + " " + doc["Userlastname"] + " " + doc["childfname"] + " " + doc["childlname"] + "  " + doc["childAge"] + " " + doc["email"] + " " + doc["uid"] + "\n";
      });
    });
    setState(() {
      input = newString;
    });
  }  

   Future<void> getUsersCFN (String F_Name) async {
    String newString = "";
    await userCollection.where("childfname", isEqualTo: F_Name).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        newString = newString + doc["Userfirstname"] + " " + doc["Userlastname"] + " " + doc["childfname"] + " " + doc["childlname"] + "  " + doc["childAge"] + " " + doc["email"] + " " + doc["uid"] + "\n";
      });
    });
    print("Done");
    setState(() {
      input = newString;
      print(input);
    });
  }  

  Future<void> getUsersCLN (String L_Name) async {
    String newString = "";
    await userCollection.where("childlname", isEqualTo: L_Name).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        newString = newString + doc["Userfirstname"] + " " + doc["Userlastname"] + " " + doc["childfname"] + " " + doc["childlname"] + "  " + doc["childAge"] + " " + doc["email"] + " " + doc["uid"] + "\n";
      });
    });
    setState(() {
      input = newString;
    });
  }  
  Future<void> getUsersUID (String User_ID) async {
    String newString = "";
    await userCollection.where("uid", isEqualTo: User_ID).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        newString = newString + doc["Userfirstname"] + " " + doc["Userlastname"] + " " + doc["childfname"] + " " + doc["childlname"] + "  " + doc["childAge"] + " " + doc["email"] + " " + doc["uid"] + "\n";
      });
    });
    setState(() {
      input = newString;
    });
  }  

  Future<void> getUsersEmail (String Email) async {
    String newString = "";
    await userCollection.where("email", isEqualTo: Email).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        newString = newString + doc["Userfirstname"] + " " + doc["Userlastname"] + " " + doc["childfname"] + " " + doc["childlname"] + "  " + doc["childAge"] + " " + doc["email"] + " " + doc["uid"] + "\n";
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
    else if(_filter == filterType.CF_Name)
    {
      getUsersCFN(input);
    }
    else if(_filter == filterType.CL_Name)
    {
      getUsersCLN(input);
    }
    else if(_filter == filterType.C_Age)
    {
      getUsersChildAge(input);
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
              title: Text("Child's First Name"),
              value: filterType.CF_Name, 
              groupValue: _filter, 
              onChanged: (filterType? value) {
                setState(() {
                  _filter = value;
                });
              }
            ),
            RadioListTile(
              title: Text("Child's Last Name"),
              value: filterType.CL_Name, 
              groupValue: _filter, 
              onChanged: (filterType? value) {
                setState(() {
                  _filter = value;
                });
              }
            ),
            RadioListTile(
              title: Text("Child's Age"),
              value: filterType.C_Age, 
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