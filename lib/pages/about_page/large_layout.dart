import 'package:flutter/material.dart';
import 'package:roboli_site/helpers/constants.dart';
import 'package:roboli_site/pages/about_page/skills_display.dart';

class LargeLayout extends StatelessWidget {
  const LargeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1500),
          child: const Padding(
            padding: EdgeInsets.all(50),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
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
                ),
                SizedBox(width: 100,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'My Stack',
                          style: TextStyle(fontSize: 20,),
                        ),
                        SizedBox(height: 50,),
                        SkillsDisplay(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
