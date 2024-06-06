import 'package:flutter/material.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/textComponent.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class PageViewPage extends StatefulWidget {
  const PageViewPage({super.key});

  @override
  State<PageViewPage> createState() => _PageViewPageState();
}

class _PageViewPageState extends State<PageViewPage> {
  int posicaoPagina = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: CustomTitle.buildMainTitle(context, "PageViewPage"),
      ),
      drawer: const DrawerComponent(),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            posicaoPagina = value;
          });
        },
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.purple,
          ),
        ],
      ),
      //interessante usar para criar appbars criativas e bonitas
      bottomNavigationBar: ConvexAppBar.badge(const {
        0: '99+',
        1: Icons.assistant_photo,
        2: Colors.redAccent
      }, items: const [
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.map, title: 'Discovery'),
        TabItem(icon: Icons.add, title: 'Add'),
      ], onTap: (int i) => pageController.jumpToPage(i)),
    ) /*ConvexAppBar(
            items: const [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.map, title: 'Discovery'),
              TabItem(icon: Icons.person, title: 'Add'),
            ],
            onTap: (int i) => pageController.jumpToPage(i),
          )*/
        );
  }
}
