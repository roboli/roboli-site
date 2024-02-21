import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roboli_site/helpers/constants.dart';
import 'package:roboli_site/pages/experience_page/tile.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(size.width > screenWBreakpoint ? 30 : 5),
        child: Column(
          children: [
            Center(
              child: Text(
                'My Experience',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width > screenWBreakpoint ? 30 : 25,
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
                    logo: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/lefthookdigital.jpeg'),
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
                          image: AssetImage('assets/images/PayJusticeLogo.png'),
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
                      child: SvgPicture.asset('assets/svgs/flowXO-colour.svg'),
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
