import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sehatyaab/screens/VideoCall/CallEndedPage.dart';
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
        child: Stack(
          children: [
            ZegoUIKitPrebuiltCall(
              appID: appId,
              appSign: appSign,
              callID: widget.userID,
              config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
              userID: widget.userID,
              userName: widget.userName,
            ),
            Positioned(
              top: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => CallEndedPage(
                        userID: widget.userID,
                        userName: widget.userName,
                      ),
                    ),
                  );
                },
                child: Icon(Icons.call_end),
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
