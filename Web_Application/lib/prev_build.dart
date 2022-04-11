import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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
              title: "HealthLit Web Portal",
              home: WebPortal(),
            );
          }
          return CircularProgressIndicator();
        }
      ),
    );
  }
}

class Filter {
  final int filterID;
  final String filterName;

  Filter(this.filterID,this.filterName);
  }

// Define a custom Form widget.
class WebPortal extends StatefulWidget {
  const WebPortal({Key? key}) : super(key: key);

  @override
  _WebPortalState createState() => _WebPortalState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _WebPortalState extends State<WebPortal> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final userFNController = TextEditingController();
  final userLNController = TextEditingController();
  final childFNController = TextEditingController();
  final childLNController = TextEditingController();
  final childAgeController = TextEditingController();
  final emailController = TextEditingController();
  final CollectionReference moduleCollection = FirebaseFirestore.instance.collection("modules ");
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final Reference modules = FirebaseStorage.instance.ref("Module Document");
  String modOutput = "";
  String userStrOutput = "";
  List<dynamic> userOutput = [];
  List<Filter> filterList = [
    Filter(0, "User First Name"),
    Filter(1, "User Last Name"),
    Filter(2, "Child First Name"),
    Filter(3, "Child Last Name"),
    Filter(4, "Child Age"),
    Filter(5, "Email"),
  ];
  List<Filter> selectedFilters = [];
  List<bool?> filtersList = [false, false, false, false, false, false];
  final TextStyle Title = TextStyle(fontSize: 32);
  
  Future<void> addModule() async {
    int counter = 1;
    String dirName;
    Reference newModule;
    Uint8List fileData;
    String newString = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true, 
      type: FileType.custom, 
      allowedExtensions: ['jpg','txt']
    );
    if (result != null) {
      ListResult moduleList = await modules.listAll();
      moduleList.prefixes.forEach((module) { 
        counter++;
      });

      newString = newString + "Module " + counter.toString() + "\n";

      result.files.forEach((file) {
        dirName = "Module Document/module" + counter.toString() + "/" + file.name;
        newModule = FirebaseStorage.instance.ref(dirName);
        fileData = file.bytes as Uint8List;
        newModule.putData(fileData);
        newString = newString + file.name + " Uploaded!\n";
      });
      setState(() {
        modOutput = newString;
      });
    }
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
    if(filtersList[0] == true && userFNController.text != "")
    {
      tempList = [];
      await userCollection.where("Userfirstname", isEqualTo: userFNController.text).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
         tempList = tempList+ [[doc["Userfirstname"], doc["Userlastname"], doc["childfname"], doc["childlname"], doc["childAge"], doc["email"], doc["uid"]]];
        });
      });
      allFilters = allFilters + [tempList];
    }
    if(filtersList[1] == true && userLNController.text != "")
    {
      tempList = [];
      await userCollection.where("Userlastname", isEqualTo: userLNController.text).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
         tempList = tempList + [[doc["Userfirstname"], doc["Userlastname"], doc["childfname"], doc["childlname"], doc["childAge"], doc["email"], doc["uid"]]];
        });
      });
      allFilters = allFilters + [tempList];
    }
    if(filtersList[2] == true && childFNController.text != "")
    {
      tempList = [];
      await userCollection.where("childfname", isEqualTo: childFNController.text).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
         tempList = tempList + [[doc["Userfirstname"], doc["Userlastname"], doc["childfname"], doc["childlname"], doc["childAge"], doc["email"], doc["uid"]]];
        });
      });
      allFilters = allFilters + [tempList];
    }
    if(filtersList[3] == true && childLNController.text != "")
    {
      tempList = [];
      await userCollection.where("childlname", isEqualTo: childLNController.text).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
         tempList = tempList + [[doc["Userfirstname"], doc["Userlastname"], doc["childfname"], doc["childlname"], doc["childAge"], doc["email"], doc["uid"]]];
        });
      });
      allFilters = allFilters + [tempList];
    }
    if(filtersList[4] == true && childAgeController.text != "")
    {
      tempList = [];
      await userCollection.where("childAge", isEqualTo: childAgeController.text).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
         tempList = tempList + [[doc["Userfirstname"], doc["Userlastname"], doc["childfname"], doc["childlname"], doc["childAge"], doc["email"], doc["uid"]]];
        });
      });
      allFilters = allFilters + [tempList];
    }
    if(filtersList[5] == true && emailController.text != "")
    {
      tempList = [];
      await userCollection.where("email", isEqualTo: emailController.text).get().then((QuerySnapshot querySnapshot) {
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
      List<dynamic> newOutput = [];
      filteredUsers.forEach((user){
        newString = newString + user[0] + " " + user[1] + " " + user[2] + " " + user[3] + " " + user[4] + " " + user[5] + "\n";
        newOutput = newOutput + [user.sublist(5)];
      });
      userStrOutput = newString;
      userOutput = newOutput;
      print(userOutput);
    });
  }

  List<Widget> getContainers (){
    List<Widget> FilterBoxes = [];
    if(filtersList[0] == true)
    {
      FilterBoxes.add(
        Container(
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
          ),
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
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
          ),
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
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
          ),
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
         margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
          ),
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
         margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
          ),
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
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
          ),
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
    return FilterBoxes;
  }
  
  void showMultiSelect(BuildContext context) async {
    final _items = filterList
        .map((filter) => MultiSelectItem<Filter>(filter, filter.filterName))
        .toList();
    await showDialog(
      context: context,
      builder: (ctx) {
        return  MultiSelectDialog(
          items: _items,
          initialValue: selectedFilters,
          onConfirm: (values) {
            selectedFilters = values as List<Filter>;
            filtersList = [false, false, false, false, false, false];
            setState(() {
              selectedFilters.forEach((filter) { 
                filtersList[filter.filterID] = true;
              });
            });
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HealthLit Web Portal"),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 25),
                Text("Upload Module", style: Title), 
                SizedBox(
                  height: 25),
                Text(".jpg and .txt files only"),
                OutlinedButton(
                  onPressed: () {
                    addModule();
                  },
                child: Text("Pick Files"),
                ),
                Text(modOutput),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 25),
                Text("User Data", style: Title),
                SizedBox(
                  height: 25),
                OutlinedButton(
                  onPressed: () {
                    showMultiSelect(context);
                  }, 
                  child: Text("Pick Filters")),
                SizedBox(
                  height: 25),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: getContainers(),
                ),
                OutlinedButton(
                  onPressed: () {
                    filterCollection();
                  },
                  child: Text("Search"),
                ),
                Text(userStrOutput)
              ],
            )   
          ]
        ),
      )
    );
  }
}