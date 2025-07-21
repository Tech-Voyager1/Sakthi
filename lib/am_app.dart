import 'package:flutter/material.dart';


void main(){
  runApp(my_app());
}
class my_app extends StatefulWidget {
  const my_app({super.key});

  @override
  State<my_app> createState() => _my_appState();
}

class _my_appState extends State<my_app> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Sakthi"),centerTitle: true,backgroundColor: const Color.fromARGB(255, 255, 238, 188),),
        body: Container(
          height: double.infinity, //parent-dependent
          width: double.infinity, 
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //margin: EdgeInsets.only(left: 20),
                height: 200,
                width: 200,
                color: Colors.amber,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 200,
                width: 200,
                color: Colors.amber,
              ),
            ],
          ),
        ),
      ),
    ) ;
  }
}