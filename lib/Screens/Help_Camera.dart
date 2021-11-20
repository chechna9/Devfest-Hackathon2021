import 'dart:math';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';

import 'package:brainsapp/main.dart';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io';
import 'package:collection/collection.dart';

double threshold = 0.7;
var objectOptions =
    ObjectDetectorOptions(classifyObjects: true, trackMutipleObjects: true);
var imgLablOptions = ImageLabelerOptions();
final objectDetector = GoogleMlKit.vision.objectDetector(objectOptions);
final imageLabeler = GoogleMlKit.vision.imageLabeler(imgLablOptions);

class HelpCamera extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const HelpCamera({required this.cameras});

  @override
  State<HelpCamera> createState() => _HelpCameraState();
}

class _HelpCameraState extends State<HelpCamera> {
  late TextEditingController _controller;
  VoiceController? _voiceController;
  Stopwatch timer = Stopwatch();
  Stopwatch timer2 = Stopwatch();
  List<String> labels = [];
  CameraController? controller;
  CameraImage? cameraImage;

  // play spesh
  _playVoice(script) {
    _voiceController!.init().then((_) {
      _voiceController!.speak(
        script,
        VoiceControllerOptions(),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer.start();
    timer2.start();
    loadCamera();
    _voiceController = FlutterTextToSpeech.instance.voiceController();
  }

  void loadCamera() {
    controller = CameraController(widget.cameras![0], ResolutionPreset.high,
        enableAudio: false);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }

      setState(() {
        controller!.startImageStream((imageStream) {
          // if ((DateTime.now().second - then.second > 1) ||
          //     (DateTime.now().second - then.second == -59))
          if (timer.elapsedMilliseconds > 1000) {
            timer.reset();
            cameraImage = imageStream;
            runModel();
            if (timer2.elapsedMilliseconds > 5000) {
              timer2.reset();
              String labelVoice = "Warning,there is";
              for (int i = 0; i < min(3, labels.length); i++) {
                labelVoice += labels[i] + "and ";
              }
              labelVoice.substring(0, labelVoice.length - 4);

              print(labelVoice);
              labels.isNotEmpty
                  ? _playVoice(labelVoice)
                  : _playVoice("the street is safe");
            }
          }
        });
      });
    });
  }

  void dispose() {
    controller?.dispose();
    super.dispose();
    _voiceController!.stop();
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
      List<String> _labels = [];
      // for (DetectedObject obj in objects) {
      //   for (Label label in obj.getLabels()) {
      //     _labels += '${label.getText()}';
      //     print(_labels);
      //   }
      // }
      for (ImageLabel label in objects) {
        if (label.confidence > threshold) _labels.add(label.label);
      }
      if (!ListEquality().equals(labels, _labels) && _labels.isNotEmpty)
        setState(() {
          labels = _labels;
        });
      if (_labels.isEmpty)
        setState(() {
          labels = [];
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Color(0xFF1597E5),
            flexibleSpace: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Image(
                        image: AssetImage("images/DF-logo-dark.png"),
                        width: 60,
                        height: 60,
                      ),
                    ),
                    Text("BrEYEn",
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w600,
                            fontSize: 26)),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Center(
            child: Container(
                color: Color(0xFF1597E5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 0, left: 15, right: 15, bottom: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Text("BrEYEn ",
                                    style: TextStyle(
                                        color: Color(0xFF1597E5),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24)),
                                SizedBox(
                                  height: 35,
                                ),
                                // camera photo
                                Container(
                                  child: CameraPreview(controller!),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              width: 2,
                                              color: Color(0xFF1597E5)),
                                          left: BorderSide(
                                              width: 2,
                                              color: Color(0xFF1597E5)),
                                          right: BorderSide(
                                              width: 2,
                                              color: Color(0xFF1597E5)),
                                          bottom: BorderSide(
                                              width: 2,
                                              color: Color(0xFF1597E5))),
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 270,
                                  width: 270,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: 250,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Item detected .. ",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: min(4, labels.length),
                                    itemBuilder: (BuildContext context, ind) {
                                      return Column(
                                        children: [
                                          LabledItem(
                                            output: labels[ind],
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]))),
      ),
    );
  }
}

class LabledItem extends StatelessWidget {
  final String output;

  const LabledItem({Key? key, required this.output}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border(
            top: BorderSide(width: 2, color: Color(0xFF1597E5)),
            left: BorderSide(width: 2, color: Color(0xFF1597E5)),
            right: BorderSide(width: 2, color: Color(0xFF1597E5)),
            bottom: BorderSide(
              width: 2,
              color: Color(0xFF1597E5),
            )),
      ),
      child: Text(
        output,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}
