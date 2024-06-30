import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const WorkoutTimerApp());
}

class WorkoutTimerApp extends StatelessWidget {
  const WorkoutTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WorkoutTimerHomePage(),
    );
  }
}

class WorkoutTimerHomePage extends StatefulWidget {
  const WorkoutTimerHomePage({super.key});

  @override
  _WorkoutTimerHomePageState createState() => _WorkoutTimerHomePageState();
}

class _WorkoutTimerHomePageState extends State<WorkoutTimerHomePage> {
  final TextEditingController _controllerTotalTime = TextEditingController();
  final TextEditingController _controllerBreakTime = TextEditingController();
  int? _totalTime;
  int? _breakTime;
  int? _intervals;
  int? _remainSeries;
  Timer? _timer;
  int? _timeLeft;
  bool _isPaused = false;
  bool _alertError = false;
  String _errorMessa = "";

  void _startTimer() {
    if (_totalTime == null || _totalTime! <= 0) {
      return setState(() {
        _alertError = true;
        _errorMessa = "Provice a valid Time";
        Timer(
            const Duration(seconds: 1),
            () => setState(() {
                  _alertError = false;
                  _errorMessa = "";
                }));
      });
    }

    setState(() {
      _timeLeft = _totalTime! * 60; // convert to seconds
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft! > 0 && !_isPaused) {
          _timeLeft = _timeLeft! - 1;
        } else if (_timeLeft == 0) {
          timer.cancel();
        }
      });
    });
  }

  void _pauseTimer() {
    setState(() {
      _isPaused = true;
    });
  }

  void _resumeTimer() {
    setState(() {
      _isPaused = false;
    });
  }

  int totalTimeCalc(int totalTimeWorkout, int repouseTime) {
    return totalTimeWorkout ~/ repouseTime;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Timer'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isPaused)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextField(
                          controller: _controllerTotalTime,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Total workout time (minutes)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextField(
                          controller: _controllerBreakTime,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Break time (minutes)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _totalTime = int.tryParse(_controllerTotalTime.text);
                      _isPaused = false;
                      _startTimer();
                    });
                  },
                  child: const Text('Start Timer'),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _isPaused ? _resumeTimer : _pauseTimer,
                      child: Text(_isPaused ? 'Resume Timer' : 'Pause Timer'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                if (_timeLeft != null)
                  Text(
                    'Time Left: ${(_timeLeft! ~/ 60).toString().padLeft(2, '0')}:${(_timeLeft! % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 48),
                  ),
                if (_intervals != null)
                  Text(
                    'Intervals: $_intervals',
                    style: const TextStyle(fontSize: 24),
                  ),
                if (_remainSeries != null)
                  Text(
                    'Remaining Series: $_remainSeries',
                    style: const TextStyle(fontSize: 24),
                  ),
              ],
            ),
          ),
          if (_alertError)
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 100),
                  child: Center(
                    child: Card(
                      elevation: 4, // Adiciona uma sombra ao card
                      child: Padding(
                        padding:  EdgeInsets.all(16.0),
                        child: Text(
                          'Provide a value Time!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'RobotoMono',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
