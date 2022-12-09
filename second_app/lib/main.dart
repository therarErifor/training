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
      debugShowCheckedModeBanner: false,
      title: 'StopWatch',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'StopWatch'),
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
  String mark = '';
  int count = 0;

  @override
  initState() {
    super.initState();
    // startTimer();
    _reset();
  }

  void _reset() {
    setState(() => duration = Duration());
    mark = '';
    fields = [''];
    count = 0;
  }

  void _addTime() {
    final addMilliseconds = 10;
    setState(() {
      final milliseconds = duration.inMilliseconds + addMilliseconds;
      duration = Duration(milliseconds: milliseconds);
    });
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 10), (_) => _addTime());
  }

  void _stopTimer() {
    setState(() => timer?.cancel());
  }

  void markTime() {
    setState(() {
      String saveTime(int n) => n.toString();
      final _min = saveTime(duration.inMinutes.remainder(60));
      final _sec = saveTime(duration.inSeconds.remainder(60));
      final _milSec = saveTime(duration.inMilliseconds.remainder(1000));
      mark = _min + ':' + _sec + '.' + _milSec.substring(1, 3);
      count++;
      final textCount = saveTime(count);
      fields.add('$textCount.   $mark');
    });
  }

  List<String> fields = [''];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80),
            buildTime(),
            SizedBox(height: 40),
            Container(
              height: 300,
              child: Scrollbar(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: fields.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(fields[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                              color: Colors.green));
                    }),
              ),
            ),
            Expanded(child: buildButtons()),
            SizedBox(height: 50),
          ],
        ),
      );

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inMilliseconds == 0;
    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (isRunning) {
                    _stopTimer();
                  } else {
                    _startTimer();
                  }
                },
                child: Text(isRunning ? '   Stop   ' : 'Resume',
                    style: TextStyle(
                      fontSize: 25,
                    )),
              ),
              SizedBox(
                width: 15,
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  if (isRunning) {
                    markTime();
                  } else {
                    _reset();
                  }
                },
                child: Text(isRunning ? ' Mark ' : ' Reset ',
                    style: TextStyle(
                      fontSize: 25,
                    )),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 15,
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  _startTimer();
                },
                child: Text('Start',
                    style: TextStyle(
                      fontSize: 28,
                    )),
              ),
            ],
          );
  }

  Widget buildTime() {
    String _twoDigits(int n) => n.toString().padLeft(2, '0');
    String _milliDigits(int n) => n.toString().padLeft(3, '0');
    // final hours = twoDigits(duration.inHours);
    final minutes = _twoDigits(duration.inMinutes.remainder(60));
    final seconds = _twoDigits(duration.inSeconds.remainder(60));
    final milliSeconds = _milliDigits(duration.inMilliseconds.remainder(1000));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // buildTimeCard(time: hours, header: 'hours'),
        // const SizedBox(width: 8),
        buildTimeCard(time: minutes),
        Text(':', style: TextStyle(fontSize: 72, color: Colors.green)),
        buildTimeCard(time: seconds),
        Text('.', style: TextStyle(fontSize: 72, color: Colors.green)),
        buildTimeCard(time: milliSeconds.substring(0, 2)),
      ],
    );
  }

  Widget buildTimeCard({
    required String time,
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
            child: Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 60,
              ),
            ),
          ),
        ],
      );
}
