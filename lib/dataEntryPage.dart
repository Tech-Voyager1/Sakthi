import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:sakthi/color.dart';

class Dataentrypage extends StatefulWidget {
  Dataentrypage({super.key});

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

  List<Uint8List> imageBytesList = [];

  Future<void> pickImagesWeb() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
      withData: true, // Important: get bytes
    );

    if (result != null) {
      List<Uint8List> newImages = result.files
          .where((file) => file.bytes != null)
          .map((file) => file.bytes!)
          .toList();

      setState(() {
        imageBytesList.addAll(newImages); // ✅ append instead of overwrite
      });
    } else {
      print("No image selected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryOrange,
        toolbarHeight: height / 10,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Box id",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25, top: 18),
              child: SizedBox(
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Ex: 001"),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Damages",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 20,
              runSpacing: 10,
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
            SizedBox(height: 30),
            ElevatedButton.icon(
              //onPressed: pickImages,
              onPressed: pickImagesWeb,
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
                                        borderRadius: BorderRadius.circular(12),
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
                                              color:
                                                  Colors.black.withOpacity(0.6),
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

            SizedBox(height: 10),
            Text(
              "Location",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25, top: 18),
              child: SizedBox(
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Ex: 001"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
