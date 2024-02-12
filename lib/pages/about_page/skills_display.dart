import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roboli_site/helpers/constants.dart';

class SkillsDisplay extends StatefulWidget {
  const SkillsDisplay({super.key});

  @override
  State<SkillsDisplay> createState() => _SkillsDisplayState();
}

class _SkillsDisplayState extends State<SkillsDisplay> {
  int skill = 0;

  void changeSkill(int index) {
    setState(() {
      skill = index;
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
              icon: SvgPicture.asset('assets/icons/clojure-dark-green-icon.svg'),
            ),
            IconButton(
              onPressed: () => changeSkill(1),
              icon: const FlutterLogo(size: 120,)
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
          padding: const EdgeInsets.all(50),
          child: Builder(builder: (BuildContext context) {
            switch (skill) {
              case 0:
                return const Text(
                  myClojure,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                );

              case 1:
                return const Text(
                  myDart,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                );

              default:
                return const Text(
                  myJS,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey
                  ),
                );
            }
          }),
        )
      ],
    );
  }
}
