import 'package:flutter/material.dart';
import './neu_progress_painter.dart';
import './screen.dart';
import 'package:provider/provider.dart';

class NeuProgressPieBar extends StatelessWidget {
  const NeuProgressPieBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percentage =
        Provider.of<TimerService>(context).currentDuration.inSeconds / 60 * 100;
    return Column(

          children:[ Container(
        width: 200,
        height: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(225, 234, 244, 1),
          
          border: Border.all(
            width: 15,
            color: Color(0xFF444974),
            //color: Theme.of(context).backgroundColor,
            
           

          ),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: SizedBox(
                height: 250,
                child: CustomPaint(
                  painter: NeuProgressPainter(
                    circleWidth: 29,
                    completedPercentage: percentage,
                    defaultCircleColor: Colors.transparent,
                  ),
                  child: Center(),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.0),
                      Colors.black54,
                    ],
                    stops: [0.95, 1.0],
                  ),
                  border: Border.all(
                    width: 25,
                    //color: Theme.of(context).backgroundColor,
                    //color: Color(0xFFEAECFF),
                    color: Colors.yellow[600],
                  ),
                ),
                child: Center(child: NeuStartButton()),
              ),
            ),
          ],
        ),
      ),
      

    ]
    );
  }
}

class NeuStartButton extends StatefulWidget {
  final double bevel;
  final Offset blurOffset;

  NeuStartButton({
    Key key,
    this.bevel = 10.0,
  })  : this.blurOffset = Offset(bevel / 2, bevel / 2),
        super(key: key);

  @override
  _NeuStartButtonState createState() => _NeuStartButtonState();
}

class _NeuStartButtonState extends State<NeuStartButton> {
  bool _isPressed = false;
  bool _isRunning = false;

  void _onPointerDown() {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        _onPointerDown();
        _isRunning
            ? Provider.of<TimerService>(context, listen: false).stop()
            : Provider.of<TimerService>(context, listen: false).start();
        setState(() => _isRunning = !_isRunning);
      },
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 100,
        height: 95,
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.pink[600],
          boxShadow: _isPressed
              ? null
              : [
                  BoxShadow(
                    blurRadius: 15,
                    spreadRadius: 5,
                    offset: -widget.blurOffset,
                    color: Colors.white,
                  ),
                  BoxShadow(
                    blurRadius: 15,
                    offset: Offset(10.5, 10.5),
                    color: Color.fromRGBO(214, 223, 230, 1),
                  )
                ],
        ),
        child: Center(
            child: Icon(
          _isRunning ? Icons.stop : Icons.play_arrow,
          size: 60,
          color: _isRunning
              ? Colors.greenAccent.shade400
              : Colors.greenAccent.shade400,
        )),
      ),
    );
  }
}

extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }
}