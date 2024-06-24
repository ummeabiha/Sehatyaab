import 'package:flutter/material.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import '../../services/ZegoConnection.dart';

class VideoCall extends StatefulWidget {
  final String roomID;
  final String userID;
  final String userName;

  const VideoCall({
    Key? key,
    required this.roomID,
    required this.userID,
    required this.userName,
  }) : super(key: key);

  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  @override
  void initState() {
    super.initState();
    ZegoConnection.initializeZego();
    ZegoConnection.handleRoomStateUpdates();
    ZegoConnection.handleStreamStateUpdates();
  }

  void startCall() {
    String roomID = widget.roomID; // Example room ID
    String userID = widget.userID; // Example user ID
    String userName = widget.userName; // Example user name
    ZegoConnection.loginRoom(roomID, userID, userName);
  }

  void endCall() {
    ZegoExpressEngine.instance.logoutRoom(widget.roomID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Call')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: startCall,
              child: Text('Start Call'),
            ),
            ElevatedButton(
              onPressed: endCall,
              child: Text('End Call'),
            ),
          ],
        ),
      ),
    );
  }
}
