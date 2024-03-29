import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectTile extends StatelessWidget {
  final String name;
  final String language;
  final String description;
  final Uri uri;

  const ProjectTile(
      {super.key,
      required this.name,
      required this.language,
      required this.description,
      required this.uri
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => launchUrl(uri),
          child: SizedBox(
            height: 50,
            child: SvgPicture.asset('assets/svgs/github-mark-white.svg'),
          ),
        ),
        const SizedBox(width: 5,),
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                language,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 15),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(description),
            ],
          )
        ),
      ],
    );
  }
}
