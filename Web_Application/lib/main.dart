// Important Packages DO NOT DELETE
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

// Main Function DO NOT DELETE
void main() {
  runApp(MyApp());
}

// Creates the App
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // Initializes the Firestore and Storage Features
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This builds the App
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthLit Web Portal',
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

// This Class gives the Filter names along with an Unique ID in order to be able to list them
class Filter {
  final int filterID;
  final String filterName;

  Filter(this.filterID,this.filterName);
  }

// Creates a Web Portal Class to contain the State of the Portal
class WebPortal extends StatefulWidget {
  const WebPortal({Key? key}) : super(key: key);

  @override
  _WebPortalState createState() => _WebPortalState();
}

// This class is the corresponding State Class to the Web Portal
class _WebPortalState extends State<WebPortal> {
  // Initialize Variables

  // Text Editing Controllers to read User Input
  final userFNController = TextEditingController();
  final userLNController = TextEditingController();
  final childFNController = TextEditingController();
  final childLNController = TextEditingController();
  final childAgeController = TextEditingController();
  final emailController = TextEditingController();
  
  // Access to the Firestore Collection
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");

  // Access to the Storage Directory
  final Reference modules = FirebaseStorage.instance.ref("modules");

  // Contains Output Information to display on screen
  String modOutput = "";
  String userOutput = "";

  // Contains all of the Filters. 
  // Keep all the IDs in Numerical Order and Incremental from 0. It corresponds to the index of filtersList Array
  List<Filter> filterList = [
    Filter(0, "User First Name"),
    Filter(1, "User Last Name"),
    Filter(2, "Child First Name"),
    Filter(3, "Child Last Name"),
    Filter(4, "Child Age"),
    Filter(5, "Email"),
  ];

  // Holds the selected filters
  List<Filter> selectedFilters = [];

  // Corresponds to the Text Boxes that pop up after the Filters are selected
  List<bool?> filtersList = [false, false, false, false, false, false];

  // Text Styles to Differentiate some of the text
  final TextStyle Title = TextStyle(fontSize: 32);
  final TextStyle Alert = TextStyle(color: Colors.red);
  
  // Functions

  // Function that adds a Modules
  Future<void> addModule() async {
    // Initialize Variables
    String dirName;
    Reference newModule;
    String newString = "";

    // Opens a File Picker and Waits for the user to select a PDF
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, 
      allowedExtensions: ['pdf']
    );


    if (result != null) {
      // Accesses the selected file
      result.files.forEach((file) {
        // Creates a new Directory and references it
        dirName = "modules/" + file.name;
        newModule = FirebaseStorage.instance.ref(dirName);

        // Converts the File into data and sends it to Storage
        newModule.putData(file.bytes as Uint8List);

        // Updates the Output to show that the user that the Upload worked
        newString = newString + file.name + " Uploaded!\n";
      });

      // Displays the Output on Screen
      setState(() {
        modOutput = newString;
      });
    }
    else{
      // Displays that the Upload Failed on Screen
      setState(() {
        modOutput = "Error. Please Try Again Later";
      });
    }
  }

  // Function that collects data from the Firestore Database
  Future<void> filterCollection() async {
    // Initialize Variables
    List<dynamic> allUsers = [];
    List<dynamic> allFilters = [];
    List<dynamic> tempList;
    List<dynamic> filteredUsers = [];
    bool filterTest;
    bool userMatchTest;

    // Collects all of the Users from the Database
    await userCollection.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
         allUsers = allUsers + [[doc["Userfirstname"], doc["Userlastname"], doc["childfname"], doc["childlname"], doc["childAge"], doc["email"], doc["uid"]]];
         
      });
    });

    // The next If Statements check if the Filter was selected and if the Filter was actually being used
    // If so then the all of the users who the Filter matches gets added as an array of users to the array of all the results of each selected Filter
    // Each If Statement is a different Filter
    if(filtersList[0] == true && userFNController.text != "")
    {
      tempList = [];
      await userCollection.where("Userfirstname", isEqualTo: userFNController.text).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
         tempList = tempList + [[doc["Userfirstname"], doc["Userlastname"], doc["childfname"], doc["childlname"], doc["childAge"], doc["email"], doc["uid"]]];
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
    
    // Goes through each User of the Database
    allUsers.forEach((user){
      filterTest = true;

      // Goes through each of the Selected Filters
      allFilters.forEach((filter){
        if(filterTest)
        {
          userMatchTest = true;

          // Goes through each Selected User of each of the Selected Filters
          filter.forEach((filterUser){

            // If the Current User of the Database is in the Selected Filter, the User stays
            if(userMatchTest && user[6] == filterUser[6])
            {
              userMatchTest = false;
            }
          });

          // If the Current User of the Database is not in the Selected Filter, the User doesn't get added to the final list
          if(userMatchTest)
          {
            filterTest = false;
          }
        }
      });

      // If the Current User of the Database is in all of the Selected Filters, the User gets added to the final list
      if(filterTest)
      {
        filteredUsers = filteredUsers + [user];
      }
    });

    // Displays the Users that match all of the Selected Filters
    setState(() {
      String newString = "";
      filteredUsers.forEach((user){
        newString = newString + user[0] + " " + user[1] + " " + user[2] + " " + user[3] + " " + user[4] + " " + user[5] + "\n";
      });
      userOutput = newString;
    });
  }

  // Function that diplays the corresponfing Text Boxes to the Selected Filter
  List<Widget> getContainers (){

    // Initialize Variables
    List<Widget> FilterBoxes = [];

    // The next If Statements check if each of the Text Boxes was selected
    // If they were, they get added to the list
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

    // Returns the List of Text Boxes
    return FilterBoxes;
  }
  
  // Function that displays the Filters as a Multi-Select List and Updates the the Selected Filters
  void showFilterOptions(BuildContext context) async {

    // Creates the Filter List as a Multi-Select List
    final _items = filterList
        .map((filter) => MultiSelectItem<Filter>(filter, filter.filterName))
        .toList();

    // Shows the Multi-Select List    
    await showDialog(
      context: context,
      builder: (ctx) {
        return  MultiSelectDialog(
          items: _items,
          initialValue: selectedFilters,
          onConfirm: (values) {

            // Updates the the Selected List
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
  // Updates the Web Portal
  Widget build(BuildContext context) {
    // Displays the Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text("HealthLit Web Portal"),
        backgroundColor: Colors.green
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[

            // Upload Module Section
            Column(
              children: <Widget>[
                SizedBox(
                  height: 25),

                // Title
                Text("Upload Module", style: Title), 
                SizedBox(
                  height: 25),
                Text(".pdf files only"),

                // Button to Upload Files
                OutlinedButton(
                  onPressed: () {
                    addModule();
                  },
                child: Text("Pick Files"),
                ),

                // Displays the Output for File Uploading
                Text(modOutput, style: Alert),
              ],
            ),

            // User Information Section
            Column(
              children: <Widget>[
                SizedBox(
                  height: 25),

                // Title
                Text("User Data", style: Title),
                SizedBox(
                  height: 25),

                // Button that Displays the Filters and Allows them to be Selected
                OutlinedButton(
                  onPressed: () {
                    showFilterOptions(context);
                  }, 
                  child: Text("Pick Filters")),
                SizedBox(
                  height: 25),

                // Displays the Selected Text Boxes  
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: getContainers(),
                ),

                // Button that Searches and Filters the Database
                OutlinedButton(
                  onPressed: () {
                    filterCollection();
                  },
                  child: Text("Search"),
                ),

                // Displays the Selected Users
                Text(userOutput)
              ],
            )   
          ]
        ),
      )
    );
  }
}