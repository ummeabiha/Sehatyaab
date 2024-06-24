import 'package:flutter/material.dart';

import 'VideoCall.dart';

class CallEndedPage extends StatelessWidget {
  final String roomID;

  CallEndedPage({required this.roomID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Call Ended")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("The call has ended."),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoCall(
                          roomID: roomID, userID: "user1", userName: "User 1")),
                );
              },
              child: Text("Rejoin Call"),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Suggestions",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save suggestions logic here
              },
              child: Text("Submit Suggestions"),
            ),
          ],
        ),
      ),
    );
  }
}
