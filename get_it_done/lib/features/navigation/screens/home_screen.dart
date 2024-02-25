import 'package:flutter/material.dart';
import 'package:get_it_done/features/authentication/authentication.dart';
import 'package:get_it_done/features/navigation/widgets/new_task.dart';
import 'package:get_it_done/features/navigation/widgets/plan_page.dart';
import 'package:get_it_done/features/navigation/widgets/tasks_page.dart';
import 'package:get_it_done/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final pages = [Plan(), TasksPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Authentication()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2),
        child: pages[_selectedIndex],
      ),
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: Colors.black87,
          surfaceTintColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Get It Done"),
              ),
              ListTile(
                title: const Text('Get It Done'),
                selected: _selectedIndex == 0,
                onTap: () {
                  _onItemTapped(0);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Container(
          width: MyConstants.screenWidth(context),
          height: 100,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            useLegacyColorScheme: false,
            backgroundColor: Colors.black87,
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.grey,
            iconSize: 30,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.lightbulb_outline_rounded),
                label: 'Plan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline_rounded),
                label: 'Tasks',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewEntry()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
