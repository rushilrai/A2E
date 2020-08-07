import 'package:a2e/utils/colors.dart';
import 'package:a2e/utils/sizes.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';

class ViewfinderPage extends StatefulWidget {
  @override
  _ViewfinderPageState createState() => _ViewfinderPageState();
}

class _ViewfinderPageState extends State<ViewfinderPage> {
  void testModel() async {
    var recoginitions = await Tflite.runModelOnImage(
      path: 'assets/model/testA.png',
      imageMean: 255,
      asynch: true,
    );
    print(recoginitions.toString());
  }

  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool isCameraReady = false;

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras[0];
    _controller = CameraController(firstCamera, ResolutionPreset.ultraHigh);
    _initializeControllerFuture = _controller.initialize().then((_) async {
      if (!mounted) {
        return;
      }
      setState(() {
        isCameraReady = true;
      });

      String res = await Tflite.loadModel(
        model: "assets/model/phone_VGG16--92--08-02-23-36.tflite",
        labels: "assets/model/labels.txt",
      );
      print('start');
      _controller.startImageStream(
        (image) async {
          Tflite.runModelOnFrame(
            bytesList: image.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            imageHeight: image.height,
            imageWidth: image.width,
            threshold: 0.5,
            numResults: 1,
            asynch: true,
          ).then((value) {
            value.map((res) {});
            print(value.first);
            //   print('yes');
            setState(() {
              label = value.first['label'].toString();
            });
            //   print(label);
          });
        },
      );
    });
  }

  String label = '';
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: whiteColor,
      ),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: secondaryColor,
            automaticallyImplyLeading: true,
            leading: Hero(
              tag: 'back',
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: mainColor,
                ),
              ),
            ),
          ),
          backgroundColor: whiteColor,
          body: Stack(
            children: [
              Column(
                children: [
                  Flexible(
                    flex: 3,
                    child: (isCameraReady)
                        ? CameraPreview(_controller)
                        : Container(),
                  ),
                  Flexible(
                    flex: 1,
                    child: AnimatedContainer(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      duration: Duration(milliseconds: 200),
                      width: displayWidth(context),
                      child: Center(
                        child: Text(
                          label,
                          style: TextStyle(
                            color: mainColor,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w800,
                            fontSize: displayWidth(context) * 0.14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: displayHeight(context), end: 0),
                duration: Duration(
                  milliseconds: 300,
                ),
                builder: (context, value, child) {
                  return Center(
                    child: Hero(
                      tag: 'button',
                      child: AnimatedContainer(
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        duration: Duration(milliseconds: 200),
                        width: value,
                        height: value,
                      ),
                    ),
                  );
                },
              )
            ],
          )),
    );
  }
}
