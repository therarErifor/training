import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  final formKey = GlobalKey<FormState>();
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
          key: formKey,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter some text',
              style: Theme.of(context).textTheme.headline6,
            ),

            Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child:TextFormField(
                  textAlign: TextAlign.center,
                  controller: _controller
                ),
            ),

            ElevatedButton(
                onPressed: _saveText,
                child: Text('Save the text'),
            ),
            SizedBox(height: 15,),
            Text(
            '$_text',
            ),
          ],
        ),
      ),
    );
  }
}
