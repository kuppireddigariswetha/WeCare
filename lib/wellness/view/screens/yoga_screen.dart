import 'dart:async';

import 'package:flutter/material.dart';
class YogaScreen extends StatefulWidget {
  const YogaScreen({super.key});

  @override
  State<YogaScreen> createState() => _YogaScreenState();
}

class _YogaScreenState extends State<YogaScreen> {
  Timer? _periodicTimer;
  int _tickCount = 0;
  int _stopCount = 60;

  void _startPeriodicTimer() {
    const oneSecond = Duration(seconds: 1);
    _periodicTimer = Timer.periodic(oneSecond, (Timer timer) {
      setState(() {
        if(_tickCount == _stopCount){
          _periodicTimer?.cancel();
        }else{
          _tickCount++;
        }
      });
    });
  }

  @override
  void dispose() {
    _periodicTimer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                color: Colors.white,
                elevation: 5,
                shadowColor: Colors.black87,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Breathe In & Breathe Out',style: TextStyle(color: Colors.deepPurple, fontFamily: 'Lato',fontSize: 16,fontWeight: FontWeight.w800),),
                ),
              ),
            ),
            Text(
              'Tick: $_tickCount',
              style: TextStyle(fontSize: 48),
            ),
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: _startPeriodicTimer,
          tooltip: 'Start Periodic Timer',
          child: Icon(Icons.timer),
        ),
    );
  }
}
