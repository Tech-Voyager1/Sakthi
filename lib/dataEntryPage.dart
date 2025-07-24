import 'dart:io';
import 'dart:typed_data';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:sakthi/color.dart';
import 'package:sakthi/homepage.dart';

class Dataentrypage extends StatefulWidget {
  final String boxId;
  final double latitude;
  final double longitude;

  const Dataentrypage({
    super.key,
    required this.boxId,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<Dataentrypage> createState() => _DataentrypageState();
}

class _DataentrypageState extends State<Dataentrypage> {
  Map<String, bool> damages = {
    "Dent": false,
    "Crack": false,
    "Rust": false,
    "Broken Handle": false,
  };

  late TextEditingController _boxIdController;
  late TextEditingController _locationController;
  late TextEditingController _referenceController;

  @override
  void initState() {
    super.initState();
    _referenceController = TextEditingController();
    _boxIdController = TextEditingController(text: widget.boxId);
    _locationController = TextEditingController(
      text:
          "${widget.latitude.toStringAsFixed(6)} , ${widget.longitude.toStringAsFixed(6)}",
    );
    print("Box ID: ${widget.boxId}");
    print("Lat: ${widget.latitude}, Lng: ${widget.longitude}");
  }

  @override
  void dispose() {
    _boxIdController.dispose();
    super.dispose();
  }

  // List<XFile> selectedImages = [];
  // final ImagePicker _picker = ImagePicker();

  // Future<void> pickImages() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     setState(() {
  //       selectedImages.add(image);
  //     });
  //   }
  // }
  // List<File> selectedImages = [];

  // Future<void> pickImages() async {
  //   print("Trying to pick image...");
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       allowMultiple: true,
  //       type: FileType.image,
  //     );

  //     if (result != null && result.files.isNotEmpty) {
  //       final paths = result.paths.whereType<String>().toList();
  //       setState(() {
  //         selectedImages = paths.map((path) => File(path)).toList();
  //       });
  //     } else {
  //       print("No image selected or picker was cancelled.");
  //     }
  //   } catch (e) {
  //     print("Error picking image: $e");
  //   }
  // }

  // List<Uint8List> imageBytesList = [];

  // Future<void> pickImagesWeb() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     allowMultiple: true,
  //     type: FileType.image,
  //     withData: true, // Important: get bytes
  //   );

  //   if (result != null) {
  //     List<Uint8List> newImages = result.files
  //         .where((file) => file.bytes != null)
  //         .map((file) => file.bytes!)
  //         .toList();

  //     setState(() {
  //       imageBytesList.addAll(newImages); // ✅ append instead of overwrite
  //     });
  //   } else {
  //     print("No image selected.");
  //   }
  // }

  final ImagePicker _picker = ImagePicker();

  List<Uint8List> imageBytesList = [];

  Future<void> pickImagesAndroid() async {
    final List<XFile>? images = await _picker.pickMultiImage();

    if (images != null) {
      List<Uint8List> pickedBytes = [];

      for (XFile image in images) {
        Uint8List bytes = await image.readAsBytes();
        pickedBytes.add(bytes);
      }

      setState(() {
        imageBytesList.addAll(pickedBytes);
      });
    } else {
      print("No images selected.");
    }
  }

  void _showSummaryDialog(BuildContext context) {
    String boxId = widget.boxId;
    //String status = selectedStatus;
    String status = "Halt-Not in Delivery";
    List<String> selectedDamages = damages.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    int imageCount = imageBytesList.length;
    String coordinates = _locationController.text;
    String reference = _referenceController.text;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Box Summary"),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9, // 👈 Bigger dialog
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Box ID: $boxId"),
                Text("Status: $status"),
                Text("Damages: ${selectedDamages.join(', ')}"),
                Text("Damage Proof: $imageCount image(s)"),
                Text("Location: $coordinates"),
                if (reference.isNotEmpty) Text("📝 Reference: $reference"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // 👈 Cancel button
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog first

                // Navigate to HomePage with a snackbar after navigation
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                ).then((_) {
                  // Show snackbar AFTER navigation completes
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Data Entered ✅"),
                      backgroundColor: Colors.green[600],
                      duration: Duration(seconds: 2),
                    ),
                  );
                });
              },
              child: const Text("Enter"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "DATA ENTRY",
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.w400),
        ),
        centerTitle: false,
        backgroundColor: primaryOrange,
        toolbarHeight: height / 10,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Box ID",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25, top: 10),
                child: SizedBox(
                  child: TextField(
                    controller: _boxIdController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Ex: 001",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Status",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Halt – Not in Delivery", // 🔁 Replace with dynamic value if needed
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Text(
                "Damages",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 05),
              Wrap(
                spacing: 10,
                runSpacing: 4,
                children: damages.keys.map((String key) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: damages[key],
                          onChanged: (bool? value) {
                            setState(() {
                              damages[key] = value ?? false;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Text(key),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 1),
              ElevatedButton.icon(
                //onPressed: pickImages,
                onPressed: pickImagesAndroid,
                icon: Icon(Icons.camera_alt),
                label: Text("Attach Image"),
              ),
              SizedBox(height: 10),
              //if (selectedImages.isNotEmpty)
              if (imageBytesList.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(imageBytesList.length, (index) {
                      final bytes = imageBytesList[index];
                      return Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (_) => Dialog(
                                    backgroundColor: Colors.transparent,
                                    insetPadding: EdgeInsets.all(
                                        100), // 👈 Your custom padding
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: InteractiveViewer(
                                            child: Image.memory(
                                              bytes,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 5,
                                          right: 5,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pop(); // Close dialog
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                                shape: BoxShape.circle,
                                              ),
                                              padding: EdgeInsets.all(6),
                                              margin: EdgeInsets.all(4),
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.memory(
                                  bytes,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  imageBytesList.removeAt(index);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(2),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),

              SizedBox(height: 20),
              Text(
                "Location",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25, top: 15),
                child: SizedBox(
                  child: TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: "11.028334 , 77.027356",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25, top: 12),
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Ex: Sakthi Auto - Coimbatore",
                      labelText: "Location Name (Optional)",
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: SizedBox(
                    width: width / 2,
                    child: ElevatedButton(
                      onPressed: () => _showSummaryDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryOrange, // 🔴 Dark Red
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      child: const Text("Enter"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
