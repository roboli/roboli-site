import 'package:flutter/material.dart';
import 'package:roboli_site/helpers/constants.dart';
import 'package:roboli_site/pages/about_page/skills_display.dart';

class SmallLayout extends StatefulWidget {
  const SmallLayout({super.key});

  @override
  State<SmallLayout> createState() => _SmallLayoutState();
}

class _SmallLayoutState extends State<SmallLayout> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        controller: _controller,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _controller,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: const Column(
              children: [
                Text(
                  'About Me',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  aboutMe,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Text(
                  'My Stack',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SkillsDisplay(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
