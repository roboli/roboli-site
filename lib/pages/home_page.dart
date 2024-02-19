import 'package:flutter/material.dart';
import 'package:roboli_site/helpers/constants.dart';
import 'package:roboli_site/pages/home_page/large_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > screenWBreakpoint) {
          return const LargeLayout();
        } else {
          return const Placeholder();
        }
    });
  }
}
