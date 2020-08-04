import 'package:a2e/utils/colors.dart';
import 'package:a2e/utils/sizes.dart';
import 'package:a2e/views/viewfinder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String res;
void loadModel() async {
  res = await Tflite.loadModel(
    model: "assets/model/phone_VGG16--88--08-03-03-29.tflite",
    labels: "assets/model/labels_mobilenet_quant_v1_224.txt",
  );
}

class _HomeScreenState extends State<HomeScreen> {
  void testModel() async {
    var recoginitions = await Tflite.runModelOnImage(
      path: 'assets/model/testA.png',
      imageMean: 255,
      asynch: true,
    );
    print(recoginitions.toString());
  }

  @override
  void initState() {
    //loadModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Theme.of(context).backgroundColor,
        systemNavigationBarColor: Theme.of(context).backgroundColor,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'A2E',
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w800,
                          fontSize: displayWidth(context) * 0.07),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'button',
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        height: displayWidth(context) * 0.13,
                        width: displayWidth(context) * 0.25,
                        child: RaisedButton(
                          child: Icon(
                            Icons.camera,
                            color: Theme.of(context).textSelectionColor,
                            size: displayWidth(context) * 0.1,
                          ),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          onPressed: () {
                            Get.to(
                              ViewfinderPage(),
                            );
                          },
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
