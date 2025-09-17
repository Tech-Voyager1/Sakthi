import 'package:flutter/material.dart';
import 'package:sakthi/color.dart';
import 'package:sakthi/drawer.dart';
import 'package:sakthi/scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Track expansion states
  bool _isGroup1Expanded = false;
  bool _isGroup2Expanded = false;

  // Example data
  final List<String> group1Boxes = ["Box 001", "Box 002"];
  final List<String> group2Boxes = ["Box 101", "Box 102"];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryOrange,
        toolbarHeight: height / 10,
        title: const Text(
          'Smart Tracker',
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // QR scanner section
              SizedBox(
                height: 50,
              ),
              const Icon(Icons.qr_code_2, size: 150),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QRScanScreen()));
                },
                icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                label: const Text(
                  'Click to Scan Boxes',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryOrange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 80),

              // Group 1 card
              _buildGroupCard(
                title: "Group 1",
                isExpanded: _isGroup1Expanded,
                onToggle: () {
                  setState(() => _isGroup1Expanded = !_isGroup1Expanded);
                },
                boxes: group1Boxes,
                onAddBox: () {
                  setState(() {
                    group1Boxes.add("Box ${group1Boxes.length + 1}");
                  });
                },
              ),

              const SizedBox(height: 40),

              // Group 2 card
              _buildGroupCard(
                title: "Group 2",
                isExpanded: _isGroup2Expanded,
                onToggle: () {
                  setState(() => _isGroup2Expanded = !_isGroup2Expanded);
                },
                boxes: group2Boxes,
                onAddBox: () {
                  setState(() {
                    group2Boxes.add("Box ${group2Boxes.length + 1}");
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupCard({
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required List<String> boxes,
    required VoidCallback onAddBox,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            title: Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green),
                  onPressed: onAddBox,
                ),
                IconButton(
                  icon: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                  onPressed: onToggle,
                ),
              ],
            ),
          ),
          if (isExpanded)
            Column(
              children: boxes
                  .map((box) => ListTile(
                        title: Text(box),
                        leading: const Icon(Icons.inventory_2_outlined),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}
