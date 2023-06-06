import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class DemoFutureWidget extends StatefulWidget {
  const DemoFutureWidget({Key? key}) : super(key: key);

  @override
  State<DemoFutureWidget> createState() => _DemoFutureWidgetState();
}

class _DemoFutureWidgetState extends State<DemoFutureWidget> {
  Future<int?> randomNumber() {
    Completer<int?> completer = Completer();

    Future.delayed(Duration(seconds: 2), () {
      var number = Random().nextInt(1000);
      if (number % 2 == 0) {
        completer.complete(number);
      } else {
        completer.complete(null);
      }
    });

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo future widget"),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder<int?>(
            future: randomNumber(),
            initialData: null,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text("None ${snapshot.data.toString()}");
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  return Text("Active ${snapshot.data.toString()}");
              }
            },
          ),
        ),
      ),
    );
  }
}
