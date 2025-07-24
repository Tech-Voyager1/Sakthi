import 'package:flutter/material.dart';
import 'package:sakthi/color.dart';
import 'package:sakthi/drawer.dart';
import 'package:sakthi/scanner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        title: const Text(
          'Smart Tracker',
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.qr_code_2, size: 150), // QR image
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QRScanScreen()));
              },
              icon: const Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
              ),
              label: const Text(
                'Click to Scan Boxes',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryOrange, // optional
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
