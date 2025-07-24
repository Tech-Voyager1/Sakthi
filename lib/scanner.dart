import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:sakthi/dataEntryPage.dart';
import 'package:geolocator/geolocator.dart';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({super.key});

  @override
  State<QRScanScreen> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool scanned = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();

      final code = scanData.code ?? '';
      final uri = Uri.tryParse(code);
      final boxId = uri?.queryParameters['id'] ?? '';

      //✅ Get current location
      // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      // if (!serviceEnabled) {
      //   await Geolocator.openLocationSettings();
      //   return;
      // }

      // LocationPermission permission = await Geolocator.checkPermission();
      // if (permission == LocationPermission.denied ||
      //     permission == LocationPermission.deniedForever) {
      //   permission = await Geolocator.requestPermission();
      // }

      // if (permission == LocationPermission.always ||
      //     permission == LocationPermission.whileInUse) {
      //   final position = await Geolocator.getCurrentPosition(
      //       desiredAccuracy: LocationAccuracy.high);

      //   // ✅ Navigate and pass boxId and location

      // }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dataentrypage(
            boxId: boxId,
            latitude: 11.028323, //position.latitude,
            longitude: 77.027365, //position.longitude,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QR Scanner")),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.orange,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 250,
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Center(
              child: Text('Scan a box QR code'),
            ),
          ),
        ],
      ),
    );
  }
}
