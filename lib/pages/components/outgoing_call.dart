import 'package:flutter/material.dart';

class OutgoingCallScreen extends StatefulWidget {
  final VoidCallback onMute;
  final VoidCallback onHangUp;
  final VoidCallback onLoudSpeaker;

  const OutgoingCallScreen({
    super.key,
    required this.onMute,
    required this.onHangUp,
    required this.onLoudSpeaker,
  });

  @override
  State<OutgoingCallScreen> createState() => _OutgoingCallScreenState();
}

class _OutgoingCallScreenState extends State<OutgoingCallScreen> {
  bool isMute = false;
  bool isLoud = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://via.placeholder.com/150'),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50),
              Text(
                'Calling...',
                style: TextStyle(color: Colors.grey, fontSize: 30),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150'),
                  ),
                  SizedBox(width: 18.0),
                  Text(
                    'John Doe',
                    style: TextStyle(color: Colors.grey, fontSize: 24),
                  ),
                ],
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () => {
                      widget.onMute,
                      setState(
                        () {
                          isMute = !isMute;
                        },
                      )
                    },
                    backgroundColor: isMute ? Colors.white : Colors.grey,
                    child: const Icon(Icons.mic_off),
                  ),
                  FloatingActionButton(
                    onPressed: widget.onHangUp,
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.call_end),
                  ),
                  FloatingActionButton(
                    onPressed: () => {
                      widget.onLoudSpeaker,
                      setState(
                        () {
                          isLoud = !isLoud;
                        },
                      )
                    },
                    backgroundColor: isLoud ? Colors.white : Colors.grey,
                    child: const Icon(Icons.volume_up),
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
