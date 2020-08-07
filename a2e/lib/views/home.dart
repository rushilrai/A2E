import 'package:a2e/utils/colors.dart';
import 'package:a2e/utils/sizes.dart';
import 'package:a2e/views/viewfinder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String res;
//not using this.
void loadModel() async {
  res = await Tflite.loadModel(
    model: "assets/model/phone_VGG16--89--08-03-01-46.tflite",
    labels: "assets/model/labels_mobilenet_quant_v1_224.txt",
  );
}
//ignore

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
        statusBarIconBrightness: Brightness.light,
        statusBarColor: secondaryColor,
        systemNavigationBarColor: whiteColor,
      ),
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: SafeArea(
          child: SlidingUpPanel(
            minHeight: displayWidth(context) * 1.3,
            maxHeight: displayWidth(context) * 1.65,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60),
            ),
            panel: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                ),
                color: whiteColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  children: [
                    Text('hello'),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'A2E',
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w600,
                          fontSize: displayWidth(context) * 0.1,
                          color: mainColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        width: displayWidth(context) * 0.5,
                        child: Text(
                          'Communication should have no boundaries',
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w800,
                            fontSize: displayWidth(context) * 0.04,
                            color: mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Hero(
                        tag: 'button',
                        child: Container(
                          width: displayWidth(context) * 0.5,
                          height: displayWidth(context) * 0.14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 10),
                                spreadRadius: -5,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: RaisedButton(
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Live Translation',
                                      style: TextStyle(
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.w800,
                                        fontSize: displayWidth(context) * 0.04,
                                        color: secondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              splashColor: mainColor,
                              onPressed: () {
                                Get.to(
                                  ViewfinderPage(),
                                );
                              },
                              color: mainColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Hero(
                        tag: 'back',
                        child: Icon(
                          Icons.arrow_forward,
                          color: mainColor,
                          size: displayWidth(context) * 0.07,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
SafeArea(
          child: Stack(
            children: [
              Container(
                color: whiteColor,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'A2E',
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w600,
                              fontSize: displayWidth(context) * 0.1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            width: displayWidth(context) * 0.5,
                            child: Text(
                              'Communication should have no boundaries',
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.w800,
                                fontSize: displayWidth(context) * 0.04,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.transparent,
                  height: displayWidth(context) * 1.5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(90),
                            ),
                          ),
                          height: 800,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),*/
