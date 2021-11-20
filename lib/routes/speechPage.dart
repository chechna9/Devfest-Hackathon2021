import 'package:flutter/material.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';


class SpeechPage extends StatefulWidget {
  SpeechPage({Key ?key, this.title}) : super(key: key);

  final String ?title;

  @override
  _SpeechPageState createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  VoiceController ?_voiceController;
  TextEditingController ?_textController;

  String text =
      'This is an example tutorial of using text to speech in a flutter application! The example is provided on fluttercentral website.';

  @override
  void initState() {
    _voiceController = FlutterTextToSpeech.instance.voiceController();
    _textController = TextEditingController();
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

  _stopVoice() {
    _voiceController!.stop();
  }

  _onUpdateText(){
    setState(){
      text = "Alert! ${_textController!.value}, behind you.";
    }
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
            TextField(controller: _textController),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(onPressed: _onUpdateText,color: Colors.red, child: Text('Submit')),
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
