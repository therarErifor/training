import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Timer',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Timer'),
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
  Duration duration = Duration();
  Timer? timer;


  @override
 initState() {
    super.initState();
     // startTimer();
    reset();
  }
  void reset(){
      setState(() => duration = Duration());

  }


  void addTime() {
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());

  }
  void stopTimer(){
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          appBar:AppBar(
            title: Text(widget.title),
          ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            buildTime(),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    ElevatedButton(
                      // style: ButtonStyle(
                      //   foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      // ),
                      onPressed: () {startTimer();},
                      child: Text('Start'),
                    ),
                      SizedBox(width: 24, height: 100,),
                    ElevatedButton(
                      // style: ButtonStyle(
                      //   foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      // ),
                      onPressed: () {stopTimer();},
                      child: Text('Stop'),
                    ),
                      SizedBox(width: 24, height: 100,),
                    ElevatedButton(
                      // style: ButtonStyle(
                      //   foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      // ),
                      onPressed: () {reset();},
                      child: Text('Reset'),
                    ),
            ],

            ),
          ],
        ),
      );



        // floatingActionButton: FloatingActionButton(
        //   onPressed: (){startTimer();},
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.timer),
        // ),

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    // final hours = twoDigits(duration.inHours);
    // final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // buildTimeCard(time: hours, header: 'hours'),
        // const SizedBox(width: 8),
        // buildTimeCard(time: minutes, header: 'minutes'),
        // const SizedBox(width: 8),
        buildTimeCard(time: seconds, header: 'seconds'),
      ],
    );

  }

  Widget buildTimeCard({required String time,
    required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 72,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(header),
        ],
      );
}

