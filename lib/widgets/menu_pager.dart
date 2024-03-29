import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roboli_site/helpers/constants.dart';
import 'package:roboli_site/pages/about_page.dart';
import 'package:roboli_site/pages/contact_page.dart';
import 'package:roboli_site/pages/experience_page.dart';
import 'package:roboli_site/pages/home_page.dart';
import 'package:roboli_site/pages/my_work_page.dart';

class MenuPager extends StatefulWidget {
  final String page;
  final int index;

  MenuPager({super.key, required this.page}) : index = pages[page] ?? 0;

  @override
  State<MenuPager> createState() => _MenuPagerState();
}

class _MenuPagerState extends State<MenuPager>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  bool isInTransition = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )
      ..drive(Tween<double>(begin: 0, end: 1))
      ..forward();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if router changed page
    if (_pageController.page!.round() != widget.index) {
      animateTransition(_pageController.page as int, widget.index);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: _animationController,
          child: ColoredBox(
            color: Colors.black87,
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int index) {
                      updateRouter(index);
                    },
                    children: const [
                      HomePage(),
                      AboutPage(),
                      ExperiencePage(),
                      MyWorkPage(),
                      ContactPage(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: DotsIndicator(
                    dotsCount: 5,
                    position: widget.index,
                    onTap: (index) {
                      updateRouter(index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateRouter(int index) {
    // Do not update router if page transition is happening
    if (isInTransition) return;

    String page = 'home';

    switch (index) {
      case 0:
        page = 'home';
        break;

      case 1:
        page = 'about';
        break;

      case 2:
        page = 'experience';
        break;

      case 3:
        page = 'work';
        break;

      case 4:
        page = 'contact';
        break;
    }

    GoRouter.of(context).goNamed('page', pathParameters: {'page': page});
  }

  void animateTransition(int from, int to) {
    int gap = (to - from).abs();
    int ms = gap > 1 ? 200 * gap : 500;

    setState(() {
      isInTransition = true;
    });

    _pageController.animateToPage(widget.index,
        duration: Duration(milliseconds: ms), curve: Curves.linear)
      ..then((value) {
        setState(() {
          isInTransition = false;
        });
      });
  }
}
