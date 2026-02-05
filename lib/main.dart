import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GestureDetector Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const GestureDemo(),
    );
  }
}

class GestureDemo extends StatefulWidget {
  const GestureDemo({super.key});

  @override
  State<GestureDemo> createState() => _GestureDemoState();
}

class _GestureDemoState extends State<GestureDemo> {
  String tapGesture = 'Tap me';
  Color tapBoxColor = Colors.orange;

  Offset panPosition = const Offset(100, 80);

  void _handleTap() {
    setState(() {
      tapGesture = 'Tap';
      tapBoxColor = Colors.green;
    });
  }

  void _handleDoubleTap() {
    setState(() {
      tapGesture = 'Double';
      tapBoxColor = Colors.pink;
    });
  }

  void _handleLongPress() {
    setState(() {
      tapGesture = 'Long';
      tapBoxColor = Colors.purple;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 255, 7),
        centerTitle: true,
        title: Text('Learn GestureDetector'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('1. TAP GESTURES', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text('onTap, onDoubleTap, onLongPress'),
            SizedBox(height: 15),
            Center(
              child: GestureDetector(
                onTap: _handleTap,
                onDoubleTap: _handleDoubleTap,
                onLongPress: _handleLongPress,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: tapBoxColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.touch_app, size: 50, color: Colors.white,),
                        SizedBox(height: 10),
                        Text(
                          tapGesture,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],),
                  ),
                )
              ),
            ),
          SizedBox(height: 40,),
          
          Text('2. Move GESTURES', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text('onPanUpdate (drag anywhere)'),
          SizedBox(height: 15,),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: panPosition.dx,
                  top: panPosition.dy,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        final maxWidth = MediaQuery.of(context).size.width -140;
                        panPosition = Offset((panPosition.dx + details.delta.dx).clamp(0, maxWidth), 
                        (panPosition.dy + details.delta.dy).clamp(0, 120),
                        );
                      });
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(Icons.pan_tool, color: Colors.white, size: 40,),
                    ),
                  ),
                )
              ],
            )
          )  
          ],
        )
      )
    );
  }
}