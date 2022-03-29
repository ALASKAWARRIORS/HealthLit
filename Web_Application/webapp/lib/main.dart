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
  final moduleController = TextEditingController();
  final userController = TextEditingController();
  final userFNController = TextEditingController();
  final userLNController = TextEditingController();
  final childFNController = TextEditingController();
  final childLNController = TextEditingController();
  final childAgeController = TextEditingController();
  final emailController = TextEditingController();
  final userIDController = TextEditingController();
  final CollectionReference moduleCollection = FirebaseFirestore.instance.collection("modules ");
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  String input = "";
  List<bool?> filtersList = [false, false, false, false, false, false, false];
  
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
  Future<void> filterCollection() async {
    Query currentQuery = userCollection.orderBy("Userfirstname");
    String newString = "";

    if(filtersList[0] == true)
    {
      currentQuery = currentQuery.where("Userfirstname", isEqualTo: userFNController.text);
    }
    if(filtersList[1] == true)
    {
      currentQuery = currentQuery.where("Userlastname", isEqualTo: userLNController.text);
    }
    if(filtersList[2] == true)
    {
      currentQuery = currentQuery.where("childfname", isEqualTo: childFNController.text);
    }
    if(filtersList[3] == true)
    {
      currentQuery = currentQuery.where("childlname", isEqualTo: childLNController.text);
    }
    if(filtersList[4] == true)
    {
      currentQuery = currentQuery.where("childAge", isEqualTo: childAgeController.text);
    }
    if(filtersList[5] == true)
    {
      currentQuery = currentQuery.where("email", isEqualTo: emailController.text);
    }
    if(filtersList[6] == true)
    {
      currentQuery = currentQuery.where("uid", isEqualTo: userIDController.text);
    }
    await currentQuery.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        newString = newString + doc["Userfirstname"] + " " + doc["Userlastname"] + " " + doc["childfname"] + " " + doc["childlname"] + "  " + doc["childAge"] + " " + doc["email"] + " " + doc["uid"] + "\n";
      });
    });
    setState(() {
      input = newString;
    });
  }

  List<Widget> getContainers (){
    List<Widget> FilterBoxes = [];
    if(filtersList[0] == true)
    {
      FilterBoxes.add(
        Container(
          width: 200,
          height: 50,
          color: Colors.grey,
          child: Center(
            child: TextField(
              controller: userFNController,
              decoration: InputDecoration(
                hintText: 'User First Name'
              )
            )
          )
        )
      );
    }
    if(filtersList[1] == true)
    {
      FilterBoxes.add(
        Container(
          width: 200,
          height: 50,
          color: Colors.grey,
          child: Center(
            child: TextField(
              controller: userLNController,
              decoration: InputDecoration(
                hintText: 'User Last Name'
              )
            )
          )
        )
      );
    }
    if(filtersList[2] == true)
    {
      FilterBoxes.add(
        Container(
          width: 200,
          height: 50,
          color: Colors.grey,
          child: Center(
            child: TextField(
              controller: childFNController,
              decoration: InputDecoration(
                hintText: 'Child First Name'
              )
            )
          )
        )
      );
    }
    if(filtersList[3] == true)
    {
      FilterBoxes.add(
        Container(
          width: 200,
          height: 50,
          color: Colors.grey,
          child: Center(
            child: TextField(
              controller: childLNController,
              decoration: InputDecoration(
                hintText: 'Child Last Name'
              )
            )
          )
        )
      );
    }
    if(filtersList[4] == true)
    {
      FilterBoxes.add(
        Container(
          width: 200,
          height: 50,
          color: Colors.grey,
          child: Center(
            child: TextField(
              controller: childAgeController,
              decoration: InputDecoration(
                hintText: 'Child Age'
              )
            )
          )
        )
      );
    }
    if(filtersList[5] == true)
    {
      FilterBoxes.add(
        Container(
          width: 200,
          height: 50,
          color: Colors.grey,
          child: Center(
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email'
              )
            )
          )
        )
      );
    }
    if(filtersList[6] == true)
    {
      FilterBoxes.add(
        Container(
          width: 200,
          height: 50,
          color: Colors.grey,
          child: Center(
            child: TextField(
              controller: userIDController,
              decoration: InputDecoration(
                hintText: 'User ID'
              )
            )
          )
        )
      );
    }
    return FilterBoxes;
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
            CheckboxListTile(
              title: const Text("User First Name"),
              value: filtersList[0], 
              onChanged: (bool? value){
                setState(() {
                  filtersList[0] = value;
                });
              }),
              CheckboxListTile(
              title: const Text("User Last Name"),
              value: filtersList[1], 
              onChanged: (bool? value){
                setState(() {
                  filtersList[1] = value;
                });
              }),
              CheckboxListTile(
              title: const Text("Child First Name"),
              value: filtersList[2], 
              onChanged: (bool? value){
                setState(() {
                  filtersList[2] = value;
                });
              }),
              CheckboxListTile(
              title: const Text("Child Last Name"),
              value: filtersList[3], 
              onChanged: (bool? value){
                setState(() {
                  filtersList[3] = value;
                });
              }),
              CheckboxListTile(
              title: const Text("Child Age"),
              value: filtersList[4], 
              onChanged: (bool? value){
                setState(() {
                  filtersList[4] = value;
                });
              }),
              CheckboxListTile(
              title: const Text("Email Address"),
              value: filtersList[5], 
              onChanged: (bool? value){
                setState(() {
                  filtersList[5] = value;
                });
              }),
              CheckboxListTile(
              title: const Text("User ID"),
              value: filtersList[6], 
              onChanged: (bool? value){
                setState(() {
                  filtersList[6] = value;
                });
              }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: getContainers(),
            ),
            OutlinedButton(
              onPressed: () {
                filterCollection();
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
