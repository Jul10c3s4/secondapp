import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secondapp/pages/brasil_fields/brasil_fields_page.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/textComponent.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:brasil_fields/brasil_fields.dart';

class TabBarViewPage extends StatefulWidget {
  const TabBarViewPage({super.key});

  @override
  State<TabBarViewPage> createState() => _TabBarViewPageState();
}

class _TabBarViewPageState extends State<TabBarViewPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: const DrawerComponent(),
      body: TabBarView(
        controller: tabController,
        children: [
          const BrasilFieldsPage(),
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
      ], controller: tabController, onTap: (int i) => tabController.index = i),
    ) /*ConvexAppBar(
            items: const [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.map, title: 'Discovery'),
              TabItem(icon: Icons.person, title: 'Add'),
            ],
            onTap: (int i) => tabController.jumpToPage(i),
          )*/
        );
  }
}
