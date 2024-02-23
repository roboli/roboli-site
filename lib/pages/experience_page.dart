import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:roboli_site/helpers/constants.dart';
import 'package:roboli_site/pages/experience_page/tile.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return LayoutBuilder(builder: (context, constraints) {
      final size =
          width > screenWBreakpoint ? 100.0 : min(100.0, constraints.maxWidth * 0.15);

      return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(width > screenWBreakpoint ? 50 : 20),
          child: Column(
            children: [
              Center(
                child: Text(
                  'My Experience',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: width > screenWBreakpoint ? 30 : 25,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: ListView(
                    children: [
                      Tile(
                        role: 'Integration Engineer',
                        client: 'Left Hook',
                        dateRange: 'Feb 2023 - Nov 2023',
                        location: 'Durham, New Hampshire, USA · Remote',
                        description: jobLH,
                        logo: SizedBox(
                          height: size,
                          width: size,
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/lefthookdigital.jpeg'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Tile(
                        role: 'Full Stack Engineer',
                        client: 'Pay Justice Ltd',
                        dateRange: 'Nov 2017 - Nov 2022',
                        location: 'Manchester, UK · Remote',
                        description: jobPJ,
                        logo: Container(
                          height: size,
                          width: size,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/PayJusticeLogo.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Tile(
                        role: 'Full Stack Developer',
                        client: 'Flow XO',
                        dateRange: 'Jun 2015 - Dec 2016',
                        location: 'Manchester, UK · Remote',
                        description: jobFXO,
                        logo: Container(
                          height: size,
                          width: size,
                          padding: const EdgeInsets.all(5.0),
                          color: Colors.white,
                          child:
                              SvgPicture.asset('assets/svgs/flowXO-colour.svg'),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'For a complete list of my experience, please download my CV:',
                            style: TextStyle(fontSize: 15),
                          ),
                          InkWell(
                            onTap: () => launchUrl(Uri.https('d2zi4kn7tjo99f.cloudfront.net', '/Resume-Roberto-Oliveros.pdf')),
                            child: Text(
                              'Here',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue
                              ),
                            ),
                          ),
                        ]
                      ),
                      const SizedBox(height: 20,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
