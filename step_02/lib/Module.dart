  // new
import 'package:flutter/material.dart';
import 'package:gtk_flutter/main.dart';

class ModulePage extends StatefulWidget
{

  ModulePage({Key key, this.isOpen}) : super(key: key);


  final bool isOpen;
  @override
  _ModulePageState createState() => _ModulePageState();
}
class _ModulePageState extends State<ModulePage>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modules'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Please select a following Module.",
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
            ),
            ),
            ),
            ListTile(
              leading: Icon(Icons.event_note),
              title: Text('Module 1: Food Health Literacy')
            ),
            Row (
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const SizedBox(width: 3),
                  TextButton(
                    child: const Text('Open'),
                    onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => ModulePage(isOpen: true)),
                        );
                      },
                  ),
                  const SizedBox(width: 8),
                ],
            ),
            ElevatedButton(
              child: Text("Home"),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AuthenticationWrapper()),

                );
              }),
          ],
        ),
      ),
    );
  }
}