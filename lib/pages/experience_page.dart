import 'package:flutter/material.dart';
import 'package:roboli_site/helpers/constants.dart';
import 'package:roboli_site/pages/experience_page/tile.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Center(
              child: Text(
                'My Experience',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 75,),
            Expanded(
              child: ListView(
                children: [
                  Tile(
                    role: 'Integration Engineer',
                    client: 'Left Hook',
                    dateRange: 'Feb 2023 - Nov 2023',
                    location: 'Durham, New Hampshire, USA · Remote',
                    description: jobLH,
                    logo: const AspectRatio(
                      aspectRatio: 1.0,
                      child: FlutterLogo(),
                    ),
                  ),
                  Tile(
                    role: 'Full Stack Engineer',
                    client: 'Pay Justice Ltd',
                    dateRange: 'Nov 2017 - Nov 2022',
                    location: 'Manchester, UK · Remote',
                    description: jobPJ,
                    logo: const AspectRatio(
                      aspectRatio: 1.0,
                      child: FlutterLogo(),
                    ),
                  ),
                  Tile(
                    role: 'Full Stack Developer',
                    client: 'Flow XO',
                    dateRange: 'Jun 2015 - Dec 2016',
                    location: 'Manchester, UK · Remote',
                    description: jobFXO,
                    logo: const AspectRatio(
                      aspectRatio: 1.0,
                      child: FlutterLogo(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
