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
  String _mark = '';
  int _count = 0;
  List<String> _listOfTimestamps = [''];

  final _key = GlobalKey<AnimatedListState>();

  @override
  initState() {
    super.initState();
    _reset(); //вот тут стоял нолик
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

  void _reset() {
    setState(() => duration = Duration());
    _mark = '';
    while (_listOfTimestamps.length > 0) {
      _listOfTimestamps.removeLast();
      _key.currentState?.removeItem(0,
          (BuildContext context, Animation<double> animation) {
        return Container();
      });
    }
    ;
    _listOfTimestamps = [''];
    _count = 0;
  }

  void _markTime() {
    setState(() {
      String saveTime(int n) => n.toString().padLeft(2, '0');
      String saveTimeMilli(int n) => n.toString().padLeft(3, '0');
      final _min = saveTime(duration.inMinutes.remainder(60));
      final _sec = saveTime(duration.inSeconds.remainder(60));
      final _milSec = saveTimeMilli(duration.inMilliseconds.remainder(1000));
      _mark = _min + ':' + _sec + '.' + _milSec.substring(1, 3);
      _count++;
      final text_count = saveTime(_count);

      _listOfTimestamps.insert(0, '$text_count.   $_mark');
      _key.currentState!.insertItem(
        0,
        duration: const Duration(milliseconds: 250),
      );
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 80),
            buildTime(),
            SizedBox(height: 40),
            Expanded(
              flex: 2,
              child: Scrollbar(
                child: build_markTime(),
              ),
            ),
            Expanded(child: buildButtons()),
            SizedBox(height: 50),
          ],
        ),
      );

  Widget build_markTime() {
    return AnimatedList(
        key: _key,
        scrollDirection: Axis.vertical,

        //shrinkWrap: true,
        initialItemCount: _listOfTimestamps.length,
        itemBuilder: (BuildContext context, index, animation) {
          return SizeTransition(
            sizeFactor: animation,

            // position: Tween<Offset>(
            //   begin: const Offset(0, -1),
            //   end: Offset.zero,
            // ).animate(animation),
            key: UniqueKey(),
            child: Align(
              alignment: Alignment.center,
              child: Text(_listOfTimestamps[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: Colors.green)),
            ),
          );
        });
  }

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
                    _markTime();
                  } else {
                    _reset();
                  }
                },
                child: Text(isRunning ? ' mark ' : ' Reset ',
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
              borderRadius: BorderRadius.circular(5),
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
