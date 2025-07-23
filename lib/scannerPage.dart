import 'package:flutter/material.dart';
import 'package:sakthi/color.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  void _startScanning(BuildContext context) {
    // TODO: Add your scanning logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Scanner opened')),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryOrange, // replace with your primaryOrange
        toolbarHeight: height / 10,
        title: const Text('Scan Boxes'),
      ),
      drawer: Drawer(

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.qr_code_2, size: 150), // QR image
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _startScanning(context),
              icon: const Icon(Icons.qr_code_scanner,color: Colors.white,),
              label: const Text('Click to Scan Boxes',style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryOrange, // optional
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
