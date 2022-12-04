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
  void initState(){
    super.initState();
    startTimer();
  }
  void addTime(){
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }
  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }


  @override
  Widget build(BuildContext context)  => Scaffold(
    body: Center(child: buildTime(),),
  );
  //{
  // return Scaffold(
  //   appBar: AppBar(
  //     title: Text(widget.title),
  //   ),
  //   body: Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         const Text(
  //           'Tup the button to start timer',
  //           style: (TextStyle(fontSize: 18)),
  //         ),
  //         SizedBox(height: 15),
  //         Text(
  //           '$_seconds',
  //         style: (TextStyle(fontSize: 50)),
  //         )
  //       ],
  //     ),
  //   ),
  //
  //   bottomNavigationBar: BottomAppBar(
  //     shape: const CircularNotchedRectangle(),
  //     child: Container(height: 50.0),
  //   ),
  //   floatingActionButton: FloatingActionButton(
  //
  //     onPressed: _timerStart,
  //
  //     child: const Icon(Icons.access_time_outlined),
  //
  //   ),
  //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  //   // This trailing comma makes auto-formatting nicer for build methods.
  // );
  Widget buildTime(){
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: 'hours'),
        const SizedBox(width: 8),
        buildTimeCard(time: minutes, header: 'minutes'),
        const SizedBox(width: 8),
        buildTimeCard(time: seconds, header: 'seconds'),
      ],
    );
  }
}
//}

Widget buildTimeCard({required String time,
  required String header}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(time,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.limeAccent,
              fontSize: 72,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(header),
      ],
    );
