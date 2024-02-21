import 'package:flutter/material.dart';
import 'package:roboli_site/helpers/constants.dart';
import 'package:roboli_site/pages/about_page/large_layout.dart';
import 'package:roboli_site/pages/about_page/small_layout.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (size.width > screenWBreakpoint) {
      return const LargeLayout();
    } else {
      return const SmallLayout();
    }
  }
}
