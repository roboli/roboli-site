import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roboli_site/helpers/constants.dart';

class SkillsDisplay extends StatefulWidget {
  const SkillsDisplay({super.key});

  @override
  State<SkillsDisplay> createState() => _SkillsDisplayState();
}

class _SkillsDisplayState extends State<SkillsDisplay> {
  String stack = myClojure;

  void changeSkill(int index) {
    var text = '';

    switch (index) {
      case 0:
        text = myClojure;
        break;

      case 1:
        text = myDart;
        break;

      default:
        text = myJS;
    }

    setState(() {
      stack = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () => changeSkill(0),
              icon: SizedBox(
                width: 180,
                height: 180,
                child: SvgPicture.asset('assets/icons/clojure-dark-green-icon.svg')
              ),
            ),
            IconButton(
              onPressed: () => changeSkill(1),
              icon: const FlutterLogo(size: 120,),
            ),
            IconButton(
              onPressed: () => changeSkill(2),
              icon: SizedBox(
                width: 120,
                height: 120,
                child: SvgPicture.asset('assets/icons/Unofficial_JavaScript_logo_2.svg')
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Text(
              stack,
              key: ValueKey<String>(stack),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey
              ),
            ),
          ),
        )
      ],
    );
  }
}
