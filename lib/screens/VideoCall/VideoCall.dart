// import 'package:flutter/material.dart';
// import 'package:zego_express_engine/zego_express_engine.dart';
// import '../../services/ZegoConnection.dart';

// class VideoCall extends StatefulWidget {
//   final String roomID;
//   final String userID;
//   final String userName;

//   const VideoCall({
//     super.key,
//     required this.roomID,
//     required this.userID,
//     required this.userName,
//   });

//   @override
//   _VideoCallState createState() => _VideoCallState();
// }

// class _VideoCallState extends State<VideoCall> {
//   @override
//   void initState() {
//     super.initState();
//     ZegoConnection.initializeZego();
//     ZegoConnection.handleRoomStateUpdates();
//     ZegoConnection.handleStreamStateUpdates();
//   }

//   void startCall() {
//     String roomID = widget.roomID;
//     String userID = widget.userID;
//     String userName = widget.userName;
//     ZegoConnection.loginRoom(roomID, userID, userName);
//   }

//   void endCall() {
//     ZegoExpressEngine.instance.logoutRoom(widget.roomID);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Video Call')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: startCall,
//               child: Text('Start Call'),
//             ),
//             ElevatedButton(
//               onPressed: endCall,
//               child: const Text('End Call'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCall extends StatefulWidget {
  final String userID;
  final String userName;

  const VideoCall({
    super.key,
    required this.userID,
    required this.userName,
  });

  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  final appId = int.parse(dotenv.env['ZEGO_APP_ID']!);
  final appSign = dotenv.env['ZEGO_APP_SIGN']!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ZegoUIKitPrebuiltCall(
      appID: appId,
      appSign: appSign,
      callID: widget.userID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
      userID: widget.userID,
      userName: widget.userName,
    )));
  }
}
