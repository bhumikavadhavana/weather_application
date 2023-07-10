import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/themeprovider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed("home_page");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 190,
        width: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMsnJ_fRH4k_Z9uFoxKnxjhuZu6qM9LqWdrQ&usqp=CAU"),
            fit: BoxFit.fill
          ),
        ),
      ),
    ));
  }
}
