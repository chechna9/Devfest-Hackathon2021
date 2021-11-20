import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io';

double threshold = 0.6;
var objectOptions =
    ObjectDetectorOptions(classifyObjects: true, trackMutipleObjects: true);
var imgLablOptions = ImageLabelerOptions();
final objectDetector = GoogleMlKit.vision.objectDetector(objectOptions);
final imageLabeler = GoogleMlKit.vision.imageLabeler(imgLablOptions);

class RealTime extends StatefulWidget {
  final List<CameraDescription>? cameras;
  RealTime({Key? key, required this.cameras}) : super(key: key);

  @override
  _RealTimeState createState() => _RealTimeState();
}

class _RealTimeState extends State<RealTime> {
  DateTime then = DateTime.now();
  Stopwatch timer = Stopwatch();
  String labels = '';
  CameraController? controller;
  CameraImage? cameraImage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer.start();
    loadCamera();
  }

  void loadCamera() {
    controller = CameraController(widget.cameras![0], ResolutionPreset.high,
        enableAudio: false);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }

      setState(() {
        then = DateTime.now();
        controller!.startImageStream((imageStream) {
          // if ((DateTime.now().second - then.second > 1) ||
          //     (DateTime.now().second - then.second == -59))
          if (timer.elapsedMilliseconds > 1000) {
            timer.reset();
            cameraImage = imageStream;
            print("sii");
            runModel();
          }
        });
      });
    });
  }

  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  InputImage prepareInput() {
    final camera = widget.cameras![0]; // your camera instance

    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in cameraImage!.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(cameraImage!.width.toDouble(), cameraImage!.height.toDouble());

    final InputImageRotation imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final InputImageFormat inputImageFormat =
        InputImageFormatMethods.fromRawValue(cameraImage!.format.raw) ??
            InputImageFormat.NV21;

    final planeData = cameraImage!.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    return InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
  }

  runModel() async {
    if (cameraImage != null) {
      // List<DetectedObject> objects =
      //     await objectDetector.processImage(prepareInput());
      List<ImageLabel> objects =
          await imageLabeler.processImage(prepareInput());
      String _labels = '';
      // for (DetectedObject obj in objects) {
      //   for (Label label in obj.getLabels()) {
      //     _labels += '${label.getText()}';
      //     print(_labels);
      //   }
      // }
      for (ImageLabel label in objects) {
        if (label.confidence > threshold) _labels += '${label.label}\n';

        print(_labels);
        print(label.confidence);
      }
      if (_labels != labels && _labels.isNotEmpty)
        setState(() {
          labels = _labels;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5C7AEA),
        title: Text('brAIns',
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xff5C7AEA),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(50),
            child: CameraPreview(controller!),
          ),
          Container(
            child: Text(
              '$labels',
              style: TextStyle(
                color: Colors.white,
              ),
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}
