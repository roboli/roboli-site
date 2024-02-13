import 'package:flutter/material.dart';
import 'package:roboli_site/helpers/constants.dart';
import 'package:roboli_site/pages/about_page/large_layout.dart';
import 'package:roboli_site/pages/about_page/small_layout.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > screenBreakpoint + 300) {
          return const LargeLayout();
        } else {
          return const SmallLayout();
        }
    });
  }
}
