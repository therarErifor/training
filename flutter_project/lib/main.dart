import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Task #1',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Flutter. Task #1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text = '';
  final _controller = TextEditingController();

  _saveText(){
    setState(() =>_text = _controller.text);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),

      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child:TextFormField(decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.black12,
                  filled: true,
                  hintText: "Enter some text",
                ),
                    textAlign: TextAlign.center,
                    controller: _controller
                ),
            ),

            ElevatedButton(
                onPressed: _saveText,
                child: Text('Save the text'),
            ),
            SizedBox(height: 15,),
            Container(
              color: Colors.black12,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(vertical: 15.0),
              margin: EdgeInsets.symmetric(horizontal: 50.0),
              child:

                Text(
                  '$_text',
                  style: (TextStyle(fontSize: 16)),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
