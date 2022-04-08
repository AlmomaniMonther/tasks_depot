import 'package:flutter/material.dart';

class DatesTabBar extends StatelessWidget {
  const DatesTabBar({
    Key? key,
    required TabController? tabController,
    required this.tabs,
  })  : _tabController = tabController,
        super(key: key);

  final TabController? _tabController;
  final List<Tab> tabs;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 20),
      elevation: 5,
      color: const Color.fromARGB(255, 175, 175, 175),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          25.0,
        ),
      ),
      child: TabBar(
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(
              25.0,
            ),
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 0, 38, 255),
              Color.fromARGB(255, 0, 183, 255),
            ])),
        controller: _tabController,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        tabs: tabs,
        isScrollable: true,
      ),
    );
  }
}
