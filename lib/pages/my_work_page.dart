import 'package:flutter/material.dart';
import 'package:roboli_site/helpers/constants.dart';
import 'package:roboli_site/pages/my_work_page/project_tile.dart';
import 'package:url_launcher/url_launcher.dart';


class MyWorkPage extends StatelessWidget {
  const MyWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Center(
              child: Text(
                'My Work',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 75,),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 100,),
                children: [
                  const Text(
                    'Projects',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 25,),
                  ProjectTile(
                    name: 'pdf-2-images',
                    language: 'Clojure',
                    description: pdf2Images,
                    uri: Uri.https('github.com', 'roboli/pdf-2-images'),
                  ),
                  ProjectTile(
                    name: 'balloon',
                    language: 'Clojure',
                    description: balloon,
                    uri: Uri.https('github.com', 'roboli/balloon'),
                  ),
                  ProjectTile(
                    name: 'Clerk',
                    language: 'Clojure',
                    description: clerk,
                    uri: Uri.https('github.com', 'roboli/clerk'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
