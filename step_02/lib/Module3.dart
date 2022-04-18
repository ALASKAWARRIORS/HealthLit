import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:gtk_flutter/game/modTwoGameWidget.dart';

import 'game/modThreeGameWidget.dart';


class loadPdfMod3 extends StatefulWidget{
  @override
  _loadPdfStateMod3 createState() => _loadPdfStateMod3();
}

class _loadPdfStateMod3 extends State<loadPdfMod3> {
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future<void> listExample() async {
    firebase_storage.ListResult result =
    await firebase_storage.FirebaseStorage.instance.ref().child('modules').listAll();

    result.items.forEach((firebase_storage.Reference ref) {
      print('Found file: $ref');
    });

    result.prefixes.forEach((firebase_storage.Reference ref) {
      print('Found directory: $ref');
    });
  }

  Future<void> downloadURLExampleMod3() async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('modules/Module3.pdf')
        .getDownloadURL();
    print(downloadURL);
    PDFDocument doc = await PDFDocument.fromURL(downloadURL);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPDFMod3(doc)));  //Notice the Push Route once this is done.
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listExample();
    downloadURLExampleMod3();
    print("All done!");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
      ),
    );
  }
}

class ViewPDFMod3 extends StatelessWidget{
  PDFDocument document;
  ViewPDFMod3(this.document);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Module 3')),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Game'),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => modThreeGameWidget())),
        ),
        floatingActionButtonLocation:FloatingActionButtonLocation.miniEndFloat ,
        body: PDFViewer(document: document)
    );

  }

}