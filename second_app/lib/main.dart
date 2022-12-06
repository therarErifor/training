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
    _reset();
  }
  void _reset(){
      setState(() => duration = Duration());

  }


  void addTime() {
    final addMilliseconds = 10;
    setState(() {
      final milliseconds = duration.inMilliseconds + addMilliseconds;
      duration = Duration(milliseconds: milliseconds);
    });
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 10), (_) => addTime());

  }
  void _stopTimer(){
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
            buildButtons(),
          ],
        ),
      );

Widget buildButtons() {
  final isRunning = timer == null ? false : timer!.isActive;
  final isCompleted = duration.inMilliseconds == 0;
 return isRunning || !isCompleted
  ?Row(
    mainAxisAlignment: MainAxisAlignment.center,

    children:[
      ElevatedButton(

        onPressed: () {
          if (isRunning) {
            _stopTimer();
          }else {
            _startTimer();
          }
          },
        child: Text(isRunning ? '   Stop   ' : 'Resume'),
      ),
      SizedBox(width: 15, height: 100,),
      ElevatedButton(
        onPressed: () {_reset();},
        child: Text('Reset'),
      ),
    ],
 )
 : Row(mainAxisAlignment: MainAxisAlignment.center,
     children:[
       SizedBox(width: 15, height: 100,),
 ElevatedButton(
        onPressed: () {_startTimer();},
        child: Text('Start'),
      ),
 ],
 );
}

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String Digits(int n) => n.toString().padLeft(3, '0');
    // final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final milliSeconds = Digits(duration.inMilliseconds.remainder(1000));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        // buildTimeCard(time: hours, header: 'hours'),
        // const SizedBox(width: 8),
        buildTimeCard(time: minutes),
        Text(':',
        style: TextStyle(fontSize: 72, color: Colors.lightGreen)),
        buildTimeCard(time: seconds),
        Text('.',
            style: TextStyle(fontSize: 72, color: Colors.lightGreen)),
        buildTimeCard(time: milliSeconds.substring(0, 2)),
      ],
    );

  }

  Widget buildTimeCard({required String time,
    }) =>
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
  ],
      );
}

