import 'package:a2e/utils/colors.dart';
import 'package:a2e/utils/sizes.dart';
import 'package:a2e/views/viewfinder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Theme.of(context).primaryColor,
        systemNavigationBarColor: Theme.of(context).backgroundColor,
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'A2E',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w800,
                fontSize: displayWidth(context) * 0.06,
                color: blackColor,
              ),
            ),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: displayWidth(context) * 0.13,
                      width: displayWidth(context) * 0.3,
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
                        color: Theme.of(context).accentColor,
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
