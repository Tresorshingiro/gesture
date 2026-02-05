# GestureDetector Demo

A simple Flutter app I built to learn and demonstrate how GestureDetector works in Flutter. Made this for a class presentation to show different types of gesture detection.

## What it does

This app shows three main categories of gestures you can detect with Flutter's GestureDetector widget:

### 1. Tap Gestures
- **Single Tap** - Just tap the box once, it turns green
- **Double Tap** - Tap twice quickly, turns pink
- **Long Press** - Hold it down for a bit, turns purple

Pretty straightforward stuff, but it's cool to see how Flutter can tell the difference between these.

### 2. Move Gestures  
There's a purple circle you can drag around inside a container. It uses `onPanUpdate` to track your finger movement and update the position. I added some boundary limits so it doesn't fly off the screen.

### 3. Scale Gestures
This one's a bit trickier - it's the pinch-to-zoom feature. Use two fingers to pinch in/out and you'll see the box scale up or down. The scale factor is displayed right on the box (goes from 0.5x to 3.0x).

## How to run

Just clone this repo and run:
```bash
flutter run
```

**Note:** For the scale gesture on an emulator, hold Ctrl (or Cmd on Mac) while dragging to simulate the pinch gesture.
