import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleTile extends StatelessWidget {
  final String name;
  final Uri uri;

  const ArticleTile(
      {super.key,
      required this.name,
      required this.uri
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
          child: InkWell(
            onTap: () => launchUrl(uri),
            child: SvgPicture.asset('assets/svgs/icons8-medium.svg'),
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          )
        ),
      ],
    );
  }
}
