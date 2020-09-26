import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraWidget2 extends StatefulWidget {
  @override
  CameraWidget2State createState() => CameraWidget2State();
}

class CameraWidget2State extends State<CameraWidget2> with AutomaticKeepAliveClientMixin {
  Image _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        if (kIsWeb) {
            _image = Image.network(pickedFile.path);
          } else {
            _image = Image.file(File(pickedFile.path));
          }
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : _image,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}