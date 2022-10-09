import 'package:flutter/material.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Builder(
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Center(
                child: GestureDetector(
              onTap: () {
                final snackBar = SnackBar(
                  content: const Text('Hi, I am a SnackBar!'),
                  backgroundColor: (Colors.black12),
                  action: SnackBarAction(
                    label: 'dismiss',
                    onPressed: () {},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Text(
                  "Check if you need scaffold in this screen to show snackBar"),
            )),
          );
        },
      ),
    );
  }
}
