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
  // TAP GESTURES - State variables for tap detection
  String tapGesture = 'Tap me';
  Color tapBoxColor = Colors.orange;

  // MOVE GESTURES - Position of draggable circle
  Offset panPosition = const Offset(100, 80);

  // SCALE GESTURES - Current scale factor for zoom
  double scale = 1.0;

  // Handle single tap
  void _handleTap() {
    setState(() {
      tapGesture = 'Tap';
      tapBoxColor = Colors.green;
    });
  }

  // Handle double tap
  void _handleDoubleTap() {
    setState(() {
      tapGesture = 'Double';
      tapBoxColor = Colors.pink;
    });
  }

  // Handle long press
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
            // === TAP GESTURES DEMO ===
            Text('1. TAP GESTURES', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text('onTap, onDoubleTap, onLongPress'),
            SizedBox(height: 15),
            Center(
              child: GestureDetector(
                // Detects single tap
                onTap: _handleTap,
                // Detects double tap
                onDoubleTap: _handleDoubleTap,
                // Detects long press (hold)
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
          
          // === MOVE GESTURES DEMO ===
          Text('2. MOVE GESTURES', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
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
                    // Detects dragging movement and updates position
                    onPanUpdate: (details) {
                      setState(() {
                        final maxWidth = MediaQuery.of(context).size.width -140;
                        // Update position with boundary limits
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
          ),
          SizedBox(height: 40,),

          // === SCALE GESTURES DEMO ===
          Text('3. SCALE GESTURES', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text('onScaleUpdate (pinch to zoom)'),
          SizedBox(height: 15,),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: GestureDetector(
                // Detects pinch gesture (2 fingers) for zooming
                onScaleUpdate: (details) {
                  setState(() {
                    // Update scale with limits: min 0.5x, max 3.0x
                    scale = (scale * details.scale).clamp(0.5, 3.0);
                  });
                },
                child: Center(
                  child: Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.pink, Colors.orange],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          '${scale.toStringAsFixed(1)}x',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30,),
          ],
        )
      )
    );
  }
}