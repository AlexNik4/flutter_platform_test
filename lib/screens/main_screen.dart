import 'package:flutter/material.dart';
import 'package:flutter_platform/screens/multi_canvas_screen.dart';
import 'package:flutter_platform/widgets/camera_widget.dart';
import 'package:flutter_platform/widgets/camera_widget2.dart';
import 'package:flutter_platform/widgets/canvas_widget.dart';

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
    var navigationDrawer = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Stack(fit: StackFit.expand, children: [
              CanvasWidget(),
              Center(child: Text("I dont know what to add here")),
            ]),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Performance'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MultiCanvasScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Item 3'),
            onTap: () {},
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter UI Easy"),
        bottom: TabBar(
          controller: _tabController,
          tabs: _myTabs,
        ),
      ),
      drawer: navigationDrawer,
      body: TabBarView(controller: _tabController, children: <Widget>[
        CameraWidget2(),
        CanvasWidget(),
        CameraWidget(),
      ]),
    );
  }
}
