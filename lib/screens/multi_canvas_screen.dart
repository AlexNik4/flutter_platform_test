import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform/widgets/canvas_widget.dart';

class MultiCanvasScreen extends StatefulWidget {
  MultiCanvasScreen({Key key}) : super(key: key);

  @override
  _MultiCanvasScreenState createState() => _MultiCanvasScreenState();
}

class _MultiCanvasScreenState extends State<MultiCanvasScreen> {
  var listOfCanvases = List<CanvasWidget>.generate(100, (i) => CanvasWidget());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Performance"),
        ),
        body: ListView.builder(
          itemCount: listOfCanvases.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: MediaQuery.of(context).size.width > 600 ? 140 : 80,
              child: listOfCanvases[index],
            );
          },
        ));
  }
}
