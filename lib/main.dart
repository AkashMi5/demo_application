import 'package:demo_application/screen_one.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draggable demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Offset position = const Offset(100, 100); // for Green container
  Offset position2 = const Offset(100, 205); // for Red Container

  double width = 400;
  double height = 700;

  void updatePosition(Offset newPosition) {
    if (newPosition.dx < position2.dx + 100 &&
        newPosition.dx + 100 > position2.dx &&
        newPosition.dy < position2.dy + 100 &&
        newPosition.dy + 100 > position2.dy) {
      // This if condition will check for overlap and handle the repositioning of the green container
      setState(() {
        if (width - position2.dx < 205) {
          if (height - position2.dy < 205) {
            position = Offset(position2.dx, position2.dy - 105);
          } else {
            position = Offset(position2.dx, position2.dy + 105);
          }
        } else if (position2.dx < 205) {
          if (height - position2.dy < 205) {
            position = Offset(position2.dx, position2.dy - 105);
          } else {
            position = Offset(position2.dx, position2.dy + 105);
          }
        } else {
          position = Offset(position2.dx, position2.dy + 105);
        }
      });
    } else {
      setState(() {
        position = newPosition;
      });
    }
  }

  void updatePosition2(Offset newPosition) {
    if (newPosition.dx < position.dx + 100 &&
        newPosition.dx + 100 > position.dx &&
        newPosition.dy < position.dy + 100 &&
        newPosition.dy + 100 > position.dy) {
      // This if condition will check for overlap and handle the repositioning of the red container
      setState(() {
        if (width - position.dx < 205) {
          if (height - position.dy < 205) {
            position2 = Offset(position.dx, position.dy - 105);
          } else {
            position2 = Offset(position.dx, position.dy + 105);
          }
        } else if (position.dx < 205) {
          if (height - position.dy < 205) {
            position2 = Offset(position.dx, position.dy - 105);
          } else {
            position2 = Offset(position.dx, position.dy + 105);
          }
        } else {
          position2 = Offset(position.dx, position.dy + 105);
        }
      });
    } else {
      setState(() {
        position2 = newPosition;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 50,
              top: 50,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ScreenOne()));
                },
                child: const Text("Go to Screen One"),
              ),
            ),
            Positioned(
              left: position.dx,
              top: position.dy,
              child: GestureDetector(
                  child: Draggable(
                maxSimultaneousDrags: 1,
                feedback: Container(
                  height: 100,
                  width: 100,
                  color: Colors.green,
                ),
                childWhenDragging: Opacity(
                  opacity: .3,
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.green,
                  ),
                ),
                onDragEnd: (details) => updatePosition(details.offset),
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.green,
                ),
              )),
            ),
            Positioned(
              left: position2.dx,
              top: position2.dy,
              child: GestureDetector(
                  child: Draggable(
                maxSimultaneousDrags: 1,
                feedback: Container(
                  height: 100,
                  width: 100,
                  color: Colors.red,
                ),
                childWhenDragging: Opacity(
                  opacity: .3,
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                  ),
                ),
                onDragEnd: (details) => updatePosition2(details.offset),
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.red,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
