import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roboli_site/helpers/constants.dart';

class SkillsDisplay extends StatefulWidget {
  const SkillsDisplay({super.key});

  @override
  State<SkillsDisplay> createState() => _SkillsDisplayState();
}

class _SkillsDisplayState extends State<SkillsDisplay> {
  int stack = 0;

  void changeSkill(int index) {
    setState(() {
      stack = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: stack == 0 ? BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: 40,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ) : null,
              child: IconButton(
                onPressed: () => changeSkill(0),
                icon: SizedBox(
                  width: 140,
                  height: 140,
                  child: SvgPicture.asset('assets/icons/clojure-dark-green-icon.svg')
                ),
              ),
            ),
            Container(
              decoration: stack == 1 ? BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: 40,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ) : null,
              child: IconButton(
                onPressed: () => changeSkill(1),
                icon: const FlutterLogo(size: 120,),
              ),
            ),
            Container(
              decoration: stack == 2 ? BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: 40,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ) : null,
              child: IconButton(
                onPressed: () => changeSkill(2),
                icon: SizedBox(
                  width: 120,
                  height: 120,
                  child: SvgPicture.asset('assets/icons/Unofficial_JavaScript_logo_2.svg')
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Text(
              stack == 0 ? myClojure : (stack == 1) ? myDart : myJS,
              key: ValueKey(stack),
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
