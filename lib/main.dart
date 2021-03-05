import 'package:flutter/material.dart';
import 'package:flutter_platform/screens/main_screen.dart';
import 'package:flutter_platform/singletons/camera_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:statsfl/statsfl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  CameraProvider cameraProvider = CameraProvider();
  await cameraProvider.init();
  GetIt.I.registerLazySingleton<CameraProvider>(() => cameraProvider);

  runApp(StatsFl(align: Alignment.bottomLeft, child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}
