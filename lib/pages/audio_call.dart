import 'dart:async';
import 'package:agora_flutter/pages/components/outgoing_call.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:agora_flutter/config/config.dart';

import '../models/models.dart';

class OutgoingCall extends StatefulWidget {
  const OutgoingCall({Key? key}) : super(key: key);

  @override
  _OutgoingCallState createState() => _OutgoingCallState();
}

class _OutgoingCallState extends State<OutgoingCall> {
  String channel = '';
  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  late RtcEngine agoraEngine; // Agora engine instance

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: appId));

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage(
              "Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

  void join() async {
    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: token,
      channelId: channel,
      options: options,
      uid: uid,
    );

    XCall call = XCall(
      from: 'OLHQL8STqGRcSq0X4Qn8',
      to: 'OLHQL8STqGRcSq0X4Qn8',
      channelName: channel,
      token: token,
      ids: ['OLHQL8STqGRcSq0X4Qn8', 'OLHQL8STqGRcSq0X4Qn8'],
      type: XCallType.audio,
      missed: false, // or true
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance.collection('Calls').add(call.toMap()).then((docRef) {
      logger.i('*****************************************************');
      logger.i('Document written with ID: ${docRef.id}');
      logger.i('*****************************************************');
    }).catchError((error) {
      logger.i('*****************************************************');
      logger.i('Error: $error');
      logger.i('*****************************************************');
    });
  }

  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }

  @override
  void initState() {
    channel = 'OLHQL8STqGRcSq0X4Qn8OLHQL8STqGRcSq0X4Qn8';
    super.initState();
    // Set up an instance of Agora engine
    setupVoiceSDKEngine();
  }

  // Clean up the resources when you leave
  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    super.dispose();
  }

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Call'),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () => {
              join(),
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OutgoingCallScreen(
                    onMute: () {
                      if (kDebugMode) {
                        print('Mute button pressed');
                      }
                    },
                    onHangUp: () => {
                      leave(),
                      Navigator.of(context).pop(),
                    },
                    onLoudSpeaker: () {
                      if (kDebugMode) {
                        print('Loud speaker button pressed');
                      }
                    },
                  ),
                ),
              ),
            },
          )
        ],
      ),
      body: const Center(
        child: Text("Agora Call"),
      ),
    );
  }

  Widget _status() {
    String statusText;

    if (!_isJoined) {
      statusText = 'Join a channel';
    } else if (_remoteUid == null) {
      statusText = 'Waiting for a remote user to join...';
    } else {
      statusText = 'Connected to remote user, uid:$_remoteUid';
    }
    return Text(
      statusText,
    );
  }
}
