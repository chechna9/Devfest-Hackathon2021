import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class RealTime extends StatefulWidget {
  final List<CameraDescription>? cameras;
  RealTime({Key? key, required this.cameras}) : super(key: key);

  @override
  _RealTimeState createState() => _RealTimeState();
}

class _RealTimeState extends State<RealTime> {
  CameraController? controller;

  @override
  void initState() {
    super.initState();

    controller = CameraController(widget.cameras![0], ResolutionPreset.max);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: Text('brAIns',
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        elevation: 0,
      ),
      body: CameraPreview(controller!),
    );
  }
}
