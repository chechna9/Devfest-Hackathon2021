import 'package:flutter/material.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';


class Speesh extends StatefulWidget {
  Speesh({Key ?key, this.title}) : super(key: key);

  final String ?title;

  @override
  _SpeeshState createState() => _SpeeshState();
}

class _SpeeshState extends State<Speesh> {

  VoiceController ?_voiceController;
  String text =
      'This is an example tutorial of using text to speech in a flutter application! The example is provided on fluttercentral website.';

  @override
  void initState() {
    _voiceController = FlutterTextToSpeech.instance.voiceController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _voiceController!.stop();
  }

  _playVoice() {
    _voiceController!.init().then((_) {
      _voiceController!.speak(
        text,
        VoiceControllerOptions(),
      );
    });
  }

  _speechAlertObject(String classe_to_alert){
    setState((){
      text = "Alert! $classe_to_alert, behind you.";
    }
    );
  }

  _stopVoice() {
    _voiceController!.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: _playVoice,
              color: Colors.blue,
              child: Text('Play Voice'),
            ),
            RaisedButton(
              onPressed: _stopVoice,
              color: Colors.blue,
              child: Text('Stop Voice'),
            ),
          ],
        ),
      ),
    );
  }
}
