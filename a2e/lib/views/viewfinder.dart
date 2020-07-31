import 'package:a2e/utils/sizes.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ViewfinderPage extends StatefulWidget {
  @override
  _ViewfinderPageState createState() => _ViewfinderPageState();
}

class _ViewfinderPageState extends State<ViewfinderPage> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool isCameraReady = false;

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(firstCamera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  @override
  void initState() {
    _initializeCamera();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isCameraReady) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Column(
              children: [
                AspectRatio(
                  aspectRatio: 2 / 3,
                  child: CameraPreview(_controller),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    width: displayWidth(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
