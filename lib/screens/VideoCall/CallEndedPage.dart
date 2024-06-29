import 'package:flutter/material.dart';

import 'VideoCall.dart';

class CallEndedPage extends StatelessWidget {
  final String userID;
  final String userName;

  const CallEndedPage(
      {super.key, required this.userID, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Ended'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('The call has ended.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the video call screen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        VideoCall(userID: userID, userName: userName),
                  ),
                );
              },
              child: Text('Rejoin Call'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to suggestions or feedback page
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SuggestionsPage(),
                  ),
                );
              },
              child: Text('Give Suggestions'),
            ),
          ],
        ),
      ),
    );
  }
}

class SuggestionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suggestions'),
      ),
      body: Center(
        child: Text('Suggestions form goes here.'),
      ),
    );
  }
}
