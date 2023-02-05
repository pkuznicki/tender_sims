import 'package:flutter/material.dart';

class thankyouWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tender Sims Admin Screen'),
        ),
        body: Column(
          children: [
            Container(
              height: 50,
            ),
            Text(
              'Done! You may close this tab. :)',
              style: TextStyle(fontSize: 40),
            )
          ],
        ));
  }
}
