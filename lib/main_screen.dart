import 'package:flutter/material.dart';
import 'package:flutter_platform/camera_widget.dart';
import 'package:flutter_platform/camera_widget2.dart';
import 'package:flutter_platform/canvas_widget.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  final List<Tab> _myTabs = <Tab>[
    Tab(icon: Icon(Icons.camera), text: 'Camera'),
    Tab(icon: Icon(Icons.monitor), text: 'Canvas'),
    Tab(icon: Icon(Icons.camera_alt), text: 'Camera2'),
  ];
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter UI Easy"),
        bottom: TabBar(
          controller: _tabController,
          tabs: _myTabs,
        ),
      ),
      drawer: Stack(children: [
        Drawer(
          child: CanvasWidget(),
        ),
        Center(child: Text("I dont know what to add here")),
      ]),
      body: TabBarView(controller: _tabController, children: <Widget>[
        CameraWidget(),
        CanvasWidget(),
        CameraWidget2(),
      ]),
    );
  }
}
