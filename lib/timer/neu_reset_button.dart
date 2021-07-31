import 'package:flutter/material.dart';
import './screen.dart';
import 'package:provider/provider.dart';

class NeuResetButton extends StatefulWidget {
  final double bevel;
  final Offset blurOffset;

  NeuResetButton({
    Key key,
    this.bevel = 10.0,
  })  : this.blurOffset = Offset(bevel / 2, bevel / 2),
        super(key: key);

  @override
  _NeuResetButtonState createState() => _NeuResetButtonState();
}

class _NeuResetButtonState extends State<NeuResetButton> {
  bool _isPressed = false;

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
          final isRunning =
              Provider.of<TimerService>(context, listen: false).isRunning;
          Provider.of<TimerService>(context, listen: false).reset();
          // If user press reset button when timer is running, start for them
          if (isRunning)
            Provider.of<TimerService>(context, listen: false).start();
        },
        onPointerUp: _onPointerUp,
        child:  AnimatedContainer(

            duration: const Duration(milliseconds: 150),
            width: 110,
            height: 70,
            
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              //color: Color.fromRGBO(227, 237, 247, 1),
              color: Colors.green,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white,),
              
            ),
            child:Center(
                  
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                    ),
                    
                  ),
                ),
           ),
            
          
        );
      
    
  }
}

extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }
}