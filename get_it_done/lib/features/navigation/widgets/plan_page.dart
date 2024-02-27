import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it_done/utils/constants.dart';

class Plan extends StatefulWidget {
  Plan({Key? key}) : super(key: key);

  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _taskStream;

  @override
  void initState() {
    super.initState();
    _taskStream =
        _db.collection('Tasks').orderBy('date', descending: true).snapshots();
  }

  Future<void> _editTask(String taskId, String currentName) async {
    String newName = currentName;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            decoration: InputDecoration(labelText: 'Name'),
            onChanged: (value) => newName = value,
            controller: TextEditingController(text: currentName),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (newName.isNotEmpty) {
                  await _db.collection('Tasks').doc(taskId).update({
                    'name': newName,
                  });
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a name.'),
                    ),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteTask(String taskId) async {
    await _db.collection('Tasks').doc(taskId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _taskStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final tasks = snapshot.data!.docs.map((doc) => doc.data()).toList();

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.5,
                        color: Colors.grey,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  width: MyConstants.screenWidth(context),
                  height: 100,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MyConstants.screenHeight(context),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                "${task["imageUrl"]}",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 10,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 3.0,
                                            ),
                                            child: Text(
                                              "${task["name"]}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        await _editTask(
                                          snapshot.data!.docs[index].id,
                                          task["name"],
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    IconButton(
                                      onPressed: () async {
                                        await _deleteTask(
                                            snapshot.data!.docs[index].id);
                                      },
                                      icon: Icon(
                                        Icons.delete_forever,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
