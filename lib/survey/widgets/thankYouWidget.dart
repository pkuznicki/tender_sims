import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              height: 20,
            ),
            Text(
              'Done! You may close this tab. :)',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 50,
            ),
            Container(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  context.go('/');
                },
                child: Text('Go back'),
              ),
            ),
          ],
        ));
  }
}
