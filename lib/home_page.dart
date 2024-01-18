import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage('assets/roberto.png'),
                  fit: BoxFit.fill
                ),
              ),
            ),
            const SizedBox(height: 100,),
            Text(
              'Hi there! My name is Roberto Oliveros and welcome to my site.',
              style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
            ),
          ],
        )
      ),
    );
  }
}

