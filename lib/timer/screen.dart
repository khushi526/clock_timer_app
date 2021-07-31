import 'dart:async';

import 'package:clockapp/constants/theme_data.dart';
import 'package:flutter/material.dart';
import './neu_digital_clock.dart';
import './neu_hamburger_button.dart';
import './neu_progress_pie_bar.dart';
import './neu_reset_button.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timeService = TimerService();
    return ChangeNotifierProvider<TimerService>(
      create: (_) => timeService,
      child: Scaffold(
        backgroundColor: CustomColors.pageBackgroundColor,
        body: SingleChildScrollView(
                  child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).viewPadding.top + 20),
                TimerTitle(),
                SizedBox(height: 20),
                NeuDigitalClock(),
                //SizedBox(height: 2),
                NeuProgressPieBar(),
                //SizedBox(height: 2),
                NeuResetButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimerTitle extends StatelessWidget {
  const TimerTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Row(
        children: <Widget>[
          Text(
            'Timer',
            style: TextStyle(
          fontFamily: 'avenir',
          color: CustomColors.primaryTextColor,
          //fontWeight: FontWeight.bold,
          fontSize: 49),
          ),
          //Spacer(),
         // NeuHamburgerButton()
        ],
      ),
    );
  }
}

class TimerService extends ChangeNotifier {
  Stopwatch _watch;
  Timer _timer;

  Duration get currentDuration => _currentDuration;
  Duration _currentDuration = Duration.zero;

  bool get isRunning => _timer != null;

  TimerService() {
    _watch = Stopwatch();
  }

  void _onTick(Timer timer) {
    _currentDuration = _watch.elapsed;

    // notify all listening widgets
    notifyListeners();
  }

  void start() {
    if (_timer != null) return;

    _timer = Timer.periodic(Duration(seconds: 1), _onTick);
    _watch.start();

    notifyListeners();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _watch.stop();
    _currentDuration = _watch.elapsed;

    notifyListeners();
  }

  void reset() {
    stop();
    _watch.reset();
    _currentDuration = Duration.zero;

    notifyListeners();
  }
  // source: https://stackoverflow.com/questions/53228993/how-to-implement-persistent-stopwatch-in-flutter
}