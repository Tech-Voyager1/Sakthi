import 'package:flutter/material.dart';
import 'package:sakthi/homePage.dart';

class Splashscreen extends StatefulWidget {
   const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

    @override
  void initState() {
    super.initState();

    // Delay for 3 seconds then go to HomePage
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: Container(
      height: height,
      width: width,
      color: Color(0xfff66525),
      child: Padding(
        padding:EdgeInsets.only(top:height/3.3),
        child: Text("Sakthi\nHackathon 1.0",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.w600),),
      ),
        )
      );
    
  }
}