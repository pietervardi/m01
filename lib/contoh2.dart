import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Contoh2 extends StatefulWidget {
  const Contoh2({Key? key}) : super(key: key);

  @override
  State<Contoh2> createState() => _Contoh2State();
}

class _Contoh2State extends State<Contoh2> {
  late StreamSubscription _sub;
  bool isPlaying = false;

  int percent = 100;
  int getSteam = 0;
  double circular = 1;

  void play() {
    if (!isPlaying) {
      final Stream myStream =
          Stream.periodic(const Duration(seconds: 1), (int count) {
        return count;
      });

      _sub = myStream.listen((event) {
        getSteam = int.parse(event.toString());
        setState(() {
          if (percent - getSteam <= 0) {
            _sub.cancel();
            percent = 0;
            circular = 0;
          } else {
            percent = percent - getSteam;
            circular = percent / 100;
          }
        });
      });
      isPlaying = true;
    }
  }

  void stop() {
    if (isPlaying) {
      _sub.cancel();
      isPlaying = false;
    }
  }

  void reset() {
    stop();
    setState(() {
      percent = 100;
      circular = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Stream',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double avaWidth = constraints.maxWidth;
            final double avaHeight = constraints.maxHeight;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CircularPercentIndicator(
                    radius: avaHeight / 5,
                    lineWidth: 10,
                    percent: circular,
                    center: Text('$percent %'),
                  ),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: play,
            child: const Icon(Icons.play_arrow_outlined),
          ),
          const SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            onPressed: stop,
            child: const Icon(Icons.stop_outlined),
          ),
          const SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            onPressed: reset,
            child: const Icon(Icons.restore),
          )
        ],
      ),
    );
  }
}
