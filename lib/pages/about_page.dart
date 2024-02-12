import 'package:flutter/material.dart';
import 'package:roboli_site/helpers/constants.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Padding(
        padding: EdgeInsets.all(50),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'About Me',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 50,),
                  Text(
                    aboutMe,
                    style: TextStyle(fontSize: 15,),
                  ),
                ],
              ),
            ),
            SizedBox(width: 100,),
            Expanded(
              child: Column(
                children: [
                  Text('Skills'),
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Clojure'),
                      Text('Dart'),
                      Text('JS')
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
