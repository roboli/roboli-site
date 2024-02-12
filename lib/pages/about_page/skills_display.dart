import 'package:flutter/material.dart';
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
            OutlinedButton(
              onPressed: () => changeSkill(0),
              child: const Text('Clojure'),
            ),
            OutlinedButton(
              onPressed: () => changeSkill(1),
              child: const Text('Dart'),
            ),
            OutlinedButton(
              onPressed: () => changeSkill(2),
              child: const Text('JS')
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(50),
          child: Builder(builder: (BuildContext context) {
            switch (skill) {
              case 0:
                return const Text(myClojure);

              case 1:
                return const Text(myDart);

              default:
                return const Text(myJS);
            }
          }),
        )
      ],
    );
  }
}
