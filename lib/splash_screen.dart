import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieaplikasi/homepage.dart';
import 'package:movieaplikasi/my_images.dart';
import 'package:movieaplikasi/mycolor.dart';
import 'package:movieaplikasi/routers.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreen();
  }

}

class _SplashScreen extends State<SplashScreen>{

  navigateDelay(String page) async {
    var _duration = new Duration(milliseconds: 3000);
    return new Timer(_duration, () {
      Navigator.of(context).pushReplacementNamed(page, arguments: HomeScreen(title: "Popular Movie", subTitle: "Now Playing"));
    });
  }

  @override
  void initState() {
    navigateDelay(NavigateName.homescreen);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: MyColors.baseColor,child: Center(child: Image.asset(MyImages.logo),),),
    );
  }

}