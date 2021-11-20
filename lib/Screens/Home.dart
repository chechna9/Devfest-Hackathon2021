import 'package:flutter/material.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // instante spesh
  VoiceController? _voiceController;
  String voiceinit =
      "on the bottum of the screen, tap twice to  acesse the smart system , hold for 5 seconds  to request a volunteer ";
  String onDoubleTabVoice = "u are acesse to the smart system sucessfully";
  String onLongPressVoice =
      "please wait some seconds, we are looking for a volunteer ";
  String onTapVoice =
      "please tap twice to  acesse the smart system , hold for 5 seconds  to request a volunteer ";

  // play spesh
  _playVoice(script) {
    _voiceController!.init().then((_) {
      _voiceController!.speak(
        script,
        VoiceControllerOptions(),
      );
    });
  }

  // ontap function

  @override
  void initState() {
    _voiceController = FlutterTextToSpeech.instance.voiceController();
    _playVoice(voiceinit);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _voiceController!.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFF1597E5),
            flexibleSpace: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                            fontSize: 24)),
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
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 0, left: 15, right: 15, bottom: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Description",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: Color(0xFF1597E5)),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 30),
                            child: Text(
                              "brEYEn, or Brain Eye is a solution that assists blind and partially blind people to work in public places safely at any time",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Image.asset('images/homeDesc.png'),
                          SizedBox(
                            height: 30,
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/login'),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              decoration: BoxDecoration(
                                  color: Color(0xFF1597E5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                'Volunteer Space',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: GestureDetector(
                    onDoubleTap: () {
                      _playVoice(onDoubleTabVoice);
                      Navigator.pushNamed(context, '/camera');
                    },
                    onLongPress: () {
                      _playVoice(onLongPressVoice);
                      Navigator.pushNamed(context, '/loading');
                    },
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      child: Image(
                        image: AssetImage("images/clickFinger.png"),
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 0, color: Colors.white),
                          ),
                          color: Color(0xFF1597E5)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
