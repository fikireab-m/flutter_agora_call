import 'package:agora_flutter/pages/audio_call.dart';
import 'package:agora_flutter/pages/video_call.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      const MaterialApp(
        home: Home(),
      ),
    );

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton(
                onPressed: (() => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OutgoingCall()))),
                child: const Text("Voice call")),
            ElevatedButton(
                onPressed: (() => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const VideoCall()))),
                child: const Text("video call")),
          ],
        ),
      ),
    );
  }
}
