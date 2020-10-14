import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class CameraProvider {
  CameraDescription _firstCamera;

  CameraDescription get firstCamera {
    return _firstCamera;
  }

  Future<void> init() async {
    if (!kIsWeb) {
      final cameras = await availableCameras();
      _firstCamera = cameras.first;
    }
  }
}
