import 'package:flutter/material.dart';
import 'package:get_it_done/utils/constants.dart';

class TasksPage extends StatelessWidget {
  TasksPage({super.key});

  final List<Map> tasks = List.generate(
      5,
      (index) => {
            "id": index,
            "name": "Task ${index + 1}",
            "state": "",
            "photoUrl": ""
          });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Container(
                        constraints: BoxConstraints(
                            maxHeight: MyConstants.screenHeight(context) * 0.8),
                        child: Scaffold(
                          body: Center(
                              child: Text(" State ${tasks[index]["name"]}")),
                        ));
                  },
                  context: context,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black38),
                        width: MyConstants.screenWidth(context),
                        height: 300,
                        child: Column(
                          children: [
                            Expanded(
                                child: Container(
                                    width: MyConstants.screenWidth(context),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "State ${tasks[index]["name"]}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ))),
                            Expanded(
                                child: Text(
                              "Picture ${tasks[index]["name"]}",
                              style: const TextStyle(color: Colors.white),
                            )),
                            Expanded(
                              child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5))),
                                  width: MyConstants.screenWidth(context),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                              width: MyConstants.screenWidth(
                                                  context),
                                              child: Text(
                                                "${tasks[index]["name"]} Details",
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ))),
              ),
            );
          }),
    );
  }
}
