import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                padding: const EdgeInsets.symmetric(horizontal: 100,),
                children: [
                  Tile(
                    role: 'Integration Engineer',
                    client: 'Left Hook',
                    dateRange: 'Feb 2023 - Nov 2023',
                    location: 'Durham, New Hampshire, USA · Remote',
                    description: jobLH,
                    logo: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logos/lefthookdigital.jpeg'),
                          fit: BoxFit.fill
                        ),
                      ),
                    ),
                  ),
                  Tile(
                    role: 'Full Stack Engineer',
                    client: 'Pay Justice Ltd',
                    dateRange: 'Nov 2017 - Nov 2022',
                    location: 'Manchester, UK · Remote',
                    description: jobPJ,
                    logo: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logos/PayJusticeLogo.png'),
                          fit: BoxFit.fill
                        ),
                      ),
                    ),
                  ),
                  Tile(
                    role: 'Full Stack Developer',
                    client: 'Flow XO',
                    dateRange: 'Jun 2015 - Dec 2016',
                    location: 'Manchester, UK · Remote',
                    description: jobFXO,
                    logo: Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(5.0),
                      color: Colors.white,
                      child: SvgPicture.asset('assets/logos/flowXO-colour.svg'),
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
