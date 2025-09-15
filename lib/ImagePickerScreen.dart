// // // import 'dart:io';
// // // import 'dart:math';
// // // import 'package:camera/camera.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:path_provider/path_provider.dart';
// // // import 'package:image/image.dart' as img;

// // // class Imagepickerscreen extends StatefulWidget {
// // //    Imagepickerscreen({Key? key}) : super(key: key);

// // //   @override
// // //   State<Imagepickerscreen> createState() => _ImagepickerscreenState();
// // // }

// // // class _ImagepickerscreenState extends State<Imagepickerscreen> {
// // //   CameraController? _controller;
// // //   List<CameraDescription>? cameras;
// // //   bool isReady = false;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _initCamera();
// // //   }

// // //   Future<void> _initCamera() async {
// // //     cameras = await availableCameras();
// // //     _controller = CameraController(
// // //       cameras!.first,
// // //       ResolutionPreset.medium, // 4:3 on most devices
// // //       enableAudio: false,
// // //     );
// // //     await _controller!.initialize();
// // //     setState(() {
// // //       isReady = true;
// // //     });
// // //   }

// // //   Future<void> _takePicture() async {
// // //     if (!_controller!.value.isInitialized) return;

// // //     final XFile file = await _controller!.takePicture();

// // //     // Load image to crop into 4:3 exactly
// // //     final rawImage = img.decodeImage(await File(file.path).readAsBytes());
// // //     if (rawImage != null) {
// // //       final targetWidth = rawImage.width;
// // //       final targetHeight = (targetWidth / (4 / 3)).round();

// // //       // Crop from center
// // //       final yOffset = max(0, (rawImage.height - targetHeight) ~/ 2);
// // //       // final cropped = img.copyCrop(
// // //       //   rawImage,
// // //       //   0,
// // //       //   yOffset,
// // //       //   targetWidth,
// // //       //   targetHeight,
// // //       //    x: 0, y: 0, width: 0, height: 0,
// // //       // );

// // //       final directory = await getTemporaryDirectory();
// // //       final newPath = '${directory.path}/image_43.jpg';
// // //       // await File(newPath).writeAsBytes(img.encodeJpg(cropped));

