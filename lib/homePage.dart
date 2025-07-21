import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xfff66525),
      toolbarHeight: height/10,
      ),
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              height: 180,
              width: 180,
              color: Colors.amber,
            ),
            TextButton(onPressed:(){}, child:Text("Click here\tto Scan"))
          ],
        ),
      ),
    );
  }
}