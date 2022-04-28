import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:gtk_flutter/game/modOneGameWidget.dart';
import 'package:gtk_flutter/game/modTwoGameWidget.dart';


class loadPdfMod1 extends StatefulWidget{
  @override
  _loadPdfStateMod1 createState() => _loadPdfStateMod1();
}

class _loadPdfStateMod1 extends State<loadPdfMod1> {
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

  Future<void> downloadURLExampleMod2() async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('modules/Module1.pdf')
        .getDownloadURL();
    print(downloadURL);
    PDFDocument doc = await PDFDocument.fromURL(downloadURL);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPDFMod1(doc)));  //Notice the Push Route once this is done.
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listExample();
    downloadURLExampleMod2();
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

class ViewPDFMod1 extends StatelessWidget{
  PDFDocument document;
  ViewPDFMod1(this.document);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Module 1')),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Game'),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => modOneGameWidget())),
        ),
        floatingActionButtonLocation:FloatingActionButtonLocation.miniEndFloat ,
        body: PDFViewer(document: document)
    );

  }

}