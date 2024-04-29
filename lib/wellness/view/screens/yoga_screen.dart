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
  bool setTimer = false;

  void _startPeriodicTimer() {
    print('Printing 12');
    const oneSecond = Duration(seconds: 1);
    _periodicTimer = Timer.periodic(oneSecond, (Timer timer) {
      setState(() {
        setTimer = true;
        if(_tickCount == _stopCount){
          print('Printing 12');
          _periodicTimer?.cancel();
          setTimer = false;
        }else{
          print('Printing 12');
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
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios_outlined)),
        title: Text('YOGA',style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Lato',fontSize: 20,color: Colors.deepPurple),),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  shadowColor: Colors.black87,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Start Breathe In & Breathe Out Exercise',style: TextStyle(color: Colors.deepPurple, fontFamily: 'Lato',fontSize: 16,fontWeight: FontWeight.w800),),
                  ),
                ),
              ),
            ),
            Text(
              'Timer(60 seconds) : $_tickCount',
              style: TextStyle(fontSize: 20,fontFamily: 'Lato',fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 150,
                height: 50,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF8A3FFC),
                          setTimer == true?Colors.grey:Colors.redAccent,
                        ])),
                child: InkWell(
                  onTap: (){
                    print('Printing 11');
                      print('Printing 17');
                      if(setTimer == false){
                        print('Function Callled');
                        _tickCount = 0;
                        // setState(() {
                        //   setTimer == true;
                        // });
                        _startPeriodicTimer();
                      }


                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                        'START TIMER',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Lato'
                        )
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
