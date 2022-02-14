import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async' show Future;
import 'main.dart';


class ListDetailDemo extends StatefulWidget {
  ListDetailDemo({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ListDetailDemoState createState() => _ListDetailDemoState();
}

class _ListDetailDemoState extends State<ListDetailDemo> {
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
          // Here we take the value from the ListDetailDemo object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: ListPage());
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var user;
  var userId;
  var fireStoreInstance;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    userId = user.uid;
    //Instantiate firestore instance.
    fireStoreInstance = FirebaseFirestore.instance;
    getUserPosts();
  }

  //Mark the getPosts function as async to use await with Futures.
  Future getPosts() async {
    //Get a query snapshot of the current posts collection, wait for it though via await.
    QuerySnapshot qn = await firestoreInstance.collection("posts").get();

    //Return the query snapshot array of documents.
    return qn.docs;
  }

  Future getUserPosts() async {
    //Get a query snapshot of the current posts of the authenticated user.
    QuerySnapshot qnUser = await fireStoreInstance.collection("posts").get();

    //Return the current user's posts
    return qnUser.docs;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(post: post,),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //Use a FutureBuilder widget when waiting to build elements from FireStore.
        child: FutureBuilder(
            //This future object is the data we want to build from via FireStore, recieved in getPosts() above.
            future: getUserPosts(),
            builder: (context, snapshot) {
              //Check if the data is ready yet or still waiting
              if (snapshot.connectionState == ConnectionState.waiting) {
                //Do nothing yet
                return Center(
                  //Return a centered loading text message
                  child: Text("Loading..."),
                );
              }
              //Otherwise we have it or failed.
              else {
                return ListView.builder(
                    //Amount of documents in the documents snapshot we grabbed
                    //This will build up the ListTiles for all the posts stored.
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        //This changed a little bit from the tutorial, data() now returns the map and we grab the "titles".
                        title: Text(snapshot.data[index]),
                        onTap: () => navigateToDetail(snapshot.data[index].data['title']),
                      );
                    });
              }
            }));
  }
}

class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  //This constructor assigns the passed in post automatically to the class member.
  DetailPage({this.post});
  @override
  _DetailPageState createState() => _DetailPageState();
}
class _DetailPageState extends State<DetailPage> {
  String userId;

  @override
  void initState() {
    userId = widget.post.data() as String;
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.post.data() as String),
        ),
        body: Container(
            child: Card(
              //Build a ListTile to display info from the local class member post instance passed to us via the ListPage
              child: ListTile(
                title: Text(widget.post.data() as String),
                subtitle: Text(widget.post.data() as String),
              ),
            )));
  }
}
