import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(const ScaffoldExampleApp());

class ScaffoldExampleApp extends StatelessWidget {
  const ScaffoldExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScaffoldExample(),
    );
  }
}

class CountDownContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      //define start position container
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 300,
          width: 500,
          child: const Padding(
            padding: EdgeInsets.all(8),
            //change card color before
          
            child: Card(
              color: Colors.lightBlueAccent,
              child: Center(
                child: Text("data"),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ScaffoldExample extends StatefulWidget {
  const ScaffoldExample({super.key});

  @override
  State<ScaffoldExample> createState() => _ScaffoldExampleState();
}

class _ScaffoldExampleState extends State<ScaffoldExample> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          alignment: Alignment.center,
          child: CountDownContainer(),
        ));
  }
}