// // //       debugPrint("Saved 4:3 image: $newPath");
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     if (!isReady || _controller == null) {
// // //       return const Scaffold(body: Center(child: CircularProgressIndicator()));
// // //     }

// // //     return Scaffold(
// // //       body: Center(
// // //         child: AspectRatio(
// // //           aspectRatio: 4 / 3, // Force preview in 4:3
// // //           child: CameraPreview(_controller!),
// // //         ),
// // //       ),
// // //       floatingActionButton: FloatingActionButton(
// // //         onPressed: _takePicture,
// // //         child: const Icon(Icons.camera),
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _controller?.dispose();
// // //     super.dispose();
// // //   }
// // // }

// // import 'dart:io';
// // import 'dart:math';
// // import 'package:camera/camera.dart';
// // import 'package:flutter/material.dart';
// // import 'package:image/image.dart' as img;

// // class Imagepickerscreen extends StatefulWidget {
// //   const Imagepickerscreen({Key? key}) : super(key: key);

// //   @override
// //   State<Imagepickerscreen> createState() => _ImagepickerscreenState();
// // }

// // class _ImagepickerscreenState extends State<Imagepickerscreen> {
// //   CameraController? _controller;
// //   List<CameraDescription>? cameras;
// //   bool isReady = false;
// //   File? _capturedImage;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initCamera();
// //   }

// //   Future<void> _initCamera() async {
// //     cameras = await availableCameras();
// //     _controller = CameraController(
// //       cameras!.first,
// //       ResolutionPreset.max, // Usually close to 4:3
// //       enableAudio: false,
// //     );
// //     await _controller!.initialize();
// //     setState(() {
// //       isReady = true;
// //     });
// //   }

// //   Future<void> _takePicture() async {
// //     if (!_controller!.value.isInitialized) return;

// //     final XFile file = await _controller!.takePicture();

// //     // Crop to exact 4:3 ratio
// //     final rawImage = img.decodeImage(await File(file.path).readAsBytes());
// //     if (rawImage != null) {
// //       final targetWidth = rawImage.width;
// //       final targetHeight = (targetWidth / (4 / 3)).round();
// //       final yOffset = max(0, (rawImage.height - targetHeight) ~/ 2);
// //       final cropped = img.copyCrop(
// //         rawImage,
// //         x: 0,
// //         y: yOffset,
// //         width: targetWidth,
// //         height: targetHeight,
// //       );

// //       final croppedFile = File(file.path)
// //         ..writeAsBytesSync(img.encodeJpg(cropped));

// //       setState(() {
// //         _capturedImage = croppedFile;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: _capturedImage != null
// //           ? Center(child: Image.file(_capturedImage!))
// //           : (!isReady || _controller == null)
// //           ? const Center(child: CircularProgressIndicator())
// //           : Column(
// //               children: [
// //                 AspectRatio(
// //                   aspectRatio: 4 / 3,
// //                   child: CameraPreview(_controller!),
// //                 ),
// //                 const SizedBox(height: 10),
// //                 ElevatedButton.icon(
// //                   onPressed: _takePicture,
// //                   icon: const Icon(Icons.camera),
// //                   label: const Text("Capture"),
// //                 ),
// //               ],
// //             ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _controller?.dispose();
// //     super.dispose();
// //   }
// // }

// import 'dart:io';
// import 'dart:math';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;

// class Imagepickerscreen extends StatefulWidget {
//   const Imagepickerscreen({Key? key}) : super(key: key);

//   @override
//   State<Imagepickerscreen> createState() => _ImagepickerscreenState();
// }

// class _ImagepickerscreenState extends State<Imagepickerscreen> {
//   CameraController? _controller;
//   List<CameraDescription>? cameras;
//   bool isCameraOpen = false;
//   bool isReady = false;
//   File? _capturedImage;

//   // Future<void> _initCamera() async {
//   //   cameras = await availableCameras();
//   //   _controller = CameraController(
//   //     cameras!.firstWhere(
//   //       (cam) => cam.lensDirection == CameraLensDirection.back,
//   //     ),
//   //     ResolutionPreset.max, // highest quality
//   //     enableAudio: false,
//   //   );
//   //   await _controller!.initialize();
//   //   setState(() {
//   //     isReady = true;
//   //     isCameraOpen = true;
//   //   });
//   // }

//   Future<void> _initCamera() async {
//     cameras = await availableCameras();
//     _controller = CameraController(
//       cameras!.firstWhere(
//         (cam) => cam.lensDirection == CameraLensDirection.back,
//       ),
//       ResolutionPreset.max,
//       enableAudio: false,
//     );
//     await _controller!.initialize();

//     // Set zoom level here
//     await _controller!.setZoomLevel(2);
//     double maxZoom = await _controller!.getMaxZoomLevel();
//     print("Max zoom: $maxZoom");

//     setState(() {
//       isReady = true;
//       isCameraOpen = true;
//     });
//   }

//   Future<void> _takePicture() async {
//     if (!_controller!.value.isInitialized) return;

//     final XFile file = await _controller!.takePicture();

//     // Crop to exact 4:3 ratio
//     final rawImage = img.decodeImage(await File(file.path).readAsBytes());
//     if (rawImage != null) {
//       final targetWidth = rawImage.width;
//       final targetHeight = (targetWidth / (4 / 3)).round();
//       final yOffset = max(0, (rawImage.height - targetHeight) ~/ 2);

//       final cropped = img.copyCrop(
//         rawImage,
//         x: 0,
//         y: yOffset,
//         width: targetWidth,
//         height: targetHeight,
//       );

//       final croppedFile = File(file.path)
//         ..writeAsBytesSync(img.encodeJpg(cropped, quality: 100));

//       setState(() {
//         _capturedImage = croppedFile;
//         isCameraOpen = false; // close camera
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _capturedImage != null && !isCameraOpen
//             ? Image.file(_capturedImage!)
//             : !isCameraOpen
//             ? ElevatedButton(
//                 onPressed: _initCamera,
//                 child: const Text("Open Camera"),
//               )
//             : (!isReady || _controller == null)
//             ? const CircularProgressIndicator()
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // AspectRatio(
//                   //   aspectRatio: 4 / 3,
//                   //   child: CameraPreview(_controller!),
//                   // ),
//                   AspectRatio(
//                     aspectRatio:
//                         _controller!.value.aspectRatio, // native aspect ratio
//                     child: CameraPreview(_controller!),
//                   ),
//                   const SizedBox(height: 10),
//                   ElevatedButton.icon(
//                     onPressed: _takePicture,
//                     icon: const Icon(Icons.camera),
//                     label: const Text("Capture"),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Imagepickerscreen extends StatefulWidget {
  const Imagepickerscreen({Key? key}) : super(key: key);

  @override
  State<Imagepickerscreen> createState() => _ImagepickerscreenState();
}

class _ImagepickerscreenState extends State<Imagepickerscreen> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool isCameraOpen = false;
  bool isReady = false;
  File? _capturedImage;

  Future<void> _initCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(
      cameras!.firstWhere(
        (cam) => cam.lensDirection == CameraLensDirection.back,
      ),
      ResolutionPreset.ultraHigh, // usually gives 4:3 on most devices
      enableAudio: false,
    );
    await _controller!.initialize();

    // Set zoom level here
    await _controller!.setZoomLevel(1.5);
    double maxZoom = await _controller!.getMaxZoomLevel();
    print("Max zoom: $maxZoom");

    setState(() {
      isReady = true;
      isCameraOpen = true;
    });
  }

  Future<void> _takePicture() async {
    if (!_controller!.value.isInitialized) return;

    final XFile file = await _controller!.takePicture();

    setState(() {
      _capturedImage = File(file.path); // No changes, raw image
      isCameraOpen = false;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _capturedImage != null && !isCameraOpen
            ? Image.file(_capturedImage!)
            : !isCameraOpen
            ? ElevatedButton(
                onPressed: _initCamera,
                child: const Text("Open Camera"),
              )
            : (!isReady || _controller == null)
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 3, // force preview to 4:3
                    child: CameraPreview(_controller!),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _takePicture,
                    icon: const Icon(Icons.camera),
                    label: const Text("Capture"),
                  ),
                ],
              ),
      ),
    );
  }
}
