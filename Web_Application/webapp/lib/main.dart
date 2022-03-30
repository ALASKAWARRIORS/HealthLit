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
    List<dynamic> allUsers = [];
    List<dynamic> allFilters = [];
    List<dynamic> tempList;
    bool firstFlag = true;
    await userCollection.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
         allUsers = allUsers + [[doc["Userfirstname"], doc["Userlastname"], doc["childfname"], doc["childlname"], doc["childAge"], doc["email"], doc["uid"]]];
         
      });
    });
    if(filtersList[0] == true)
    {
      tempList = [];
      await userCollection.where("Userfirstname", isEqualTo: userFNController.text).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
         tempList = tempList+ [[doc["Userfirstname"], doc["Userlastname"], doc["childfname"], doc["childlname"], doc["childAge"], doc["email"], doc["uid"]]];
        });
      });
      allFilters = allFilters + [tempList];
    }
    if(filtersList[1] == true)
    {
      tempList = [];
      await userCollection.where("Userlastname", isEqualTo: userLNController.text).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
         tempList = tempList + [[doc["Userfirstname"], doc["Userlastname"], doc["childfname"], doc["childlname"], doc["childAge"], doc["email"], doc["uid"]]];
        });
      });
      allFilters = allFilters + [tempList];
    }
    if(filtersList[2] == true)
    {
      tempList = [];
      await userCollection.where("childfname", isEqualTo: childFNController.text).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
         tempList = tempList + [[doc["Userfirstname"], doc["Userlastname"], doc["childfname"], doc["childlname"], doc["childAge"], doc["email"], doc["uid"]]];
        });
      });
      allFilters = allFilters + [tempList];
    }
    if(filtersList[3] == true)
    {
      tempList = [];
      await userCollection.where("childlname", isEqualTo: childLNController.text).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
         tempList = tempList + [[doc["Userfirstname"], doc["Userlastname"], doc["childfname"], doc["childlname"], doc["childAge"], doc["email"], doc["uid"]]];
        });
      });
      allFilters = allFilters + [tempList];
    }
    if(filtersList[4] == true)
    {
      tempList = [];
      await userCollection.where("childAge", isEqualTo: childAgeController.text).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
         tempList = tempList + [[doc["Userfirstname"], doc["Userlastname"], doc["childfname"], doc["childlname"], doc["childAge"], doc["email"], doc["uid"]]];
        });
      });
      allFilters = allFilters + [tempList];
    }
    if(filtersList[5] == true)
    {
      tempList = [];
      await userCollection.where("email", isEqualTo: emailController.text).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
         tempList = tempList + [[doc["Userfirstname"], doc["Userlastname"], doc["childfname"], doc["childlname"], doc["childAge"], doc["email"], doc["uid"]]];
        });
      });
      allFilters = allFilters + [tempList];
    }
    if(filtersList[6] == true)
    {
      tempList = [];
      await userCollection.where("uid", isEqualTo: userIDController.text).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
         tempList = tempList + [[doc["Userfirstname"], doc["Userlastname"], doc["childfname"], doc["childlname"], doc["childAge"], doc["email"], doc["uid"]]];
        });
      });
      allFilters = allFilters + [tempList];
    }
    List<dynamic> filteredUsers = [];
    bool filterTest;
    bool userMatchTest;
    allUsers.forEach((user){
      filterTest = true;
      allFilters.forEach((filter){
        if(filterTest)
        {
          userMatchTest = true;
          filter.forEach((filterUser){
            if(userMatchTest && user[6] == filterUser[6])
            {
              userMatchTest = false;
            }
          });
          if(userMatchTest)
          {
            filterTest = false;
          }
        }
      });
      if(filterTest)
      {
        filteredUsers = filteredUsers + [user];
      }
    });
    setState(() {
      String newString = "";
      filteredUsers.forEach((user){
        newString = newString + user[0] + " " + user[1] + " " + user[2] + " " + user[3] + " " + user[4] + " " + user[5] + " " + user[6] + "\n";
      });
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
