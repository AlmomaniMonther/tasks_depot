import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/screens/home_screen.dart';
import '../widgets/add_task_floating_button.dart';
import '../widgets/app_drawer.dart';
import '../widgets/choose_date.dart';
import '../widgets/dates_tab_bar.dart';

class TabsScreen extends StatefulWidget {
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen>
    with SingleTickerProviderStateMixin {
  List<Tab> tabs = [];
  List<Widget> tabViews = [];
  TabController? _tabController;

  void changeView() {
    for (int i = 0; i < 7; i++) {
      tabs.add(Tab(
          child: Text(
        '${DateTime.now().add(Duration(days: i)).day.toString()}\n${DateFormat('EEE').format(
          DateTime.now().add(Duration(days: i)),
        )}',
        textAlign: TextAlign.center,
        style: const TextStyle(),
      )));
      tabViews.add(HomePage(date: DateTime.now().add(Duration(days: i)).day));
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 7, vsync: this);
    changeView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      //app bar
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: ClipRRect(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(25)),
          child: AppBar(
            centerTitle: true,
            elevation: 25,
            title: const Text('Tasks Depot'),
            actions: const [ChooseDate()],
          ),
        ),
      ),
      floatingActionButton: const AddTaskFloatingButton(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          DatesTabBar(tabController: _tabController, tabs: tabs),
          Expanded(
              child:
                  TabBarView(controller: _tabController, children: tabViews)),
        ],
      ),
    );
  }
}
