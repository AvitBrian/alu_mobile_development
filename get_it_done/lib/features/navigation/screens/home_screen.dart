import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it_done/features/authentication/authentication.dart';
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

  void _showAddTaskBottomSheet(BuildContext context) {
    String title = '';
    String imageUrl = '';

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add New Task',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'imageUrl',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: null,
                    onChanged: (value) {
                      imageUrl = value;
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (title.isNotEmpty && imageUrl.isNotEmpty) {
                        // Add task to Firebase
                        await FirebaseFirestore.instance
                            .collection('Tasks')
                            .add({
                          'name': title,
                          'imageUrl': imageUrl,
                          'date': DateTime.now(),
                        });

                        // Close the bottom sheet
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please enter title and details.'),
                          ),
                        );
                      }
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          _showAddTaskBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
