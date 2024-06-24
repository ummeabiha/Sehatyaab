import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import 'package:flutter/material.dart';

class ZegoConnection {
  static void initializeZego() {
    try {
      final appId = int.parse(dotenv.env['ZEGO_APP_ID']!);
      final appSign = dotenv.env['ZEGO_APP_SIGN']!;
      ZegoExpressEngine.createEngine(appId, appSign, true, ZegoScenario.General,
          enablePlatformView: true);
      debugPrint('Zego initialized successfully.');
    } catch (e) {
      debugPrint('Error initializing Zego: $e');
    }
  }

  static void loginRoom(String roomID, String userID, String userName) {
    ZegoUser user = ZegoUser(userID, userName);
    ZegoExpressEngine.instance.loginRoom(roomID, user);
    debugPrint('Attempting to login to room: $roomID');
  }

  static void startPublishingStream(String streamID) {
    ZegoExpressEngine.instance.startPublishingStream(streamID);
    debugPrint('Attempting to start publishing stream: $streamID');
  }

  static void startPlayingStream(String streamID) {
    ZegoExpressEngine.instance.startPlayingStream(streamID);
    debugPrint('Attempting to start playing stream: $streamID');
  }

  static void handleRoomStateUpdates() {
    ZegoExpressEngine.onRoomStateUpdate =
        (roomID, state, errorCode, extendedData) {
      debugPrint(
          'Room state update - roomID: $roomID, state: $state, errorCode: $errorCode');
     
    };
  }

  static void handleStreamStateUpdates() {
    ZegoExpressEngine.onPublisherStateUpdate =
        (streamID, state, errorCode, extendedData) {
      debugPrint(
          'Publisher state update - streamID: $streamID, state: $state, errorCode: $errorCode');
      
    };

    ZegoExpressEngine.onPlayerStateUpdate =
        (streamID, state, errorCode, extendedData) {
      debugPrint(
          'Player state update - streamID: $streamID, state: $state, errorCode: $errorCode');
      
    };
  }
}
